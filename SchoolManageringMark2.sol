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

}