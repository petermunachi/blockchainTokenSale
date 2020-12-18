// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "./DappToken.sol";

contract DappTokenSale {
  address payable private admin;
  DappToken public tokenContract;
  uint256 public tokenPrice;
  uint256 public tokensSold;

  event Sell(
    address indexed _buyer,
    uint256 indexed _amount
  );

  constructor (DappToken _tokenContract, uint256 _tokenPrice) public {
    admin = msg.sender;
    tokenContract = _tokenContract;
    tokenPrice = _tokenPrice;
  }

  //multiply
  function multiply(uint x, uint y) internal pure returns (uint z) {
    require(y == 0 || (z = x * y) / y == x);
  }

  function buyTokens(uint256 _numberOfTokens) public payable {
    
    //Require that value is equal to tokens
    require(msg.value == multiply(_numberOfTokens, tokenPrice), 'Token must be wei');
    //Require that the contract has enough tokens
    require(tokenContract.balanceOf(address(this)) >= _numberOfTokens, 'insufficient token');
    //Require that a transfer is successful
    require(tokenContract.transfer(msg.sender, _numberOfTokens), 'Unable to transfer token to msg.sender');
    //Keep track of token sold
    tokensSold += _numberOfTokens;
    //Trigger Sell Event
    emit Sell(msg.sender, _numberOfTokens);

  }

  //Ending Token DappTokenSale
  function endSale() public {
    //Require admin
    require(msg.sender == admin);
    //Transfer remaining dapp tokens to admin
    require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
    //Destroy contract
    selfdestruct(admin);
  }


}