pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT
import "./simpleStorage.sol";

contract ExtraStorage is SimpleStorage {

    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 5; 
    }
}