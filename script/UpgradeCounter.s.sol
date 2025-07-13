// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "src/CounterV1.sol";

contract UpgradeCounter is Script {
    function run() external {
        address proxy = vm.envAddress("COUNTER_PROXY"); // set in .env

        vm.startBroadcast();
        Upgrades.upgradeProxy(proxy, "CounterV1.sol", "");
        vm.stopBroadcast();
    }
}