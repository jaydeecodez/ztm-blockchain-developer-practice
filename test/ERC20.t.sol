// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {ERC20} from "../src/ERC20.sol";

contract ERC20Test is ERC20, Test {
    address private alice;
    address private bob;
    
    constructor() ERC20("name", "SYM", 18) {}

    function setUp() public virtual {
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        _mint(alice, 200);
    }

    function testTransfersTokenCorrectly() public {
        vm.prank(alice);
        this.transfer(bob, 100);
    }
}