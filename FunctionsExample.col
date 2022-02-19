pragma solidity ^0.5.13;

contract FunctionsExample {

    mapping(address => uint) public balanceRecieved;

    address payable owner;

    constructor() public{
        owner = msg.sender;
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function convertWeiToEther(uint _amountToWei) public pure returns(uint){
        return _amountToWei / 1 ether;
    }

    function destroySmartContract() public{
        require(msg.sender == owner , "You are not the owner");
        selfdestruct(owner);

    }

    function recieveMoney() public payable {
        assert(balanceRecieved[msg.sender] + msg.value >= balanceRecieved[msg.sender]);
        balanceRecieved[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to,uint64 _amount) public {
        require(_amount <= balanceRecieved[msg.sender] , "You do not have enough funds");
        assert(balanceRecieved[msg.sender] >= balanceRecieved[msg.sender] - _amount);
        balanceRecieved[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
// fallback function
    function () external payable {
        recieveMoney();
    }

}
