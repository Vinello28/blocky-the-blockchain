//SPD-License-Identifier: GPL-3.0
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract functiontype{

    //visibility indentifier is view,simple, pure
    uint public statevariable; //if we put public with this variable then viewfunction() is not required
    
    //any function which send data on blockchain is said to be setter function or write function,
    function simpleFunction(uint a) public {
        statevariable=a;
    }

    //pure function is sued for add an additional functionality which return the data
    function pureFunction(uint a, uint b) public pure returns(uint) {
        uint c=a+b;
        return c;
    }
    
    function callPure(uint a, uint b) public {
        statevariable=pureFunction(a,b);
    }
}