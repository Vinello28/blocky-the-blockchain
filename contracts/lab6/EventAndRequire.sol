// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract EventAndRequire {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address to, uint256 amount) public {
        require(to != address(0), "Cannot be zero, c'mon mate");
        require(amount > 0, "Amount must be greater than zero");
        emit Transfer(msg.sender, to, amount);
    }
}