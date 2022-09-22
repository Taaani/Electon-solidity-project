// SPDX-License-Identifier: GPL-3.0


pragma solidity >0.5.0 <0.9.0;

contract Election{

    struct candidate{
        string name;
        uint voteCount;

    }
    
    struct voter{
        bool authorized;
        bool voted;
        uint vote;

    }
    address public owner;  // owner who deploy the smart contract
    string public electionName;
    mapping(address => voter) public voters;
    candidate[] public candidates;
    uint public totalVoters;


   
    constructor(string memory name){ // it s constructor function when SC deploy its excuted automatically
       owner = msg.sender;
       electionName = name;
    }

     modifier onlyOwner(){  // we use modifier at those place were we need that this method is only called by the owner
       require(msg.sender == owner , "you are not the contract owner");
        _;
    }
    

    function addCandidate(string memory _name) public onlyOwner{
        candidates.push(candidate(_name,0));
    }
    // in the blockchain reading the blockChain is free
    function getNumberOfCandidates()view public returns(uint){
       return  candidates.length;
    }
    // owner of the contract otherized the any person to cost the vote
    function authorizedVoter(address _voterPerson)public onlyOwner{
        voters[_voterPerson].authorized = true;
    }
    
    // now any person who autherized he do vot for any person
    function doVote(uint voteIndex)public{
        require(voters[msg.sender].voted == false, "you already voted");
        require(voters[msg.sender].authorized == true , "you are not athorized by the owner");

        voters[msg.sender].voted == true;
        voters[msg.sender].vote = voteIndex;
        candidates[voteIndex].voteCount += 1;
        totalVoters += 1;
    }

//    function destroy()  onlyOwner public {
//         selfdestruct(owner);
//     }




}