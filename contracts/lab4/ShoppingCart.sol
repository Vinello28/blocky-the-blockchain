// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// TODO: a possible improvement could be the use of "indexed" keywords to allow off-chain filtering. 
// keep in mind for lecture/project.


contract ShoppingCart {      
    
    struct ShippingAddress {
        string street;
        string city;
        string zipCode;
    }

    // Item struct that includes the name, price, and shipping address of the item
    struct Item {
        string name;
        uint256 price;
        ShippingAddress shippingAddress;
    }

    // Mapping to store the shopping cart for each address
    mapping(address => Item[]) private carts;

    // Adds an item to the sender's shopping cart
    function addItem(
        string memory name,
        uint256 price,
        string memory street,
        string memory city,
        string memory zipCode
    ) public {
        ShippingAddress memory addr = ShippingAddress(street, city, zipCode);
        carts[msg.sender].push(Item(name, price, addr));
    }

    // Returns entire shopping cart for the sender
    function getCart() public view returns (Item[] memory) {
        return carts[msg.sender];
    }

    // Returns a specific item from the sender's shopping cart by index
    function getItem(uint256 index) public view returns (Item memory) {
        require(index < carts[msg.sender].length, "Indice non valido");
        return carts[msg.sender][index];
    }

    // Returns total price
    function getTotalPrice() public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < carts[msg.sender].length; i++) {
            total += carts[msg.sender][i].price;
        }
        return total;
    }

    // Empties sender's shopping cart
    function clearCart() public {
        delete carts[msg.sender];
    }
}
