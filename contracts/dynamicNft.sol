// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicNft is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private currentTokenId;

    /// @dev Base token URI used as a prefix by tokenURI()
    string public baseTokenURI;

    constructor() ERC721("DynamicNft", "DNFT") {
        baseTokenURI = "";
    }

    function mint() public {
        currentTokenId.increment();
        _safeMint(msg.sender, currentTokenId.current());
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _tokenId;
        return baseTokenURI;
    }

    /// @dev Returns an URI for a given token ID
    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    /// @dev Sets the base token URI prefix
    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }
}
