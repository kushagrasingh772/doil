//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Mylock{
    event Withdrawl(address indexed from, uint256 amount);
    struct users{
        string name;
        string aadhar;
        address account;
        bool isapproved;
    }
    users[]public pendingusers;

    mapping(address=>bool) public isauthorized;
    address owner;
    constructor(){
        owner=msg.sender;

    }
    
    function authorizeemployee(uint256 requestid) public {
        require(msg.sender==owner);
        isauthorized[pendingusers[requestid].account]=true;
        pendingusers[requestid].isapproved=true;
    }

    function getfuel(uint256 fuel) public{
        require(isauthorized[msg.sender]);
        emit Withdrawl(msg.sender,fuel);
    }
    function deauthorizeemployee(address empadress) public {
        require(msg.sender==owner);
        isauthorized[empadress]=false;
    }
    function updateowner(address newadress) public{
        require(msg.sender==owner);
        owner=newadress;
    }
    function getauthorized(string calldata name, string calldata aadhar) public {
        users memory newuser=users(name,aadhar,msg.sender,false);
        pendingusers.push(newuser);
    }
}
