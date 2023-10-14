// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.19 ;

contract Ballot {

    struct Voter {
        uint amount; 
        bool voted; 
        uint vote; 
    }

    struct Board {
        string name;
        uint voteCount; 
    }

    address public host;

    mapping(address => Voter) public voters;

    Board[] public board;

    constructor (string [] memory nameList){
        host=msg.sender;

        voters[host].amount= 1;

        for(uint i=0;i < nameList.length;i++){
            Board memory boardItem =Board(nameList[i],0);
            board.push(boardItem);
        }
    }

    function getBoardInfo() public view returns (Board[] memory){
        return board;
    }

    function mandate (address[] calldata addressList) public{
        require(msg.sender == host, "Strictly to owner only.");
        for (uint i=0;i< addressList.length;i++){
            if(!voters[addressList[i]].voted){
                voters[addressList[i]].amount=1;
            }
        }
    }

    function voting(uint vote)public{
        Voter storage sender= voters[msg.sender];
        require(sender.amount!=0, "Has no right to vote.");
        require(!sender.voted,"Already voted.");
        sender.voted=true;
        sender.vote=vote;
        board[vote].voteCount += 1;
        emit voteSuccess("Voted Succesfully");
    }

    event voteSuccess(string);
}
/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"]
{
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
}

0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2{
amount:1;
voted:false;
vote:0;
}

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
}

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4{
amount:1;
voted:false;
vote:0;
}
}

name: Lee Tian Kee;
voteCount:15;

name: Tan Lok Tien
voteCount:10

["Lee Tian Kee","Tan Lok Tien","Andy Rodriguez","Agnes Noris"]
*/
 