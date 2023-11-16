// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;

interface IExample {
    function get_beneficiary() external view returns (address);
    function get_time() external view returns (uint256);
    function set_beneficiary(address addr) external;
    function set_time() external;
}
