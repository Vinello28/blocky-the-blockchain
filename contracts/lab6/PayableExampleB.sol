// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract PayableExampleB {
    mapping(address => uint) senderAddress;

    function deposit(address ownerAddress) public payable {
        senderAddress[ownerAddress] += msg.value;
    }

    function checkBalance(address ownerAddress) public view returns (uint) {
        return senderAddress[ownerAddress];
    }
}
