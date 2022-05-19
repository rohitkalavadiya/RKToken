// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract  RKToken {
    string public name = "RKToken";
    string public symbol = "RKT";
    string public standard = "RKToken v1.0"; //not Erc-20 standard
    uint256 public totalSupply;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256  _value
    );

    mapping(address => uint256) public balanceOf;

    constructor( uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply ;
    }
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value); // check sender have in enough  balance of the coin 
        balanceOf[msg.sender] -= _value ; // deduct balance of the sender
        balanceOf[_to] += _value; // add balance of buyer
        //transfer event 
        emit Transfer(msg.sender, _to, _value);

        return true;
    }
}