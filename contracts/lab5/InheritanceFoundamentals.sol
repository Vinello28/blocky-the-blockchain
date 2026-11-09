// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Parent {
    string public greet = "hello from me";

    function sayHelloMate() public view virtual returns (string memory){
        return greet;
    }
}

contract Child is Parent {
    function sayHelloMate() public view override returns (string memory){
        return "hello from me too";
    }
}