// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Father {
    uint256 private myNumber;

    function setMyNumber(uint256 newNumber) external virtual {
        myNumber = newNumber;
    }
}

contract Mother {
    uint256 private myNumber;

    function setMyNumber(uint256 newNumber) external virtual {
        myNumber = newNumber;
    }
}

contract Child is Mother, Father {
    uint256 private myNumber;
    
    function addToMyNumber(uint256 addition) external {
        myNumber += addition;
    }

    function setMyNumber(uint256 newNumber) external override(Mother, Father) {
        myNumber = 5;
    }
}
