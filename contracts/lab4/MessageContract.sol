// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Messages{

    struct MessageContainer{
        string messages;
    }

    mapping (string => MessageContainer) public messages;

    function setMessage(string memory msgContent) public{
        messages[msgContent]=MessageContainer(msgContent);
    }

    function getMessage (string memory msgContent) public view returns (MessageContainer memory){
        return messages[msgContent];
    }
}