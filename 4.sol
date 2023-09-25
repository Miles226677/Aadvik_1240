// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.7;
import "3.sol";
contract Voter  {
        mapping(string => address) voters;
 event RegisterVoter(address voter, string socialNumber);
 function _minting(address _voter) private {
 address payable voter = address(uint160(_voter));
 voter.transfer(msg.value);
 }
}