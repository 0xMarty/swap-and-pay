const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log('Deploying contracts with the account: ' + deployer.address);

    const owner = "0xB1B0Ed79F4422553694e7fb16D5e7dCd6a2F3587";
    
    const SwapAndPay = await ethers.getContractFactory("SwapAndPay");
    const swapAndPay = await SwapAndPay.deploy(owner);

    console.log("Swap And Pay: " + swapAndPay.address);
}

main()
    .then(() => process.exit())
    .catch(error => {
        console.error(error);
        process.exit(1);
})