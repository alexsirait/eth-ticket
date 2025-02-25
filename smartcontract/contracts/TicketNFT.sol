// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TicketNFT is ERC721, Ownable {
    uint256 public ticketPrice;
    uint256 private nextTicketId = 1;

    constructor(uint256 _ticketPrice) ERC721("ConcertTicket", "CTK") Ownable(msg.sender) {
        ticketPrice = _ticketPrice;
    }

    function buyTicket() public payable {
        require(msg.value >= ticketPrice, "Insufficient funds");

        // Refund jika pengguna mengirim lebih dari harga tiket
        if (msg.value > ticketPrice) {
            payable(msg.sender).transfer(msg.value - ticketPrice);
        }

        _safeMint(msg.sender, nextTicketId);
        nextTicketId++;
    }

    function setTicketPrice(uint256 _price) public onlyOwner {
        ticketPrice = _price;
    }
}

