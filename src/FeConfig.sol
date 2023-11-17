// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console2} from "forge-std/Test.sol";
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
    function build(string memory fileName, string memory contractName) public {
        string[] memory buildCommand = new string[](4);
        buildCommand[0] = "fe";
        buildCommand[1] = "build";
        buildCommand[2] = fileName;
        buildCommand[3] = "--overwrite";
        Vm.FfiResult memory buildResult = vm.tryFfi(buildCommand);
        if (buildResult.exitCode != 0)
            revert(string.concat("Build failed: ", string(buildResult.stderr)));

        _toInterface(contractName);
    }

    /// @notice Deploy the Contract
    function deploy(
        string memory fileName,
        string memory contractName
    ) public returns (address) {
        bytes memory concatenated = creation_code_with_args(
            fileName,
            contractName
        );

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
        string memory fileName,
        string memory contractName
    ) public payable returns (bytes memory bytecode) {
        bytecode = creation_code(fileName, contractName);
        return bytes.concat(bytecode, args);
    }

    /// @notice Get the creation bytecode of a contract
    function creation_code(
        string memory fileName,
        string memory contractName
    ) public payable returns (bytes memory bytecode) {
        build(fileName, contractName);

        string[] memory codeCommand = new string[](2);
        codeCommand[0] = "cat";
        codeCommand[1] = _binary(contractName);

        Vm.FfiResult memory codeResult = vm.tryFfi(codeCommand);
        if (codeResult.exitCode != 0)
            revert(string.concat("Build failed: ", string(codeResult.stderr)));

        return codeResult.stdout;
    }

    /// @notice Bytecode binary file
    function _binary(
        string memory contractName
    ) private pure returns (string memory) {
        return string.concat(_output(contractName), ".bin");
    }

    /// @notice ABI file
    function _abi(
        string memory contractName
    ) private pure returns (string memory) {
        return string.concat(_output(contractName), "_abi.json");
    }

    /// @notice Interface file
    function _interface(
        string memory contractName
    ) private pure returns (string memory) {
        return string.concat(_output(contractName), ".sol");
    }

    /// @notice Output directory
    function _output(
        string memory contractName
    ) private pure returns (string memory) {
        return string.concat("output/", contractName, "/", contractName);
    }

    /// @notice Convert ABI file to Solidity interface
    function _toInterface(string memory contractName) private {
        string[] memory interfaceCommand = new string[](5);
        interfaceCommand[0] = "cast";
        interfaceCommand[1] = "interface";
        interfaceCommand[2] = "--name";
        interfaceCommand[3] = string.concat("I", contractName);
        interfaceCommand[4] = _abi(contractName);

        Vm.FfiResult memory interfaceResult = vm.tryFfi(interfaceCommand);
        if (interfaceResult.exitCode != 0)
            revert(
                string.concat("Build failed: ", string(interfaceResult.stderr))
            );

        string[] memory writeCommand = new string[](3);
        writeCommand[0] = "./lib/foundry-fe/scripts/file_writer.sh";
        writeCommand[1] = _interface(contractName);
        writeCommand[2] = string(interfaceResult.stdout);

        Vm.FfiResult memory writeResult = vm.tryFfi(writeCommand);
        if (writeResult.exitCode != 0)
            revert(string.concat("Build failed: ", string(writeResult.stderr)));
    }
}
