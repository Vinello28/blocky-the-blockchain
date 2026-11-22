// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TikToken {
    TokenCreator creator;
    address owner;
    bytes32 name;
    constructor(bytes32 name_) {
        owner = msg.sender;
        creator = TokenCreator(msg.sender);
        name = name_;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getName() public view returns (bytes32) {
        return name;
    }
    
    function changeName(bytes32 newName) public {
        if (msg.sender == address(creator)) name = newName;
    }

    function transfer (address newOwner) public {
        if(msg.sender != owner) return;

        if(creator.isTokenTransferOK(owner, newOwner)) owner = newOwner;
    }
}

/// @title TokenCreator
/// @author G.Vianello
/// @notice Just create the example token named as "TikToken"
contract TokenCreator {
    function createToken(bytes32 name) public returns (TikToken) {
        return new TikToken(name); 
    }

    function changeTokenName(TikToken token, bytes32 newName) public {
        token.changeName(newName);
    }
    
    function isTokenTransferOK(address from, address to) public pure returns (bool okidoki) {
        return keccak256(abi.encodePacked(from, to))[0] == 0x7f; // arbitrary condition, just for fun
    }
}
