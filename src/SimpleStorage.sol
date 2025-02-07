// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleStorage {
    // ERRORS
    error SimpleStorage__favoriteNumberIsLessThanZero();
    error SimpleStorage__rollNoIsLessThanZero();
    error SimpleStorage__nameLengthIsZero();
    error SimpleStorage__PersonAlreadyExists();
    error SimpleStorage__IndexOutOfBonds();

    // TYPE DECLARATIONS
    struct Person {
        int256 Rollno;
        string name;
    }

    // STATE VARIABLES
    int256 s_favoriteNumber;
    Person[] private s_Persons;
    mapping(string => int256) private NameToFavoriteNumber;

    // EVENTS
    event PersonAdded(int256 Rollno, string name);

    // FUNCTIONS
    function store(int256 _favoriteNumber) public {
        require(_favoriteNumber > 0, SimpleStorage__favoriteNumberIsLessThanZero());
        s_favoriteNumber = _favoriteNumber;
    }

    function addPerson(int256 _Rollno, string memory _name) public {
        require(_Rollno > 0, SimpleStorage__rollNoIsLessThanZero());
        require(bytes(_name).length > 0, SimpleStorage__nameLengthIsZero());
        require(NameToFavoriteNumber[_name] == 0, SimpleStorage__PersonAlreadyExists());
        s_Persons.push(Person(_Rollno, _name));
        NameToFavoriteNumber[_name] = _Rollno;
        emit PersonAdded(_Rollno, _name);
    }

    // Getters

    function getFavoriteNumber() external view returns (int256) {
        return s_favoriteNumber;
    }

    function getPerson(uint256 _index) external view returns (Person memory) {
        require(_index < s_Persons.length, SimpleStorage__IndexOutOfBonds());
        return s_Persons[_index];
    }

    function getPersonsLength() external view returns (uint256) {
        return s_Persons.length;
    }

    function getNameToFavoriteNumber(string memory _name) external view returns (int256) {
        return NameToFavoriteNumber[_name];
    }
}
