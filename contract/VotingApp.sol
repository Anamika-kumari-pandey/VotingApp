// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
 * 🗳️ Simple Voting DApp — Beginner Friendly Solidity Project
 * ------------------------------------------------------------
 * This contract allows users to vote for candidates.
 * The owner adds candidates, and anyone can vote once.
 */

contract VotingApp {

    // Address of the contract owner
    address public owner;

    // Structure to represent each candidate
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // Dynamic array to store all candidates
    Candidate[] public candidates;

    // Mapping to track who has voted
    mapping(address => bool) public hasVoted;

    // Event for logging votes
    event Voted(address indexed voter, uint256 candidateIndex);
    event CandidateAdded(string name);

    // Constructor — set the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict functions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Function to add a candidate (only owner can do this)
    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({name: _name, voteCount: 0}));
        emit CandidateAdded(_name);
    }

    // Function to vote for a candidate by index
    function vote(uint256 candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        require(candidateIndex < candidates.length, "Invalid candidate index");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;

        emit Voted(msg.sender, candidateIndex);
    }

    // Function to get the total number of candidates
    function getTotalCandidates() public view returns (uint256) {
        return candidates.length;
    }

    // Function to get candidate details
    function getCandidate(uint256 index) public view returns (string memory, uint256) {
        require(index < candidates.length, "Invalid index");
        Candidate memory c = candidates[index];
        return (c.name, c.voteCount);
    }
}
