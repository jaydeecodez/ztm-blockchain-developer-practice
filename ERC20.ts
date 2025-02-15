import { ethers, network } from "hardhat";
import { expect } from "chai";

import { smock } from "@defi-wonderland/smock";
import { ERC20__factory } from "../typechain-types";

import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";

describe("ERC20", function () {
    let alice: HardhatEthersSigner,
        bob: HardhatEthersSigner,
        erc20Token: MockContract<ERC20>;

    this.beforeEach(async function () {
        [alice, bob] = await ethers.getSigners();

        const ERC20 = await smock.mock<ERC20__factory>("ERC20");
        let erc20Token = await ERC20.deploy("Name", "SYM", 18);

        await erc20Token.setVariable("balanceOf", {
            [alice.address]: 300,
        });
        await network.provider.send("evm_mine");
    })

    it("transfers tokens correctly", async function () {
        await expect(
            await erc20Token.transfer(bob.address, 100)
        ).to.changeTokenBalances(erc20Token, [alice, bob], [-100, 100]);

        await expect(
            await erc20Token.connect(bob).transfer(alice.address, 50)
        ).to.changeTokenBalances(erc20Token, [alice, bob], [50, -50]);

    });

    it("should revert if sender has insufficient balance", async function () {
        await expect(
            erc20Token.transfer(bob.address, 400)
        ).to.be.revertedWith("ERC20: Insufficient sender balance 2");
    })

    it("should emit Transfer event on transfers", async function () {
        await expect(
            erc20Token.transfer(bob.address, 200)
        ).to.emit(
            erc20Token, "Transfer"
        ).withArgs(alice.address, bob.address, 200);
    })

});
