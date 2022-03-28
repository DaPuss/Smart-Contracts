// SPDX-License_Identifier: Unlicense
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract SimpleMintContract is ERC721, Ownable {
    uint256 public mintPrice = 0.5 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721('Simple Mint', 'SIMP'){
        maxSupply = 1000;
    }

    function toggleIsMintEnabled() external onlyOwner{
        isMintEnabled= !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner{
        require(maxSupply_ > 0, 'Max supply cannot be less than 0');
        maxSupply = maxSupply_;
    }

    function min() external payable{
        require(isMintEnabled, 'Minting not enabled');
        require(mintedWallets[msg.sender] < 10, 'Exceeds max mints per wallet');
        require(msg.value == mintPrice, 'Wrong value');
        require(maxSupply > totalSupply, 'Sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;

        _safeMint(msg.sender, tokenId);
    }
}