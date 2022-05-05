//SPDX-License-Identifier: Fahim AK
pragma solidity ^0.8.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    Candidate alice = Candidate(1, "Alice", 0);
    Candidate bob = Candidate(2, "Bob", 0);
    Candidate charlie = Candidate(3, "Charlie", 0);

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

    function Elections (string memory _name) public {
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

        bool candidateTrack = false;
        uint currCandidate;
        

        // require a valid candidate
        for(uint i = 1; i < candidatesCount ; i++){
            if(candidates[i].id == _candidateId){
                candidateTrack = true;
                currCandidate = i;
            }
        }
        require(candidateTrack == true,"Candidate Does not exist");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[currCandidate].voteCount += 1;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
