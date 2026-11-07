// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Ticket{
    struct TicketContainer{
        uint256 id;
        address owner;
        uint256 price;
        bool valid;
    }

    mapping(uint256 => TicketContainer) tickets;

    function initTicket (uint256 tickanumba, uint256 dolla) external
    {
        require(tickanumba !=0, "U shee head, it's a invalid tickanumba!");
        require(!tickets[tickanumba].valid, "Ticka already exist you abomination!");

        tickets[tickanumba]=TicketContainer({
            id: tickanumba,
            owner: msg.sender,
            price: dolla,
            valid: true
        }); 
    }

    function getTicket(uint256 tickanumba) external view returns (TicketContainer memory) 
    {
        require(tickets[tickanumba].valid, "ticka mustabe valid mate!");
        return tickets[tickanumba];
    }

    function invaliTicket(uint256 tickanumba) external 
    {
        require(tickets[tickanumba].valid, "HAHAHAHAHAH");
        require(
            tickets[tickanumba].owner==msg.sender,
            "Gotchu!"
        );

        tickets[tickanumba].valid=false;
    }

}

