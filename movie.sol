// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract ProofOfStudent {  

  struct Registration {
    address registrant;
    string name;
    uint256 timestamp;
  }

  mapping (string => Registration) private listStudent;
  string[] private studentNames;

  //---events---
  event NameAdded(
    address indexed registrant,   
    string name,
    uint256 timestamp
  );
  
  event RegistrationError(
    address indexed registrant,
    string name,
    string reason
  );

  // record a student name
  function registration(string memory name) public payable {
    //---check if string was previously stored---
    if (listStudent[name].registrant != address(0)) {
        //---fire the event---
        emit RegistrationError(msg.sender, name, 
            "This student name was added previously");

        //---refund back to the sender---
        payable(msg.sender).transfer(msg.value);
        
        //---exit the function---
        return;
    }
    //---check if msg.value != 0.002 ether---

    listStudent[name] = Registration(msg.sender, name, block.timestamp);
    studentNames.push(name); // Add the name to the list of student names
    //---fire the event---
    emit NameAdded(msg.sender, name, block.timestamp);
  }
  
  // check name of student in this class
  function checkName(string memory name) public view returns (bool) {
    return listStudent[name].registrant != address(0);
  }

    // check student's registration details
    function checkRegistrationDetails() public view returns (address[] memory, string[] memory, uint256[] memory) {
        address[] memory registrants = new address[](studentNames.length);
        string[] memory names = new string[](studentNames.length);
        uint256[] memory timestamps = new uint256[](studentNames.length);

        for (uint256 i = 0; i < studentNames.length; i++) {
            registrants[i] = listStudent[studentNames[i]].registrant;
            names[i] = listStudent[studentNames[i]].name;
            timestamps[i] = listStudent[studentNames[i]].timestamp;
        }

        return (registrants, names, timestamps);
    }

}