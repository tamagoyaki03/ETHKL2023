// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.19;

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
    uint public votingEndTime; // Variable to store the end time of the voting period

    event VoteSuccess(address indexed voter, uint indexed proposalIndex);

    constructor(string[] memory nameList, uint durationInMinutes) {
        host = msg.sender;
        voters[host].amount = 1;
        for (uint i = 0; i < nameList.length; i++) {
            Board memory boardItem = Board(nameList[i], 0);
            board.push(boardItem);
        }
        // Set the end time of the voting period
        votingEndTime = block.timestamp + (durationInMinutes * 1 minutes);
    }

    function getBoardInfo() public view returns (Board[] memory) {
        return board;
    }

    function mandate(address[] calldata addressList) public onlyHost {
        require(block.timestamp < votingEndTime, "Voting has ended.");
        for (uint i = 0; i < addressList.length; i++) {
            if (!voters[addressList[i]].voted) {
                voters[addressList[i]].amount = 1;
            }
        }
    }

    function vote(uint proposalIndex) public onlyVoter {
        require(block.timestamp < votingEndTime, "Voting has ended.");
        require(proposalIndex < board.length, "Invalid proposal index.");
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposalIndex;
        board[proposalIndex].voteCount += 1;
        emit VoteSuccess(msg.sender, proposalIndex);
    }

    modifier onlyHost() {
        require(msg.sender == host, "Restricted to host only.");
        _;
    }

    modifier onlyVoter() {
        require(voters[msg.sender].amount != 0, "No right to vote.");
        _;
    }
}
