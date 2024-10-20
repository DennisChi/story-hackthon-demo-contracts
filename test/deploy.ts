import { ethers } from "hardhat";

async function main() {
  const PassportRegistry = await ethers.getContractFactory("PassportRegistry");
  console.log("Deploying PassportRegistry...");
  const passportRegistry = await PassportRegistry.deploy();
  await passportRegistry.deployed();
  console.log("PassportRegistry deployed to:", passportRegistry.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
