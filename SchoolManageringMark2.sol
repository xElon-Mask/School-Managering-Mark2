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

function stringsEquals(string memory _string1, string memory _string2) pure private returns (bool) {
    bool test;
    if (keccak256(abi.encodePacked(_string1)) == keccak256(abi.encodePacked(_string2))) {
        test = true;
    } 
    return test;
}

function setNote(string memory _course, string memory _nameStudent, uint _note) public {
    uint idStudent = getStudentFromName(_nameStudent);
    require(msg.sender == teachers[students[idStudent].class][_course], "you're not the teacher of this student course");
    if (stringsEquals(_course, "biology")) {
        students[idStudent].noteBiology = _note;
    }
    else if (stringsEquals(_course, "maths")) {
        students[idStudent].noteMaths = _note;

    }
    else if (stringsEquals(_course, "french")) {
        students[idStudent].noteFr = _note;
    }
    else {
        revert("type a real course");
        }
}

function calculateAveragePerCourse(string memory  _class, string memory _course) public view returns (uint) {
    require(msg.sender == teachers[_class][_course], "you're not the teacher of this class course");
    uint totalNote;
    uint totalStudent;
    for (uint i = 0; i < students.length; i++) {
        if (stringsEquals(_course, "biology")) {
            totalNote += students[i].noteBiology;
            totalStudent += 1;
        }
        if (stringsEquals(_course, "maths")) {
            totalNote += students[i].noteMaths;
            totalStudent += 1;
        }
        if (stringsEquals(_course, "french")) {
            totalNote += students[i].noteFr;
            totalStudent += 1;
        }
    }
    uint average = totalNote / totalStudent;
    return average;
} 

function calculateAverageStudent(string memory _name) public onlyOwner view returns (uint) {
    uint idStudent = getStudentFromName(_name);
    return (students[idStudent].noteBiology + students[idStudent].noteMaths + students[idStudent].noteFr) / 3;
}

function isPassing(string memory _name) public onlyOwner view returns (bool) {
    if (calculateAverageStudent(_name) >= 10) {
        return true;
    } else {
        return false;
    }
}

}