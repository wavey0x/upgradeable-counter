// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import {Upgrades}  from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "src/CounterV1.sol";
import {CounterV2} from "src/CounterV2.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract CounterUpgradeTest is Test {
    CounterV1 counterV1;
    address   proxy;

    function setUp() public {
        CounterV1 impl = new CounterV1();
        
        bytes memory init = abi.encodeCall(CounterV1.initialize, (5));
        proxy = address(new TransparentUpgradeableProxy(
            address(impl),
            address(this),
            init
        ));

        counterV1 = CounterV1(payable(proxy));
    }

    function testUpgradeToV2() public {
        // Pre upgrade
        counterV1.increment();
        assertEq(counterV1.number(), 6);

        // Upgrade
        Upgrades.upgradeProxy(proxy, "CounterV2.sol", "");

        // Post upgrade
        CounterV2 counterV2 = CounterV2(payable(proxy));
        counterV2.decrement();
        assertEq(counterV2.number(), 5);
    }
}