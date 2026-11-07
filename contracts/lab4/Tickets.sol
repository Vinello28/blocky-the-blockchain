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

    function initTicket (uint256 ticketnumber, uint256 money) external
    {
        require(ticketnumber !=0, "it's a invalid ticketnumber!");
        require(!tickets[ticketnumber].valid, "Ticka already exist mate!");

        tickets[ticketnumber]=TicketContainer({
            id: ticketnumber,
            owner: msg.sender,
            price: money,
            valid: true
        }); 
    }

    function getTicket(uint256 ticketnumber) external view returns (TicketContainer memory) 
    {
        require(tickets[ticketnumber].valid, "ticka must be valid mate!");
        return tickets[ticketnumber];
    }

    function invaliTicket(uint256 ticketnumber) external 
    {
        require(tickets[ticketnumber].valid, "nope, not valid!");
        require(
            tickets[ticketnumber].owner==msg.sender,
            "Gotchu!"
        );

        tickets[ticketnumber].valid=false;
    }

}

