// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

type FixedPoint is uint256;

using {add as +} for FixedPoint global;
using {sub as -} for FixedPoint global;
using {mul as *} for FixedPoint global;
using {div as /} for FixedPoint global;

uint256 constant DECIMALS = 1e18;

function add(FixedPoint a, FixedPoint b) pure returns (FixedPoint) {
        return FixedPoint.wrap(FixedPoint.unwrap(a) + FixedPoint.unwrap(b));
    }

function sub(FixedPoint a, FixedPoint b) pure returns (FixedPoint) {
        return FixedPoint.wrap(FixedPoint.unwrap(a) - FixedPoint.unwrap(b));
    }

function mul(FixedPoint a, FixedPoint b) pure returns (FixedPoint) {
        return FixedPoint.wrap(FixedPoint.unwrap(a) * FixedPoint.unwrap(b) / DECIMALS);
    }

function div(FixedPoint a, FixedPoint b) pure returns (FixedPoint) {
        return FixedPoint.wrap(FixedPoint.unwrap(a) * DECIMALS / FixedPoint.unwrap(b));
    }

contract FixedPointTest {
    function testAddition(FixedPoint a, FixedPoint b) external pure returns (FixedPoint) {
        return a + b;
    }
    function testSubtraction(FixedPoint a, FixedPoint b) external pure returns (FixedPoint) {
        return a - b;
    }
    function testMultiplication(FixedPoint a, FixedPoint b) external pure returns (FixedPoint) {
        return a * b;
    }
    function testDivision(FixedPoint a, FixedPoint b) external pure returns (FixedPoint) {
        return a / b;
    }
}
