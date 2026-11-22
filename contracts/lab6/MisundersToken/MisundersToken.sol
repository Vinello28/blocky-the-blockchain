// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract MisundersToken {
    string public name = "MisundersToken";
    string public symbol = "MUND";
    uint8 public decimals = 18;

    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) {
        owner = msg.sender;
        if (initialSupply > 0) {
            uint256 supply = initialSupply * 10 ** uint256(decimals);
            balanceOf[owner] = supply;
            totalSupply = supply;
            emit Transfer(address(0), owner, supply);
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this");
        _;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Insufficient allowance");

        allowance[from][msg.sender] -= value;
        balanceOf[from] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    function getAllowance(address ownerAddress, address spender) public view returns (uint256) {
        return allowance[ownerAddress][spender];
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid recipient");

        uint256 supplyAmount = amount * 10 ** uint256(decimals);
        balanceOf[to] += supplyAmount;
        totalSupply += supplyAmount;
        emit Transfer(address(0), to, supplyAmount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        uint256 supplyAmount = amount * 10 ** uint256(decimals);
        require(balanceOf[from] >= supplyAmount, "Insufficient balance");

        balanceOf[from] -= supplyAmount;
        totalSupply -= supplyAmount;
        emit Transfer(from, address(0), supplyAmount);
    }
}
