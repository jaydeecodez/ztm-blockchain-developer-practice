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

        await expect(
            await erc20Token.transfer(bob.address, 100)
        ).to.changeTokenBalances(erc20Token, [alice, bob], [-100, 100]);
    });
});
