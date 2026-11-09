// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Parent
/// @author G. Vianello
/// @notice Contract used in Lab 5 lesson to study inheritance in solidity
contract ParentMapping {
    mapping (uint => string) public records;

    /// Functions that sets a record in memory (on the blockchain).
    /// @param id integer id of the "array" used to retrieve data
    /// @param data data to store in the "array"
    function setRecord(uint id, string memory data) public {
        //require(records[id] != null , "Cannot insert more value in a single position!");
        records[id] = data;
    }
}

/// @title Child
/// @author G. Vianello
/// @notice Contract used in Lab 5 lesson to study inheritance in solidity
contract ChildMapping is ParentMapping {
    /// Function that retrieves data based on id.
    /// @param id the id parameter used to retrieves data.
    function getRecord(uint id) public view returns (string memory) {
        return records[id];
    }
}