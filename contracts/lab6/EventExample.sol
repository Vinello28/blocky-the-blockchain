// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title EventExample
/// @author G. Vianello
/// @notice Events are logs/record created to allow external entities to react to specific occurrences
contract EventExample {

    // Event declaration
    event Transfer(address indexed from, address indexed to, uint amount);

    // function that emit the event
    function transfer(address to, uint amount) public {
        emit Transfer(msg.sender, to, amount);
    }
}