pragma solidity ^0.5.13;

contract MappingsStructExample {

    mapping(address => uint) public balanceRecieved;

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceRecieved[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceRecieved[msg.sender] >= _amount,"not enough funds");
        balanceRecieved[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to ) public {

        uint balanceToSend = balanceRecieved[msg.sender];
        balanceRecieved[msg.sender] = 0;
        _to.transfer(balanceToSend);
    }

}
