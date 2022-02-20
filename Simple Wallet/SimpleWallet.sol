// SPDX-License-Identifier: MIT
// Simple Wallet

pragma solidity 0.6.0;

// Ownable
import "./Ownable.sol";

// SafeMath
import "./SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint; 
    mapping(address=> uint) public allowance;

    event MoneyRecieved(address indexed _addr, uint _amount);
    event AllowanceGiven(address indexed _to , uint newAllowance);

    modifier onlyOwnerOrAllowed(uint _amount) {
        require(isOwner() ||allowance[msg.sender] >= _amount, "You are not allowed to withdraw this amount" );
        _;
    }

    /**
    * Will be called by owner to increase allowances to certain addresses
    */
    function addAllowance(address _to , uint _amount) external onlyOwner() {
        allowance[_to] = allowance[_to].add(_amount);
        // emit AllowanceGiven(_to, allowance[_to]);
    }

    function reduceAllowance(address _who, uint _amount) internal {
        allowance[_who] = allowance[_who].sub(_amount);
    }



}

contract SimpleWallet is Allowance{
    /**
     * Will be called when (fallback) is used in Remix
     */
    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }

    /**
    * Will be called by anyone to withdraw money if they are allowed to get it
    */
    function withdraw(uint _amount) public onlyOwnerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if(!isOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        payable(msg.sender).transfer(_amount);
    }
}
