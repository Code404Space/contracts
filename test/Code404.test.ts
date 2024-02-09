import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Code404", function () {
  async function deployCode404() {
    const [governor, user] = await ethers.getSigners();

    const Code404 = await ethers.getContractFactory("Code404");
    const code404 = await Code404.deploy(governor);

    return { code404, governor, user };
  }

  describe("Token", function () {
    it("Should have ERC20 attributes", async function () {
      const { code404 } = await loadFixture(deployCode404);

      expect(await code404.name()).to.equal("Code 404");
      expect(await code404.symbol()).to.equal("CODE404");
      expect(await code404.decimals()).to.equal(18);
      expect(await code404.totalSupply()).to.equal(
        BigInt((1e18).toString()) * 10000n
      );
    });
  });
});
