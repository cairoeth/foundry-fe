// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {FeConfig} from "./FeConfig.sol";

library FeDeployer {
    /// @notice Create a new fe config
    function config() public returns (FeConfig) {
        return new FeConfig();
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @return The address that the contract was deployed to
    function deploy(
        string memory fileName,
        string memory contractName
    ) internal returns (address) {
        return config().deploy(fileName, contractName);
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @return The address that the contract was deployed to
    function broadcast(
        string memory fileName,
        string memory contractName
    ) internal returns (address) {
        return config().set_broadcast(true).deploy(fileName, contractName);
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @param value - Value to deploy with
    /// @return The address that the contract was deployed to
    function deploy_with_value(
        string memory fileName,
        string memory contractName,
        uint256 value
    ) internal returns (address) {
        return config().with_value(value).deploy(fileName, contractName);
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @param value - Value to deploy with
    /// @return The address that the contract was deployed to
    function broadcast_with_value(
        string memory fileName,
        string memory contractName,
        uint256 value
    ) internal returns (address) {
        return
            config().set_broadcast(true).with_value(value).deploy(
                fileName,
                contractName
            );
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @param args - Constructor Args to append to the bytecode
    /// @return The address that the contract was deployed to
    function deploy_with_args(
        string memory fileName,
        string memory contractName,
        bytes memory args
    ) internal returns (address) {
        return config().with_args(args).deploy(fileName, contractName);
    }

    /// @notice Compiles a Fe contract and returns the address that the contract was deployeod to
    /// @param fileName - The file name of the Fe contract (e.g. "src/SimpleStore.sol")
    /// @param contractName - The contract name inside the file (eg. "SimpleStore")
    /// @param args - Constructor Args to append to the bytecode
    /// @return The address that the contract was deployed to
    function broadcast_with_args(
        string memory fileName,
        string memory contractName,
        bytes memory args
    ) internal returns (address) {
        return
            config().set_broadcast(true).with_args(args).deploy(
                fileName,
                contractName
            );
    }
}
