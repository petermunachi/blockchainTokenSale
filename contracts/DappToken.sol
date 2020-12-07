// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;


contract DappToken {
  
  string public name = "DApp Token";
  string public symbol = "DAPP";
  string public standard = "DApp Token v1.0";
  uint256 public totalSupply;

  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 indexed _value
  );

  mapping (address=>uint256) public balanceOf;

  constructor (uint256 _initialSupply) public {
    balanceOf[msg.sender] = _initialSupply;
    totalSupply = _initialSupply;  
  }

  // Transfer
  function transfer(address _to, uint256 _value) public returns (bool success) {
    //Exception if account doesn't have  enough
    require(balanceOf[msg.sender] >= _value, "Insufficient funds");
     
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;

    emit Transfer(msg.sender, _to, _value);

    return true;
  }


}