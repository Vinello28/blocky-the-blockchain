// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// TODO: try this using "pure"
contract ControlStructures {
    function IsEven(uint numba) public pure returns (string memory){
        if(numba%2==0){
            return "Even";            
        }
        else{
            return "Odd";
        }
    }

    /// Function that return the sum of a sum from 0 to n (the input)
    /// @param n input number of loops cycles
    function Sum2N(uint n) public pure returns (uint){
        uint sum = 0;
        for (uint i = 1; i<=n; i++){
            sum += i;
        }

        return sum;
    }

    /// Function that count from a given value from zero.
    /// @param n number from which the countdown will start
    function CountDown(uint n) public pure returns (string memory){
        string memory result ="";
        while (n>0){
            result = string(abi.encodePacked(result, uintToString(n), " "));
            n--;
        }
        return result;
    }

    /// Utility function that convert number into string.
    /// @param v input number to be converted
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        
        uint maxLen = 78;
        bytes memory reversed = new bytes(maxLen);
        uint len = 0;
        
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[len++] = bytes1(uint8(48 + remainder));
        }

        bytes memory s = new bytes(len);

        for (uint i = 0; i < len; i++) {
            s[i] = reversed[len - 1 - i];
        }
        
        return string(s);
    }
}

