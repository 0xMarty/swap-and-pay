const { ethers } = require("hardhat");
const { expect } = require("chai");

describe('SwapAndPay', () => {

    let
    deployer,
    owner,
    payee,
    SwapAndPay


    beforeEach(async () => {

        [deployer, owner, payee] = await ethers.getSigners();

        SwapAndPay = await ethers.getContractFactory('SwapAndPay');
        SwapAndPay = await SwapAndPay.deploy(owner.address);

    });

    describe('constructor()', () => {
        it('should set initial owner address correctly', async () => {
            expect(await SwapAndPay.owner()).to.equal(owner.address);
        });
    });

    describe('pay()', () => {

    });
});