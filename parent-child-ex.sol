// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract GrandFather {
    uint256 public myNumber1;

    function setMyNumber1(uint256 newNumber) external  {
        myNumber1 = newNumber;
    }
}

contract Father is GrandFather {
    uint256 public myNumber2;

    function setMyNumber2(uint256 newNumber) external  {
        myNumber2 = newNumber;
    }
}

contract Child is Father {
    function addToBothNumbers(uint256 addition) external  {
        myNumber1 += addition;
        myNumber2 += addition;
    }
}
