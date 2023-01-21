// SPDX-License-Identifier: GPL-3.0
//Author Group 4
//PArticipants Registry built using solidity
 pragma solidity 0.7.0;
  pragma experimental ABIEncoderV2;


contract ParticipantsRegistry {

    struct Participant {
        string  participantName;
        uint256 aadharNumber;
        uint dob;
        string gender;
        bool readyToParticipate;
    }

     event ParticipantAdded(address participant);
     event ParticipantDeleted(address participant);

      //Owner of the contract, address which deploys the contract
   address owner;

    //Constructor to initialize owner as the address which creates the contract
   constructor () public {
       owner = msg.sender;
   }

    //Pre execution Function/Validation Check - executes before the actual function call
   //This is usually added to other function definition as prerequisite 
   modifier onlyOwner() {
       require(msg.sender == owner);
       _;   //This step will ensure that next function call happens
   }

    //List of participants
    mapping (address => Participant) participantsList;

    //CRUD functions for participants

    //Add Participant
     function addParticipant(address _pAddress, string memory _participantName, uint _dob, string memory _gender, uint256 _aadharNumber) onlyOwner public {

        //Validate documentation of the participant by external/offchain -oracle
        require(checkDocumentation(_participantName, _dob, _aadharNumber));

        Participant memory participant;
       
        participant.participantName = _participantName;
        participant.dob = _dob;
        participant.gender = _gender;
        participant.aadharNumber = _aadharNumber;

        //Set the participation flag to true;
        participant.readyToParticipate = true;

        //Add participant to the participants list
        participantsList[_pAddress] = participant;

     }  


    //Remove participants
     function removeParticipant() onlyOwner public returns (bool) {

        participantsList[msg.sender].readyToParticipate = false;
        return true;

     }  


     function getParticipant(address _participantId) public view returns (Participant memory) {

        return participantsList[_participantId];

     }  


      function isValidParticipant(address _participantId) public view returns (bool) {

          if  (participantsList[_participantId].readyToParticipate) { 
              return true; 
          }

          return false;
     }  



     //Check valid documentation @TODO
    //External call to oracle @TODO
    function checkDocumentation(string memory  _name, uint _dob, uint256 _aadhar) public returns (bool) {
        return true;
    }



}
