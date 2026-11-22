// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

import "./IERC20.sol";

contract ERC20InterfaceCall {
    ERC20Interface public token;
    address public owner;

    constructor(address tokenAddress) {
        token = ERC20Interface(tokenAddress);
        owner = msg.sender;
    }

    function sellToken(address to, uint256 amount) public {
        require(token.transfer(to, amount), "Transfer failed");
    }
}
