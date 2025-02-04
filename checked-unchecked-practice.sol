// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract CheckedUncheckedTests {
    function checkedAdd() pure public returns (uint256) {
        return type(uint256).max + 1;
    }

    function checkedSub() pure public returns (uint256) {
        return type(uint256).min -1;
    }

    function checkedMul() pure public returns (uint256) {
        return type(uint256).max * 2;
    }

    function uncheckedAdd() pure public returns (uint256) {
        unchecked { return type(uint256).max + 1; }
    }

    function uncheckedSub() pure public returns (uint256) {
        unchecked { return type(uint256).min - 1; }
    }

    function uncheckedMul() pure public returns (uint256) {
        unchecked { return type(uint256).max * 2; }
    }
}
