// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC20} from "./ERC20.sol";
import {DepositorCoin} from "./DepositorCoin.sol";
import {Oracle} from "./Oracle.sol";

contract StableCoin is ERC20 {
    DepositorCoin public depositorCoin;
    Oracle public oracle;
    uint256 public feeRatePercentage;

    constructor(
        string memory _name,
        string memory _symbol,
        Oracle _oracle,
        uint256 _feeRatePercentage
    ) ERC20(_name, _symbol, 18) {
        oracle = _oracle;
        feeRatePercentage = _feeRatePercentage;
    }

    function mint() external payable {
        uint256 fee = _getFee(msg.value);
        uint256 mintStablecoinAmount = (msg.value - fee) * oracle.getPrice();
        _mint(msg.sender, mintStablecoinAmount);
    }

    function burn(uint256 burnStablecoinAmount) external {
        _burn(msg.sender, burnStablecoinAmount);

        uint256 refundingEth = burnStablecoinAmount / oracle.getPrice();

        uint256 fee = _getFee(refundingEth);

        (bool success, ) = msg.sender.call{value: (refundingEth - fee)}("");
        require(success, "STC: Burn refund transaction failed");
    }

    function _getFee(uint256 ethAmount) private view returns (uint256) {
        return (ethAmount * feeRatePercentage) / 100;
    }

    function depositCollateralBuffer() external payable {
        uint256 surplusInUsd = _getSurplusInContractUsd();

        uint256 usdInDpcPrice;

        if (surplusInUsd == 0) {
            depositorCoin = new DepositorCoin("Depositor Coin", "DPC");
            // new surplus: msg.value * oracle.getPrice();

            usdInDpcPrice = 1;
        } else {
            // usdInDpcPrice = 250 / 500 = 0.5
            usdInDpcPrice = depositorCoin.totalSupply() / surplusInUsd;
        }

        // 0.5e18 * 1000 * 0.5 = 250e18
        uint256 mintDepositorCoinAmount = msg.value *
            oracle.getPrice() *
            usdInDpcPrice;
        depositorCoin.mint(msg.sender, mintDepositorCoinAmount);
    }

    function withdrawCollateralBuffer(
        uint256 burnDepositorCoinAmount
    ) external {
        uint256 surplusInUsd = _getSurplusInContractUsd();

        depositorCoin.burn(msg.sender, burnDepositorCoinAmount);

        // usdInDpcPrice = 250 / 500 = 0.5
        uint256 usdInDpcPrice = depositorCoin.totalSupply() / surplusInUsd;

        // 125 / 0.5 = 250
        uint256 refundingUsd = burnDepositorCoinAmount / usdInDpcPrice;

        // 250 / 1000 = 0.25 ETH
        uint256 refundingEth = refundingUsd / oracle.getPrice();

        (bool success, ) = msg.sender.call{value: refundingEth}("");
        require(success, "STC: Withdraw collateral buffer transaction failed");
    }

    function _getSurplusInContractUsd() private view returns (uint256) {
        uint256 ethContractBalanceInUsd = (address(this).balance - msg.value) *
            oracle.getPrice();

        uint256 totalStableCoinBalanceInUsd = totalSupply;

        uint256 surplus = ethContractBalanceInUsd - totalStableCoinBalanceInUsd;
        return surplus;
    }
}
