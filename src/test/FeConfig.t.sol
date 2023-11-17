// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;

import "forge-std/Test.sol";

import {FeConfig} from "../FeConfig.sol";

contract FeConfigTest is Test {
    FeConfig public config;

    function setUp() public {
        config = new FeConfig();
    }

    function testWithArgs(bytes memory some) public {
        config.with_args(some);
        assertEq(config.args(), some);
    }

    function testWithValue(uint256 value) public {
        config.with_value(value);
        assertEq(config.value(), value);
    }

    function testSetBroadcast(bool broadcast) public {
        config.set_broadcast(broadcast);
        bool b = config.should_broadcast();
        assertEq(b, broadcast);
    }
}
