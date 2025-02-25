const { ethers } = require("hardhat"); // Pastikan ethers diimpor dengan benar

async function main() {
    const TicketNFT = await ethers.getContractFactory("TicketNFT");

    // Gunakan ethers.parseEther tanpa "utils"
    const ticketNFT = await TicketNFT.deploy(ethers.parseEther("0.05"));

    await ticketNFT.waitForDeployment();

    console.log("TicketNFT deployed to:", await ticketNFT.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
