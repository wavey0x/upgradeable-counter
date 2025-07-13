// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title Counter (upgrade-safe)
contract CounterV1 is Initializable {
    uint256 public number;

    /// @notice initializer replaces the constructor
    function initialize(uint256 _start) public initializer {
        number = _start;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number += 1;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); // lock the impl
    }
}