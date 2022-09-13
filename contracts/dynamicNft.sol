// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicNft is ERC721, PullPayment, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private currentTokenId;

    uint256 public interval;
    uint256 public lastTimeStamp;
    uint256 public maxSupply = 10000;
    uint256 public cost = 0 ether;

    /// @dev Base token URI used as a prefix by tokenURI()
    string public baseTokenURI;

    /// @dev Metadata information for each stage of the NFT on IPFS.
    string[] IpfsUri = [
        "https://bafybeifmxomyuadb2fm6rjkp3mh6hgbunrvysfzjjmjcz6pumagbpvht64.ipfs.nftstorage.link/metadata/1",
        "https://bafybeifmxomyuadb2fm6rjkp3mh6hgbunrvysfzjjmjcz6pumagbpvht64.ipfs.nftstorage.link/metadata/2",
        "https://bafybeifmxomyuadb2fm6rjkp3mh6hgbunrvysfzjjmjcz6pumagbpvht64.ipfs.nftstorage.link/metadata/3"
    ];

    constructor(uint256 _interval) ERC721("DynamicNft", "DNFT") {
        baseTokenURI = "";
        interval = _interval;
        lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        returns (
            bool upkeepNeeded,
            bytes memory /* performData */
        )
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        // We don't use the checkData in this example. The checkData is defined when the Upkeep was registered.
    }

    function performUpkeep(
        bytes calldata /* performData */
    ) external {
        //We highly recommend revalidating the upkeep in the performUpkeep function
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;
            updateDynamicMetadatas();
        }
        // We don't use the performData in this example. The performData is generated by the Keeper's call to your checkUpkeep function
    }

    function mintCard() public payable {
        require(currentTokenId.current() <= maxSupply, "Max supply exceeded!");
        require(msg.value >= cost, "Not enough ETH!");
        currentTokenId.increment();
        _safeMint(msg.sender, currentTokenId.current());
    }

    /// @dev Returns an URI for a given token ID
    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    /// @dev Sets the base token URI prefix
    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    /// @dev Sets the cost for minting
    function setCost(uint256 _cost) public onlyOwner {
        cost = _cost;
    }

    /// @dev Increments the max supply
    function incrementMaxSupply() public onlyOwner {
        maxSupply += 10000;
    }

    /// @dev Overridden in order to make it an onlyOwner function
    function withdrawPayments(address payable payee)
        public
        virtual
        override
        onlyOwner
    {
        super.withdrawPayments(payee);
    }

    /// -- TO DO -- @dev Updates the metadatas in terms of market state
    function updateDynamicMetadatas() public {
        if (marketState() < X) {
            string memory newUri = IpfsUri[0];
        }
        if (X < marketState() < Y) {
            string memory newUri = IpfsUri[1];
        }
        if (marketState() > Y) {
            string memory newUri = IpfsUri[2];
        }
    }

    /// -- TO DO -- @dev Determins the market state with the read of coinmarketcap API with ChainLink
    function marketState() public returns (uint256) {}
}