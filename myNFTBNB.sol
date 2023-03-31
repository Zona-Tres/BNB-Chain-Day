// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Zona3BNB is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    

    Counters.Counter private _tokenIdCounter;
    uint256 public minRate = 1 ether;
    uint public maxSuply = 3;

    constructor() ERC721("Zona3BNB", "Z3B") {}

    function safeMint(address to) public payable {
        require(totalSupply() < maxSuply, "Can't mint more");
        require(msg.value >= minRate, "Wrong Amount");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //function withdraw() public onlyOwner {
    //    require(address(this).balance > 0, "Balance is zero");
    //    payable(owner()).transfer(address(this).balance);
    //}
}
