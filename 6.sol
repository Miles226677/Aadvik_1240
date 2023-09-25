// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;
import "3.sol";

contract TokenTransfer {
    function transfer() external {
        OurToken B = OurToken(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        B.transfer(msg.sender,1);

    }
    function transferFrom(address recipient,uint amount ) external {
        OurToken B = OurToken(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        B.transferFrom(msg.sender,recipient,1);
    }
}
contract Owner{
               function transfer(uint amount) external {
                   OurToken B = OurToken(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
                   B.approve(msg.sender,1);
                   TokenTransfer transferToken = TokenTransfer(msg.sender);
                   transferToken.transferFrom(,1);
               }
}