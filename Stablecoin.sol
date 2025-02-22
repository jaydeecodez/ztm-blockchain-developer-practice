// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC20} from "./ERC20.sol";
import {DepositorCoin} from "./DepositorCoin.sol";

contract StableCoin is ERC20 {
    DepositorCoin public depositorCoin;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) ERC20(_name, _symbol, _decimals) {}
}
