// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "src/CounterV1.sol";

contract DeployCounter is Script {
    function run() external {
        vm.startBroadcast();

        // msg.sender (the broadcast signer) becomes ProxyAdmin owner
        address proxy = Upgrades.deployTransparentProxy(
            "CounterV1.sol",
            msg.sender,
            abi.encodeCall(CounterV1.initialize, (0))
        );

        console2.log("Counter proxy:", proxy);
        vm.stopBroadcast();
    }
}