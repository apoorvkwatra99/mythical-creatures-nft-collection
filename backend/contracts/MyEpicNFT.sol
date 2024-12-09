// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string svgPartOne = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string svgPartTwo = "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    string[] adjectives = ["Mighty", "Curious", "Scary", "Happy", "Epic", "Giant", "Funny", "Tiny", "Chill", "Quiet", "Loud", "Elite", "Swift", "Witty", "Lumbering", "Quick", "Wise", "Fearless", "Tough", "Supreme"];
    string[] colors = ["Red", "Blue", "Green", "Purple", "Orange", "Yellow", "Black", "White", "Brown", "Gray", "Pink", "Gold", "Silver", "Transparent", "Invisble"];
    string[] creatures = ["Unicorn", "Mermaid", "Werewolf", "Fairy", "Sphinx", "Centaur", "Yeti", "Leprechaun", "Gnome", "Pixie", "Troll", "Cyclops", "Ogre", "Goblin", "Vampire", "Zombie", "Basilisk", "Griffin", "Dragon", "Pegasus"];
    string[] backgrounds = ["red", "#08C2A8", "black", "yellow", "blue", "green"];
    uint256 nftCount = 0;
    uint256 constant TOTAL_MINT_COUNT = 50;
    event NewEpicNFTMinted(address sender, uint256 tokenId, uint256 nftCount);

    constructor() ERC721 ("Mythical Creatures", "MYTH") {
        console.log("This is my NFT contract. Ohhhh Yeahhhhh!");
    }

    function makeAnEpicNFT() public {
        if (nftCount >= TOTAL_MINT_COUNT) {
            console.log("All %d NFTs have already been minted.", TOTAL_MINT_COUNT);
            return;
        }
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomAdjective(newItemId);
        string memory second = pickRandomColor(newItemId);
        string memory third = pickRandomCreature(newItemId);
        string memory combinedWord = string(abi.encodePacked(first, second, third));
        string memory background = pickRandomBackground(newItemId);

        string memory finalSvg = string(abi.encodePacked(svgPartOne, background, svgPartTwo, combinedWord, "</text></svg>"));
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "A mythical creature", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        nftCount++;
        emit NewEpicNFTMinted(msg.sender, newItemId, nftCount);
    }

    function pickRandomAdjective(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("ADJECTIVE", Strings.toString(tokenId))));
        rand = rand % adjectives.length;
        return adjectives[rand];
    }

    function pickRandomColor(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
        rand = rand % colors.length;
        return colors[rand];
    }

    function pickRandomCreature(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("CREATURE", Strings.toString(tokenId))));
        rand = rand % creatures.length;
        return creatures[rand];
    }

    function pickRandomBackground(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("BACKGROUND", Strings.toString(tokenId))));
        rand = rand % backgrounds.length;
        return colors[rand];
    }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }
}