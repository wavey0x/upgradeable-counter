// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {CounterV1} from "src/CounterV1.sol";

/// @custom:oz-upgrades-from CounterV1
contract CounterV2 is CounterV1 {
    function decrement() public {
        number -= 1;
    }
}