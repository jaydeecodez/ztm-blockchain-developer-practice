// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Parent {
    uint256 public myNumber;

    function setMyNumber(uint256 newNumber) external  {
        myNumber = newNumber;
    }
}

contract Child is Parent {
    function addToMyNumber(uint256 addition) external  {
        myNumber+= addition;
    }
}
