pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract FallbackExample {
    uint256 public result;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}