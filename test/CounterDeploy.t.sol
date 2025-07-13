// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import {Upgrades}  from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "src/CounterV1.sol";

contract CounterDeployTest is Test {
    CounterV1 counter;

    function setUp() public {
        address proxy = Upgrades.deployTransparentProxy(
            "CounterV1.sol",
            address(this), // proxy admin
            abi.encodeCall(CounterV1.initialize, (5))
        );
        counter = CounterV1(payable(proxy));
    }

    function testIncrementV1() public {
        counter.increment();
        assertEq(counter.number(), 6);
    }
}