// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TransferExample{
    address payable _receive;

    function deposit () public payable {
        // none
    }

    function Transfer (address payable _to, uint amount) public {
        require(address(this).balance >= amount, "enough balance mate");
        _to.transfer(amount);
        _receive=_to;
    }

    function checkReceiverBalance() public view returns (uint){
        return _receive.balance;
    }

    function checkSenderBalance() public view returns (uint) {
        return address(this).balance;
    }
}