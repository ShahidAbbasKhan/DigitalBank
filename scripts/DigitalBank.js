
const hre = require("hardhat");

async function main() {
 

  const DigitalBank = await hre.ethers.getContractFactory("DigitalBank");
  const digiBank = await DigitalBank.deploy();

  await digiBank.deployed();

  console.log(
    `contract Deloyed to address ${digiBank.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
