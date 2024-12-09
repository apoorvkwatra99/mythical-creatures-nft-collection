 /**
* @type import('hardhat/config').HardhatUserConfig
*/

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.0", // or "0.8.19" or any compatible 0.8.x version
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.1", // For contracts that require 0.8.1 or above
      },
    ],
  },
   defaultNetwork: "sepolia",
   networks: {
      hardhat: {},
      sepolia: {
         chainId: 11155111,
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      }
   },
}