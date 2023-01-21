// SPDX-License-Identifier: GPL-3.0
//Author Group 4
//Doctors Registry built using solidity
 pragma solidity 0.7.0;
 pragma experimental ABIEncoderV2;
 


contract DoctorsRegistry {

    struct Doctor {
        string  doctorName;
        uint256 aadharNumber;
        uint dob;
        string gender;
        bool isPractising;
    }


     //Owner of the contract, address which deploys the contract
   address owner;

     event DoctorAdded(address _doctor);
     event DoctorDeleted(address _doctor);

      //Constructor to initialize owner as the address which creates the contract
   constructor () public {
       owner = msg.sender;
   }

    //List of Doctors
    mapping (address => Doctor) doctorsList;

     //Pre execution Function/Validation Check - executes before the actual function call
   //This is usually added to other function definition as prerequisite 
   modifier onlyOwner() {
       require(msg.sender == owner);
       _;   //This step will ensure that next function call happens
   }

    //CRUD functions for Doctors

    //Add Doctor
     function addDoctor(address _dAddress, string memory _doctorName, uint _dob, string memory _gender, uint256 _aadharNumber) onlyOwner public {

        //Validate documentation of the Doctor by external/offchain -oracle
        require(checkDocumentation(_doctorName, _dob, _aadharNumber));

        Doctor memory doctor;
       
        doctor.doctorName = _doctorName;
        doctor.dob = _dob;
        doctor.gender = _gender;
        doctor.aadharNumber = _aadharNumber;

        //Set the participation flag to true;
        doctor.isPractising = true;

        //Add Doctor to the Doctors list
        doctorsList[_dAddress] = doctor;

     }  


    //Remove Doctors
     function removeDoctor(address _dAddress) onlyOwner public returns (bool) {

        doctorsList[_dAddress].isPractising = false;
        return true;

     }  


     function getDoctor(address _doctorId) public view returns (Doctor memory) {

        return doctorsList[_doctorId];

     }  



     //Check valid documentation @TODO
    //External call to oracle @TODO
    function checkDocumentation(string memory  _name, uint _dob, uint256 _aadhar) public returns (bool) {
        return true;
    }


     function isValidDoctor(address _doctorId) view public returns (bool) {

          if  (doctorsList[_doctorId].isPractising) { 
              return true; 
          }

          return false;
     }  



}
