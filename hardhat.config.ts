import { createRequire } from "node:module";
import { defineConfig } from "hardhat/config";
import hardhatEthers from "@nomicfoundation/hardhat-ethers";

const require = createRequire(import.meta.url);

export default defineConfig({
  plugins: [hardhatEthers],
  solidity: {
    version: "0.8.28",
    path: require.resolve("solc/soljson.js"),
  },
  networks: {
    localhost: {
      type: "http",
      url: "http://127.0.0.1:8545",
      chainId: 31337,
    },
  },
});
