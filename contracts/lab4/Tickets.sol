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

        if(tickets[ticketnumber].valid)
        {
            revert("Ticket already exist mate!");
        }
        
        // require(!tickets[ticketnumber].valid, "Ticket already exist mate!");   //old code

        tickets[ticketnumber]=TicketContainer({
            id: ticketnumber,
            owner: msg.sender,
            price: money,
            valid: true
        }); 

        // check invariant state
        assert(tickets[ticketnumber].valid);
        assert(tickets[ticketnumber].owner==msg.sender);
    }

    function getTicket(uint256 ticketnumber) external view returns (TicketContainer memory) 
    {
        require(tickets[ticketnumber].valid, "ticka must be valid mate!");
        return tickets[ticketnumber];
    }

    function invalidateTicket(uint256 ticketnumber) external 
    {
        require(tickets[ticketnumber].valid, "ticket not valid!");

        if (tickets[ticketnumber].owner!=msg.sender)
        {
            revert("I don't think you own this ticket mate!");
        }

        tickets[ticketnumber].valid=false;

        // check invariant state
        assert(!tickets[ticketnumber].valid);
    }

}

