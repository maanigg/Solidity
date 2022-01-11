// SPDX-License-Identifier: FahimAK
pragma solidity ^0.6.0;

contract SimpleStorage{

    uint256 personAge;

    struct Person{
        string name;
        uint256 age;
    }

    Person[] public people;
    mapping(string => uint256) public nameAndAge;
    

    function addAge(uint256 _age) public{
        personAge = _age;
    }

    function retrieve() public view returns(uint256) {
        return personAge;
    }

    function addPerson(string memory _name)public{
        people.push(Person(_name,personAge));
        nameAndAge[_name] = personAge;
    }
    
    
}