import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    story: {
      accounts: [process.env.PRIVATE_KEY!],
      url: "https://testnet.storyrpc.io",
    },
  },
};

export default config;
