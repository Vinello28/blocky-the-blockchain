// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

interface ERC20Interface {
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function getAllowance(address owner, address spender) external view returns (uint256);
    function mint(address to, uint256 amount) external;
    function burn(address from, uint256 amount) external;
    function minting(address initAddress, address toAddress, uint256 mintAmount) external;
    function burning(address initAddress, address toAddress, uint256 burnAmount) external;
}
