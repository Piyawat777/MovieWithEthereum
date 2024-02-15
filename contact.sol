// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract ProofOfAC_Movie {  

  event Add(
    address owner,
    string movie
  );
  
  function purchase(string memory name) public payable {
    emit Add(msg.sender, name);
  }

}