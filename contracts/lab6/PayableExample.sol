// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract PayableExample {
    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this");
        _;
    }

    function deposit() public payable onlyOwner {
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }
}