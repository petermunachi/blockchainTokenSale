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

  event Approval(
    address indexed _owner,
    address indexed _spender,
    uint256 indexed _value
  );

  // transfer

  mapping (address=>uint256) public balanceOf;
  // allowance
  mapping (address=> mapping (address=>uint256)) public allowance;

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

  // approve
  function approve(address _spender, uint256 _value) public returns (bool success) {

    allowance[msg.sender][_spender] = _value; 
    emit Approval(msg.sender, _spender, _value);

    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(_value <= balanceOf[_from], "Insufficient funds");
    require(_value <= allowance[_from][msg.sender], "Amount allocated to you is lessthan the requested amount");

    //change the balance
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;

    //update the allowance
    allowance[_from][msg.sender] -= _value;

    //transfer event
    emit Transfer(_from, _to, _value);

    //return a boolean
    return true;
  }



}