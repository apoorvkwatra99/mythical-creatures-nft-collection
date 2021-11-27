# Mythical Creatures NFT Collection

The project can be viewed here: https://mythical-creatures-nft-collection.apoorvk.repl.co/

This Buildspace project runs on the Rinkeby Test Network. A Metamask wallet with some Ethereum on this test network is all that is needed to test it out! Once a user clicks the link, they can connect their Metamask wallet and then mint an NFT from the Mythical Creatures NFT Collection. Once the NFT has been minted, an alert will provide the user with a link to view their NFT on OpenSea. The user can also click the "NFT Collection" button to view the entire NFT collection on OpenSea.

# Backend

The backend folder is where all the smart contract code lives. `contracts/MyEpicNFT.sol` contains the contract `MyEpicNFT` and has several helper functions. This contract essentially just mints NFTs to the relevant user.

# Frontend

The frontend folder contains all the code written on Replit. It builds out the actual web page that is linked at the top of this file and calls the contract in the backend. `src/App.js` contains most of the code written here.
