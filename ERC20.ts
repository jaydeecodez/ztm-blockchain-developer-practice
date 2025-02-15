import { ethers, network } from "hardhat";
import { expect } from "chai";

import { smock } from "@defi-wonderland/smock";
import { ERC20__factory } from "../typechain-types";

describe("ERC20", function () {
    it("transfers tokens correctly", async function () {
        const [alice, bob] = await ethers.getSigners();

        const ERC20 = await smock.mock<ERC20__factory>("ERC20");
        const erc20Token = await ERC20.deploy("Name", "SYM", 18);

        await erc20Token.setVariable("balanceOf", {
            [alice.address]: 300,
        });
        await network.provider.send("evm_mine");

        console.log(
            "Alice balance here is",
            (await erc20Token.balanceOf(alice.address)).toString()
        );

        await expect(
            await erc20Token.transfer(bob.address, 100)
        ).to.changeTokenBalances(erc20Token, [alice, bob], [-100, 100]);

        await expect(
            await erc20Token.connect(bob).transfer(alice.address, 50)
        ).to.changeTokenBalances(erc20Token, [alice, bob], [50, -50]);

    });

    it.only("should revert if sender has insufficient balance", async function () {
        const [alice, bob] = await ethers.getSigners();

        const ERC20 = await smock.mock<ERC20__factory>("ERC20");
        const erc20Token = await ERC20.deploy("Name", "SYM", 18);

        await erc20Token.setVariable("balanceOf", {
            [alice.address]: 300,
        });
        await network.provider.send("evm_mine");

        await expect(
            erc20Token.transfer(bob.address, 400)
        ).to.be.revertedWith("ERC20: Insufficient sender balance 2");
    })
});
