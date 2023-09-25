
// Map a proposal ID to a specific proposal
  mapping(uint => Proposal) public proposals;
  // Map a proposal ID to a voter's address and their vote
  mapping(uint => mapping(address => bool)) public voted;
  // Determine if the user is blocked from voting
  mapping (address => uint) public blocked;
  struct Proposal {
    uint votesReceived;
    bool passed;
    address submitter;
    uint votingDeadline;
  }
/// @dev Allows a token holder to submit a proposal to vote on
  function submitProposal()
    public
    onlyEligibleVoter(msg.sender)
    whenNotBlocked(msg.sender)
    returns (uint proposalID)
  {
    votesReceived = token.balanceOf(msg.sender);
    proposalID = addProposal(votesReceived);
    emit ProposalSubmitted(proposalID);
    return proposalID;
  }
  modifier onlyEligibleVoter(address _voter) {
   balance = token.balanceOf(_voter);
   require(balance > 0);
  _;
}
function addProposal(uint _votesReceived)
   internal
   returns (uint proposalID)
  {
   votes = _votesReceived;
   if (votes < votesNeeded) {
      if (proposalIDcount == 0) {
        proposalIDcount = 1;
      }
    proposalID = proposalIDcount;
    proposals[proposalID] = Proposal({
    votesReceived: votes,
    passed: false,
    submitter: msg.sender,
    votingDeadline: now + voteLength
     });
    blocked[msg.sender] = proposalID;
    voted[proposalID][msg.sender] = true;
    proposalIDcount = proposalIDcount.add(1);
    return proposalID;
   }
   else {
    require(token.balanceOf(msg.sender) >= votesNeeded);
    endVote(proposalID);
    return proposalID;
   }
  }
  function submitVote(uint _proposalID)
    onlyEligibleVoter(msg.sender)
    whenNotBlocked(msg.sender)
    public
    returns (bool)
  {
    Proposal memory p = proposals[_proposalID];
    if (blocked[msg.sender] == 0) {
      blocked[msg.sender] = _proposalID;
    } else if (p.votingDeadline >   proposals[blocked[msg.sender]].votingDeadline) 
    {
// this proposal's voting deadline is further into the future than
// the proposal that blocks the sender, so make it the blocker       
      blocked[msg.sender] = _proposalID;
    }
    votesReceived = token.balanceOf(msg.sender);
    proposals[_proposalID].votesReceived += votesReceived;
    voted[_proposalID][msg.sender] = true;
    if (proposals[_proposalID].votesReceived >= votesNeeded) 
    {
      proposals[_proposalID].passed = true;
      emit VotesSubmitted(
        _proposalID, 
        votesReceived, 
        proposals[_proposalID].passed
      );
      endVote(_proposalID);
    }
    emit VotesSubmitted(
      _proposalID, 
      votesReceived, 
      proposals[_proposalID].passed
    );
    return true;
  }
  if (proposals[_proposalID].votesReceived >= votesNeeded) {
    proposals[_proposalID].passed = true;
    emit VotesSubmitted(
       _proposalID, 
       votesReceived, 
       proposals[_proposalID].passed
    );
    endVote(_proposalID);
   }
function endVote(uint _proposalID) 
    internal
  {
    require(voteSuccessOrFail(_proposalID));
    updateProposalToPassed(_proposalID);
  }
function voteSuccessOrFail(uint _proposalID) 
    public
    view
    returns (bool)
  {
    return proposals[_proposalID].passed;
  }
  mapping (address => uint) public blocked;
  modifier whenNotBlocked(address _account) {
      require(!governance.isBlocked(_account));
      _;
    }
    function transfer(address to, uint256 value) 
      public 
      whenNotBlocked(msg.sender)
      returns (bool) 
    {
      return super.transfer(to, value);
    }
function transferFrom(address from, address to, uint256 value)
      public 
      whenNotBlocked(from)
      returns (bool)
    {
      return super.transferFrom(from, to, value);
    }
