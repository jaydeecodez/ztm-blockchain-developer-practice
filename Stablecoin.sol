// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC20} from "./ERC20.sol";
import {DepositorCoin} from "./DepositorCoin.sol";

contract StableCoin is ERC20 {
    DepositorCoin public depositorCoin;

    constructor(
        string memory _name,
        string memory _symbol,
    ) ERC20(_name, _symbol, 18) {}

    function mint() external payable {
        msg.value;

        uint256 ethUsdPrice = 1000;
        uint256 mintStablecoinAmount = msg.value * ethUsdPrice;
        _mint(msg.sender, mintStablecoinAmount);
    }
}
