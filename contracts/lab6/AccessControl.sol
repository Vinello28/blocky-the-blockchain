// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AccessControlExample{
    address public owner;
    uint public data;

    modifier onlyOwner(){
        require(msg.sender == owner, "Only the owner can call this");
        _; // function code would be there
    }

    constructor(){
        owner = msg.sender;
    }

    function setData(uint _data) public onlyOwner{
        data = _data;
    }

    function getData() public view returns (uint) {
        return data;
    }
}