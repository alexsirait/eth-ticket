// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract TicketNFT is ERC721, Ownable {
    uint256 public ticketPrice;
    uint256 private nextTicketId = 1;

    constructor(uint256 _ticketPrice) ERC721("ConcertTicket", "CTK") Ownable(msg.sender) {
        ticketPrice = _ticketPrice;
    }

    function buyTicket() public payable {
        require(msg.value >= ticketPrice, "Insufficient funds");

        if (msg.value > ticketPrice) {
            payable(msg.sender).transfer(msg.value - ticketPrice);
        }

        _safeMint(msg.sender, nextTicketId);
        nextTicketId++;
    }

    function setTicketPrice(uint256 _price) public onlyOwner {
        ticketPrice = _price;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist"); // ✅ FIXED ERROR

        string memory json = string(abi.encodePacked(
            '{"name": "Concert Ticket #', Strings.toString(tokenId), 
            '", "description": "Tiket eksklusif untuk konser blockchain", ',
            '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(generateSVG(tokenId))), '"}'
        ));

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));
    }

    function generateSVG(uint256 tokenId) internal pure returns (string memory) {
        return string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="200">',
            '<defs><linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">',
            '<stop offset="0%" style="stop-color:#1e3c72;stop-opacity:1" />',
            '<stop offset="100%" style="stop-color:#2a5298;stop-opacity:1" />',
            '</linearGradient></defs>',
            '<rect width="100%" height="100%" fill="url(#grad1)" rx="15" ry="15"/>',
            '<rect x="5" y="5" width="290" height="190" fill="none" stroke="#00ffcc" stroke-width="2" rx="10" ry="10" opacity="0.8"/>',
            '<path d="M20 40 H280 M20 160 H280" stroke="#ffffff" stroke-width="1" opacity="0.5"/>',
            '<text x="50%" y="40%" font-size="24" text-anchor="middle" fill="#ffffff" font-family="Arial, sans-serif" font-weight="bold">',
            '<tspan dy="-10">Concert Ticket</tspan>',
            '<tspan x="50%" dy="30" font-size="20" fill="#00ffcc">#', Strings.toString(tokenId), '</tspan>',
            '</text>',
            '<text x="50%" y="70%" font-size="14" text-anchor="middle" fill="#ffffff" opacity="0.7" font-family="monospace">',
            'Exclusive Access',
            '</text>',
            '<circle cx="30" cy="30" r="10" fill="none" stroke="#00ffcc" stroke-width="1" opacity="0.6"/>',
            '<circle cx="270" cy="170" r="10" fill="none" stroke="#00ffcc" stroke-width="1" opacity="0.6"/>',
            '</svg>'
        ));
    }
}
