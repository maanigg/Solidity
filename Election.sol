//SPDX-License-Identifier: Fahim AK
pragma solidity ^0.8.2;

contract Election {
    // Model a Candidate

    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    Candidate newCandidate;

    modifier Owner {
        require(msg.sender == owner, "You dont have the facilities for that big man :(");
        _;
    }

    function Elections (string memory _name) Owner public {
        newCandidate = Candidate(candidatesCount+1, _name, 0);
        candidatesCount += 1;
        addCandidate();
    }

    function addCandidate () private {     
        candidates[candidatesCount] = newCandidate;
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender],"Aldready Voted!");
        // require candidate exists
        require(_candidateId<candidatesCount && _candidateId > 0, "Candidate does not exist!");
        // record that voter has voted
        voters[msg.sender] = true;
        // update candidate vote Count
        candidates[_candidateId].voteCount += 1;
        // trigger voted event
        emit votedEvent(_candidateId);
    }

    //Return winner ID, Name and VoteCount
    function winner() Owner public view returns(uint, string memory, uint){
        uint winnerTrack = 1;
        for(uint j = 1; j<=candidatesCount; j++){
            if(candidates[j].voteCount > candidates[winnerTrack].voteCount){
                winnerTrack = j;
            }
        }
        return (candidates[winnerTrack].id, candidates[winnerTrack].name, candidates[winnerTrack].voteCount);
    }
}
