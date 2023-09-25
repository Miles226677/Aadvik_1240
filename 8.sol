// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
//Chaiperson: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 1:0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 2:0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB 3:0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB 4:0x617F2E2fD72FD9D5503197092aC168c91465E7f2
//
import "3.sol";
contract VotingBooth {
    struct Voter {
        uint balance;
        bool voted;
        address delegate;
        uint vote;
    }
    struct Candidate {
        bytes32 name;
        uint voteCount;
    }
    address public chairperson;
    mapping(address => Voter) public voters;
    Candidate[] public candidates_list;
    constructor(bytes32[] memory candidateNames) {
        chairperson = msg.sender;
        voters[chairperson].balance = 1;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates_list.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }
    function giveRightToVote(address voter) external {
        require(
            msg.sender == chairperson,
            "Not eligible"
        );
        require(
            !voters[voter].voted,
            "No double voting"
        );
        require(voters[voter].balance == 0);
        voters[voter].balance = 1;
    }
    
    function vote(uint candidate) external {
        Voter storage sender = voters[msg.sender];
        require(sender.balance != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = candidate;
        candidates_list[candidate].voteCount += 1;
    }
    function winner() public view
            returns (uint winnerCandidate)
    {
        uint winningVoteCount = 0;
        for (uint n = 0; n < candidates_list.length; n++) {
            if (candidates_list[n].voteCount > winningVoteCount) {
                winningVoteCount = candidates_list[n].voteCount;
                winnerCandidate = n;
            }
        }
    }
    function winnerName() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = candidates_list[winner()].name;
    }
}