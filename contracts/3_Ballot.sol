// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

struct Voter {
uint amount; 
bool voted; 
uint vote; 
bool enrolled; 
}

struct Proposal {
string name;
uint voteCount; 
}

address public chairperson;

mapping(address => Voter) public voters;

Proposal[] public proposals;
}
/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

{
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
enrolled: true;
}

0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2{
amount:1;
voted:false;
vote:0;
enrolled: true;
}

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
enrolled: true;
}

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
enrolled: true;
}
}

name: Lee Tian Kee;
voteCount:15;

name: Tan Lok Tien
voteCount:10
*/
 