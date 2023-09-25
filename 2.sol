//contracts//voter.sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/access/Ownable.sol";
    contract Voter  {
        mapping(string => address) voters;
 event RegisterVoter(address voter, string socialNumber);
 function _minting(address _voter) private {
 address payable voter = address(uint160(_voter));
 voter.transfer(msg.value);
 }
 function registerVoter(address _voter, string calldata _socialNumber)
 external
 payable
 onlyOwner
 {
 require(
 voters[_socialNumber] == address(0x000),
 "The voter is already registered"
 );
 voters[_socialNumber] = _voter;
 _minting(_voter);
 emit RegisterVoter(_voter, _socialNumber);
 }
 function kill() public onlyOwner {
 selfdestruct(address(uint16(owner())));
    }
    }