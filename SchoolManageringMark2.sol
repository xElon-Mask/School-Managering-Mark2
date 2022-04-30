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
event teacherAdded(string _class, string _course, address _addr);

function addStudent(string memory _name, string memory _class, address _addr) public onlyOwner {
    students.push(Student(_name, _class, _addr));
    emit studentAdded(_name, _class, _addr);
}

function setTeacher(string memory _class, string memory _course, address _addr) public onlyOwner {
    teachers[_class][_course] = _addr;
    emit teacherAdded(_class, _course, _addr);
}

function getStudentFromName(string memory _name) private view returns (uint) {
    for (uint i = 0; i < students.length; i++) {
        if(keccak256(abi.encodePacked(students[i].name)) == keccak256(abi.encodePacked(_name))) {
            return i;
        }
    }
    return 0;
}

}