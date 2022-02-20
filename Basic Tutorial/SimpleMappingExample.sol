pragma solidity ^0.6.0;

contract SimpleMappingExample {

    bool myVar1 = false;
    bool myVar2 = false;
    bool myVar3 = false;

    mapping(uint => bool) public myMapping;

    mapping (address => bool) public myAddressMapping;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function setMyVar1ToTrue() public {
        myVar1 = true;
    }
}
