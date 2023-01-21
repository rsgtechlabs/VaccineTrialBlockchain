// SPDX-License-Identifier: GPL-3.0
//Author Group 4
//VakTok Registry built using solidity
 pragma solidity 0.7.0;
  pragma experimental ABIEncoderV2;

import "./Participants.sol";
import "./Doctors.sol";

contract VakTok {

    uint startDate;
    uint endDate;
    string trialDescription;
    string companyName;

     //Owner of the contract, address which deploys the contract
   address owner;

     constructor(uint startTime, uint endTime, string memory _trialDesc, string memory _companyName) {
       startDate = startTime;
       endDate = endTime;
       trialDescription = _trialDesc;
       companyName = _companyName;
        owner = msg.sender;
    
   }

    mapping (address => VakTokMetaData) vaktokList;
       
    ParticipantsRegistry participantsRego;
    DoctorsRegistry doctorsRego;


    struct VakTokMetaData {

     uint vaccineId;
     string vaccineName;

     bool hasVaccinatedBefore;

     ParticipantDoseHistory dosesHistory;

    }


     struct ParticipantDoseHistory {

        uint doseNumber;
        uint doseAdministrationDate;
        address doseAdministeredBy;  //Doctor Address
        string symptoms;
        bool consent;	
        
    }

    //First Vaccine
   function issueVakTok(address _participantId, uint _vaccineId, string memory _vaccineName, uint _doseAdministrationDate, string memory _symptoms, bool _consent) public returns (bool) {

        //if(doctorsRego.isValidDoctor(msg.sender)) {

        if (!vaktokList[_participantId].hasVaccinatedBefore) {

            ParticipantDoseHistory memory pHist;

            pHist.consent = _consent;
            pHist.doseNumber = 1;
            pHist.doseAdministrationDate = _doseAdministrationDate;
            pHist.symptoms = _symptoms;
            pHist.doseAdministeredBy = msg.sender;

            VakTokMetaData memory data = VakTokMetaData({vaccineId:_vaccineId, vaccineName:_vaccineName, hasVaccinatedBefore:true, dosesHistory:pHist});

            data.vaccineId = _vaccineId;
            data.vaccineName = _vaccineName;

            vaktokList[_participantId] = data;

            return true;

        }
      

        return false;

    }

    //Pre execution Function/Validation Check - executes before the actual function call
   //This is usually added to other function definition as prerequisite 
   modifier onlyOwner() {
       require(msg.sender == owner);
       _;   //This step will ensure that next function call happens
   }



    function getPersonVacHistory(address _personId) onlyOwner public view  returns (VakTokMetaData memory) {

        require(vaktokList[_personId].hasVaccinatedBefore);

        return vaktokList[_personId];

    }

}
