const { ethers, upgrades } = require("hardhat");

// proxy address
const myContractProxyAddr = "0xBC0BC18165Ee60AE55521CD903aB30b08A6d4f6d"

async function main() {
    const MyContractV2 = await ethers.getContractFactory("MyContractV2");
    // update
    const myContractV2 = await upgrades.upgradeProxy(myContractProxyAddr, MyContractV2);

    console.log("myContractV2 upgraded");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
