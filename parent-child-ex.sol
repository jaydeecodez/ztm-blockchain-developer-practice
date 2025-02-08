// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract GrandFather {
    string public myStringGrandFather;

    function setMyString() public virtual {
        myStringGrandFather = "GrandFather";
    }
}

contract GrandMother {
    string public myStringGrandMother;

    function setMyString() public virtual {
        myStringGrandMother = "GrandMother";
    }
}

contract Father is GrandFather {
    string public myStringFather;

    function setMyString() public virtual override {
        myStringFather = "Father";
        super.setMyString();
    }
}

contract Mother is GrandMother {
    string public myStringMother;

    function setMyString() public virtual override {
        myStringMother = "Mother";
        super.setMyString();
    }
}

contract Child is Father, Mother {
    string public myStringChild;

    function setMyString() public override(Father, Mother) {
        myStringChild = "Child";
        Father.setMyString();
        Mother.setMyString();
    }
}
