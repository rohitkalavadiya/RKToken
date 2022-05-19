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

     event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256  _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor( uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply ;
    }
    function transfer(address _to, uint256 _value) public returns (bool success){
        
        require(balanceOf[msg.sender] >= _value); // check sender have in enough  balance of the coin 
        
        balanceOf[msg.sender] -= _value ; // deduct balance of the sender
        
        balanceOf[_to] += _value; // add balance of buyer
       
        emit Transfer(msg.sender, _to, _value);  //transfer event 

        return true; // return boolean value so verify wokring or not 
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
    allowance[msg.sender][_spender] = _value ;
    // Event approve
    emit Approval(msg.sender, _spender, _value);
    return true; // bool return
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]); 

        balanceOf[_from] -= _value; // balance update
        balanceOf[_to] += _value; // balance update

        allowance[_from][msg.sender] -= _value ;

        emit Transfer(_from, _to, _value);  //transfer event
        return true;

    }
}