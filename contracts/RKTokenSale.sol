// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./RKToken.sol";

contract  RKTokenSale {
    address admin ;
    RKToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(
        address _buyer,
        uint256 _amount
    );


    constructor(RKToken _tokenContract , uint256 _tokenPrice) public {
        // Assign the admin
        admin = msg.sender ;

        //Token Contract
        tokenContract = _tokenContract ;
        //Token Price in eth
        tokenPrice = _tokenPrice;
    }
    
    function multiply(uint x , uint y) internal pure returns (uint z){
        require( y == 0 || (z = x * y ) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        //require that value is equal to token
     require(msg.value == multiply (_numberOfTokens , tokenPrice) );
        // require that the contract has enough token
        require(tokenContract.balanceOf(msg.sender) >= _numberOfTokens);
          //require that a transfer is successful
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        tokensSold += _numberOfTokens;
        //Event tigger
        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public  {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(msg.sender)));

        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        //admin.transfer(address(this).balance);
        selfdestruct(admin);

    }
}