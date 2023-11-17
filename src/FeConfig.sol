// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Vm} from "forge-std/Vm.sol";
import {strings} from "stringutils/strings.sol";

contract FeConfig {
    using strings for *;

    /// @notice Initializes cheat codes in order to use ffi to compile Fe contracts
    Vm public constant vm =
        Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    /// @notice arguments to append to the bytecode
    bytes public args;

    /// @notice value to deploy the contract with
    uint256 public value;

    /// @notice whether to broadcast the deployment tx
    bool public should_broadcast;

    /// @notice Build the Contract
    function build(string memory file) public {
        string[] memory command = new string[](3);
        command[0] = "fe build";
        command[1] = file;
        command[2] = "--overwrite";
        bytes memory retData = vm.ffi(command);

        if (string(retData).toSlice().startsWith("Compiled".toSlice())) {
            return;
        }

        revert(string.concat("Build failed: ", string(retData)));
    }

    /// @notice Deploy the Contract
    function deploy(
        string memory file,
        string memory contractName
    ) public returns (address) {
        bytes memory concatenated = creation_code_with_args(file, contractName);

        address deployedAddress;
        if (should_broadcast) vm.broadcast();
        assembly {
            let val := sload(value.slot)
            deployedAddress := create(
                val,
                add(concatenated, 0x20),
                mload(concatenated)
            )
        }

        require(
            deployedAddress != address(0),
            "FeDeployer could not deploy contract"
        );

        return deployedAddress;
    }

    /// @notice sets the amount of wei to deploy the contract with
    function with_value(uint256 value_) public returns (FeConfig) {
        value = value_;
        return this;
    }

    /// @notice sets the arguments to be appended to the bytecode
    function with_args(bytes memory args_) public returns (FeConfig) {
        args = args_;
        return this;
    }

    /// @notice sets whether to broadcast the deployment
    function set_broadcast(bool broadcast) public returns (FeConfig) {
        should_broadcast = broadcast;
        return this;
    }

    /// @notice get creation code of a contract plus encoded arguments
    function creation_code_with_args(
        string memory file,
        string memory contractName
    ) public payable returns (bytes memory bytecode) {
        bytecode = creation_code(file, contractName);
        return bytes.concat(bytecode, args);
    }

    /// @notice Get the creation bytecode of a contract
    function creation_code(
        string memory file,
        string memory contractName
    ) public payable returns (bytes memory bytecode) {
        build(file);

        string[] memory command = new string[](255);
        command[0] = "cat output/";
        command[1] = contractName;
        command[2] = "/";
        command[3] = contractName;
        command[4] = ".bin";
        bytecode = vm.ffi(command);

        if (bytecode.length != 0) return bytecode;

        revert(
            string.concat(
                "Could not find bytecode for ",
                contractName,
                " contract"
            )
        );
    }
}
