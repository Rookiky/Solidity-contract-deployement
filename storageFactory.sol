pragma solidity ^0.8.8;
// SPDX-License-Identifier: MIT

import "./simpleStorage.sol";
 
contract StorageFactory {
    SimpleStorage[] public simpleStorageArray ;

    function createSimpleContract() public { 
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }   

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}