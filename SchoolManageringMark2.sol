// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SchoolManageringMark2 is Ownable {

struct Student {
    string name;
    string class;
    address addr;
    uint noteBiology;
    uint noteMaths;
    uint noteFr;
}

Student[] private students;

// Class => Course => Address
mapping (string => mapping (string => address)) teachers;

event studentAdded(string _name, string _class, address _addr);

function addStudent(string memory _name, string memory _class, address _addr) public onlyOwner {
    students.push(Student(_name, _class, _addr));
    emit studentAdded(_name, _class, _addr);
}

}