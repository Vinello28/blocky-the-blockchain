// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title ParentStateVariable
/// @author G. Vianello
/// @notice Used for test state variables from parent contract.
contract ParentSV {
    uint public parentValue = 100;
}

/// @title ChildStateVariable
/// @author G. Vianello
/// @notice Used for test state variables from parent contract.
contract ChildSV is ParentSV {
    function getParentValue() public view returns (uint) {
        return parentValue;
    }
}