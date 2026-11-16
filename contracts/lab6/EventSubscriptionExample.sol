// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TikToken {
    TokenCreator creator;
    address owner;
    byte32 name;
    constructor(bytes32 name_) {
        owner = msg.sender;
        creator = TokenCreator(msg.sender);
        name = name_;
    }
    
    function changeName(bytes32 newName) public {
        if (msg.sender == address(creator)) name = newName;
    }

    function transfer (address newOwner) public {
        if(msg.sender != owner) return;

        if(creator.isTokenTransferOK(owner, newOwner)) owner = newOwner;
    }

}