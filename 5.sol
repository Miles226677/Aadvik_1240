// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
//Chaiperson: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 1:0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 2:0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db 3:0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB 4:0x617F2E2fD72FD9D5503197092aC168c91465E7f2
//["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","0x617F2E2fD72FD9D5503197092aC168c91465E7f2"]
//Candidate 1:Ashirwad:0x41736869727761640a0000000000000000000000000000000000000000000000 Candidate 2:Munish:0x4d756e6973680a0a000000000000000000000000000000000000000000000000
import "3.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }
    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    function giveRightToVote(address voter) external {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(!voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
        OurToken B = OurToken(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        B.transfer(voter,1);
        }
    
    
    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
        
    }
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }
    function winnerName() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}