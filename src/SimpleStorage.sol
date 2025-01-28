// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleStorage {
    uint256 favoriteNumber;

    struct Person {
        uint256 Rollno;
        string name;
    }

    Person[] public Persons;

    mapping(string => uint256) public NameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrive() public view returns (uint) {
        return favoriteNumber;
    }

    function addPerson(uint256 _Rollno, string memory _name) public {
        Persons.push(Person(_Rollno, _name));
        NameToFavoriteNumber[_name] = _Rollno;
    }

    function getPerson(uint256 _index) public view returns (Person memory) {
        return Persons[_index];
    }
}
