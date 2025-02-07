// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract TestSimpleStorage is Test {
    // EVENTS
    event PersonAdded(int256 Rollno, string name);

    SimpleStorage public simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    // Store Function
    function testStoreFunctionRevertsWhenFavoriteNumberIsLessThanZero() public {
        // favoriteNumber should be < 0
        vm.expectRevert(SimpleStorage.SimpleStorage__favoriteNumberIsLessThanZero.selector);
        simpleStorage.store(-3);
    }

    function testStoreSavesFavoriteNumber() public {
        simpleStorage.store(5);
        assertEq(simpleStorage.getFavoriteNumber(), 5);
    }

    // AddPerson Function
    function testAddPersonRollNoIsLessThanZero() public {
        // RollNo should be > 0
        vm.expectRevert(SimpleStorage.SimpleStorage__rollNoIsLessThanZero.selector);
        simpleStorage.addPerson(-4, "USER");
    }

    function testAddPseronNameLengthIsLessThanZero() public {
        // Name length should be > 0
        vm.expectRevert(SimpleStorage.SimpleStorage__nameLengthIsZero.selector);
        simpleStorage.addPerson(1043, "");
    }

    function testAddPersonPlayerAlreadyExists() public {
        // Duplicate names should not exists
        simpleStorage.addPerson(1034, "USER");
        vm.expectRevert(SimpleStorage.SimpleStorage__PersonAlreadyExists.selector);
        simpleStorage.addPerson(102, "USER");
    }

    function testAddPersonEmitsUserInfoEvent() public {
        vm.expectEmit(true, true, true, true);
        emit PersonAdded(1034, "USER");
        simpleStorage.addPerson(1034, "USER");
    }

    function testAddPersonToArray() public {
        simpleStorage.addPerson(1034, "USER");
        assertEq(simpleStorage.getPersonsLength(), 1);
    }

    function testAddNameToFavoriteNumber() public {
        simpleStorage.addPerson(1034, "USER");
        int256 favoriteNumber = simpleStorage.getNameToFavoriteNumber("USER");
        assertEq(favoriteNumber, 1034);
    }
}
