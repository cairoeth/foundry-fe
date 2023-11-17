// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IExample {
    event Context();

    function get_beneficiary() external view returns (address);
    function get_time() external view returns (uint256);
    function set_beneficiary(address addr) external payable;
    function set_time() external payable;
}
