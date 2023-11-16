// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;

import "forge-std/Test.sol";

import {FeConfig} from "../FeConfig.sol";
import {FeDeployer} from "../FeDeployer.sol";
import {IExample} from "./interfaces/IExample.sol";

contract FeDeployerTest is Test {
    IExample example;

    event ArgumentsUpdated(address indexed one, uint256 indexed two);

    function setUp() public {
        example = IExample(FeDeployer.deploy("test/contracts/Example"));

        // // Backwards-compatible Constructor creation
        // vm.recordLogs();
        // structor = IConstructor(
        //     FeDeployer.deploy_with_args(
        //         "test/contracts/Constructor",
        //         bytes.concat(abi.encode(uint256(0x420)), abi.encode(address(0x420)))
        //     )
        // );
        // Vm.Log[] memory entries = vm.getRecordedLogs();

        // assertEq(entries.length, 1);
        // assertEq(entries[0].topics.length, 3);
        // assertEq(entries[0].topics[0], bytes32(uint256(keccak256("ArgumentsUpdated(address,uint256)"))));
        // assertEq(entries[0].topics[1], bytes32(uint256(uint160(address(0x420)))));
        // assertEq(entries[0].topics[2], bytes32(uint256(0x420)));
    }

    // function testChaining() public {
    //     // Defined Constructor
    //     string memory constructor_macro = "#define macro CONSTRUCTOR() = takes(0) returns (0) {"
    //         "    // Copy the first argument into memory \n"
    //         "    0x20                        // [size] - byte size to copy \n"
    //         "    0x40 codesize sub           // [offset, size] - offset in the code to copy from\n "
    //         "    0x00                        // [mem, offset, size] - offset in memory to copy to \n"
    //         "    codecopy                    // [] \n"
    //         "    // Store the first argument in storage\n"
    //         "    0x00 mload dup1             // [arg1, arg1] \n"
    //         "    [CONSTRUCTOR_ARG_ONE]       // [CONSTRUCTOR_ARG_ONE, arg1, arg1] \n"
    //         "    sstore                      // [arg1] \n"
    //         "    // Copy the second argument into memory \n"
    //         "    0x20                        // [size, arg1] - byte size to copy \n"
    //         "    0x20 codesize sub           // [offset, size, arg1] - offset in the code to copy from \n"
    //         "    0x00                        // [mem, offset, size, arg1] - offset in memory to copy to \n"
    //         "    codecopy                    // [arg1] \n"
    //         "    // Store the second argument in storage \n"
    //         "    0x00 mload dup1             // [arg2, arg2, arg1] \n"
    //         "    [CONSTRUCTOR_ARG_TWO]       // [CONSTRUCTOR_ARG_TWO, arg2, arg2, arg1] \n"
    //         "    sstore                      // [arg2, arg1] \n"
    //         "    // Emit the owner updated event \n"
    //         "    swap1                            // [arg1, arg2] \n"
    //         "    [ARGUMENTS_TOPIC]                // [sig, arg1, arg2] \n"
    //         "    0x00 0x00                        // [0, 0, sig, arg1, arg2] \n"
    //         "    log3                             // [] \n" "}";

    //     // New pattern
    //     vm.recordLogs();
    //     IConstructor chained = IConstructor(
    //         FeDeployer.config().with_args(
    //             bytes.concat(abi.encode(address(0x420)), abi.encode(uint256(0x420)))
    //         ).with_code(constructor_macro).deploy("test/contracts/NoConstructor")
    //     );

    //     Vm.Log[] memory entries = vm.getRecordedLogs();
    //     assertEq(entries.length, 1);
    //     assertEq(entries[0].topics.length, 3);
    //     assertEq(entries[0].topics[0], bytes32(uint256(keccak256("ArgumentsUpdated(address,uint256)"))));
    //     assertEq(entries[0].topics[1], bytes32(uint256(uint160(address(0x420)))));
    //     assertEq(entries[0].topics[2], bytes32(uint256(0x420)));

    //     assertEq(address(0x420), chained.getArgOne());
    //     assertEq(uint256(0x420), chained.getArgTwo());
    // }

    // function testChaining_Create2() public {
    //     // Defined Constructor
    //     string memory constructor_macro = "#define macro CONSTRUCTOR() = takes(0) returns (0) {"
    //         "    // Copy the first argument into memory \n"
    //         "    0x20                        // [size] - byte size to copy \n"
    //         "    0x40 codesize sub           // [offset, size] - offset in the code to copy from\n "
    //         "    0x00                        // [mem, offset, size] - offset in memory to copy to \n"
    //         "    codecopy                    // [] \n" "    // Store the first argument in storage\n"
    //         "    0x00 mload dup1             // [arg1, arg1] \n"
    //         "    [CONSTRUCTOR_ARG_ONE]       // [CONSTRUCTOR_ARG_ONE, arg1, arg1] \n"
    //         "    sstore                      // [arg1] \n" "    // Copy the second argument into memory \n"
    //         "    0x20                        // [size, arg1] - byte size to copy \n"
    //         "    0x20 codesize sub           // [offset, size, arg1] - offset in the code to copy from \n"
    //         "    0x00                        // [mem, offset, size, arg1] - offset in memory to copy to \n"
    //         "    codecopy                    // [arg1] \n" "    // Store the second argument in storage \n"
    //         "    0x00 mload dup1             // [arg2, arg2, arg1] \n"
    //         "    [CONSTRUCTOR_ARG_TWO]       // [CONSTRUCTOR_ARG_TWO, arg2, arg2, arg1] \n"
    //         "    sstore                      // [arg2, arg1] \n" "    // Emit the owner updated event \n"
    //         "    swap1                            // [arg1, arg2] \n"
    //         "    [ARGUMENTS_TOPIC]                // [sig, arg1, arg2] \n"
    //         "    0x00 0x00                        // [0, 0, sig, arg1, arg2] \n"
    //         "    log3                             // [] \n" "}";

    //     // New pattern
    //     vm.recordLogs();
    //     IConstructor chained = IConstructor(
    //         FeDeployer.config_with_create_2(1).with_args(bytes.concat(abi.encode(address(0x420)), abi.encode(uint256(0x420))))
    //             .with_code(constructor_macro).deploy("test/contracts/NoConstructor")
    //     );

    //     Vm.Log[] memory entries = vm.getRecordedLogs();
    //     assertEq(entries.length, 1);
    //     assertEq(entries[0].topics.length, 3);
    //     assertEq(entries[0].topics[0], bytes32(uint256(keccak256("ArgumentsUpdated(address,uint256)"))));
    //     assertEq(entries[0].topics[1], bytes32(uint256(uint160(address(0x420)))));
    //     assertEq(entries[0].topics[2], bytes32(uint256(0x420)));

    //     assertEq(address(0x420), chained.getArgOne());
    //     assertEq(uint256(0x420), chained.getArgTwo());
    // }

    function testArgOne() public {
        assertEq(0, example.get_time());
        example.set_time();
        assertEq(block.timestamp, example.get_time());
    }

    function testArgTwo() public {
        assertEq(address(0x420), example.get_beneficiary());
    }

    // function testBytecode() public {
    //     bytes memory b = bytes(
    //         hex"5f3560e01c80633fb5c1cb1461001b578063f2c9ecd814610021575b6004355f555b5f545f5260205ff3"
    //     );
    //     assertEq(getCode(address(number)), b);
    // }

    // function testWithValueDeployment() public {
    //     uint256 value = 1 ether;
    //     FeDeployer.config().with_value(value).deploy{value: value}(
    //         "test/contracts/ConstructorNeedsValue"
    //     );
    // }

    // function testWithValueDeployment_Create2() public {
    //     uint256 value = 1 ether;
    //     FeDeployer.config_with_create_2(1).with_value(value).deploy{value: value}("test/contracts/ConstructorNeedsValue");
    // }

    // function testConstantOverride() public {
    //     // Test address constant
    //     address a = 0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF;
    //     address deployed = FeDeployer.config().with_addr_constant("a", a).with_constant(
    //         "b", "0x420"
    //     ).deploy("test/contracts/ConstOverride");
    //     assertEq(getCode(deployed), hex"73DeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF610420");

    //     // Test uint constant
    //     address deployed_2 = FeDeployer.config().with_uint_constant("a", 32).with_constant(
    //         "b", "0x420"
    //     ).deploy("test/contracts/ConstOverride");
    //     assertEq(getCode(deployed_2), hex"6020610420");

    //     // Test bytes32 constant
    //     address deployed_3 = FeDeployer.config().with_bytes32_constant("a", bytes32(hex"01"))
    //         .with_constant("b", "0x420").deploy("test/contracts/ConstOverride");
    //     assertEq(
    //         getCode(deployed_3),
    //         hex"7f0100000000000000000000000000000000000000000000000000000000000000610420"
    //     );

    //     // Keep default "a" value and assign "b", which is unassigned in "ConstOverride.fe"
    //     address deployed_4 =
    //         FeDeployer.config().with_constant("b", "0x420").deploy("test/contracts/ConstOverride");
    //     assertEq(getCode(deployed_4), hex"6001610420");
    // }

    // function testConstantOverride_Create2() public {
    //     // Test address constant
    //     address a = 0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF;
    //     address deployed = FeDeployer.config_with_create_2(1).with_addr_constant("a", a).with_constant("b", "0x420").deploy(
    //         "test/contracts/ConstOverride"
    //     );
    //     assertEq(getCode(deployed), hex"73DeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF610420");

    //     // Test uint constant
    //     address deployed_2 = FeDeployer.config_with_create_2(2).with_uint_constant("a", 32).with_constant("b", "0x420").deploy(
    //         "test/contracts/ConstOverride"
    //     );
    //     assertEq(getCode(deployed_2), hex"6020610420");

    //     // Test bytes32 constant
    //     address deployed_3 = FeDeployer.config_with_create_2(3).with_bytes32_constant("a", bytes32(hex"01")).with_constant(
    //         "b", "0x420"
    //     ).deploy("test/contracts/ConstOverride");
    //     assertEq(getCode(deployed_3), hex"7f0100000000000000000000000000000000000000000000000000000000000000610420");

    //     // Keep default "a" value and assign "b", which is unassigned in "ConstOverride.fe"
    //     address deployed_4 = FeDeployer.config_with_create_2(4).with_constant("b", "0x420").deploy("test/contracts/ConstOverride");
    //     assertEq(getCode(deployed_4), hex"6001610420");
    // }

    // function getCode(address who) internal view returns (bytes memory o_code) {
    //     /// @solidity memory-safe-assembly
    //     assembly {
    //         // retrieve the size of the code, this needs assembly
    //         let size := extcodesize(who)
    //         // allocate output byte array - this could also be done without assembly
    //         // by using o_code = new bytes(size)
    //         o_code := mload(0x40)
    //         // new "memory end" including padding
    //         mstore(0x40, add(o_code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
    //         // store length in memory
    //         mstore(o_code, size)
    //         // actually retrieve the code, this needs assembly
    //         extcodecopy(who, add(o_code, 0x20), 0, size)
    //     }
    // }

    // function testSet(uint256 num) public {
    //     number.setNumber(num);
    //     assertEq(num, number.getNumber());
    // }

    // function testConstructorDefaultCaller() public {
    //     FeConfig config = FeDeployer.config();
    //     IRememberCreator rememberer = IRememberCreator(config.deploy("test/contracts/RememberCreator"));
    //     assertEq(rememberer.CREATOR(), address(config));
    // }

    // function runTestConstructorCaller(address deployer) public {
    //     IRememberCreator rememberer = IRememberCreator(
    //         FeDeployer
    //             .config()
    //             .with_deployer(deployer)
    //             .deploy("test/contracts/RememberCreator")
    //     );
    //     assertEq(rememberer.CREATOR(), deployer);
    // }

    // // @dev fuzzed test too slow, random examples and address(0) chosen
    // function testConstructorCaller() public {
    //     runTestConstructorCaller(address(uint160(uint256(keccak256("random addr 1")))));
    //     runTestConstructorCaller(address(uint160(uint256(keccak256("random addr 2")))));
    //     runTestConstructorCaller(address(0));
    //     runTestConstructorCaller(address(uint160(0x1000)));
    // }

    // /// @dev test that compilation is different with new evm versions
    // function testSettingEVMVersion() public {
    //     /// expected bytecode for EVM version "paris"
    //     bytes memory expectedParis = hex"6000";
    //     FeConfig config = FeDeployer.config().with_evm_version("paris");
    //     address withParis = config.deploy("test/contracts/EVMVersionCheck");

    //     bytes memory parisBytecode = withParis.code;
    //     assertEq(parisBytecode, expectedParis);

    //     /// expected bytecode for EVM version "shanghai" | default
    //     bytes memory expectedShanghai = hex"5f";
    //     FeConfig shanghaiConfig = FeDeployer.config().with_evm_version("shanghai");
    //     address withShanghai = shanghaiConfig.deploy("test/contracts/EVMVersionCheck");
    //     bytes memory shanghaiBytecode = withShanghai.code;
    //     assertEq(shanghaiBytecode, expectedShanghai);

    //     /// Default should be shanghai (latest)
    //     FeConfig defaultConfig = FeDeployer.config().with_evm_version("");
    //     address withDefault = defaultConfig.deploy("test/contracts/EVMVersionCheck");

    //     bytes memory defaultBytecode = withDefault.code;
    //     assertEq(defaultBytecode, expectedShanghai);
    // }
}
