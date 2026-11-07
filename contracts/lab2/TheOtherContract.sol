//SPD-License-Identifier: GPL-3.0
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

//how to write a contract
contract test{

    //these all are state variable, state variable identify
    //if we show the variable after execution the we use as public
    uint256 public a1;
    bool public abc;
    string public xyz;
    address public owner=msg.sender;

    constructor(){
    }
    
    //function declaration but this will be write function
    function testing(uint a, uint b ) public {
        a1=a+b;
    }
    
    function contractvalue() public view returns(address) {
        //if we return address(this), then it will return contract address which will be change everytime if we execute
        return msg.sender; //this will return the account address of this remix
    }
    
    function timecheck() public view returns(uint){ // view means that this read only function
        //the output value 1730997472 is check on the below site
        //https://www.epochconverter.com/
        return block.timestamp;
    }

}