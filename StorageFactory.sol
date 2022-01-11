// SPDX-License-Identifier: FahimAK
pragma solidity ^0.6.0;

import "./SimpleStorage.sol";


contract StorageFactory is SimpleStorage{

    SimpleStorage[] public simpleStorageArray;

    function createContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _arrayIndex, uint256 _theAge) public {
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_arrayIndex]));
        simpleStorage.addAge(_theAge);
    }

    function getAge(uint256 _arrayIndex) public view returns(uint256){
        return SimpleStorage(address(simpleStorageArray[_arrayIndex])).retrieve();
    }
}