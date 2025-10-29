# VotingApp
A simple decentralized voting application built with Solidity and deployed on the Celo Blockchain (Sepolia Testnet).
This project demonstrates how blockchain can ensure fair, transparent, and tamper-proof voting.
<img width="1896" height="955" alt="Screenshot 2025-10-29 140429" src="https://github.com/user-attachments/assets/95e57694-db25-45a9-b091-3a7d820dc020" />

# 🗳️ Voting DApp on Celo

A simple **decentralized voting application** built with **Solidity** and deployed on the **Celo Blockchain (Sepolia Testnet)**.  
This project demonstrates how blockchain ensures **fair**, **transparent**, and **tamper-proof** voting for everyone.  

![Voting DApp Banner](image)

---

## 📜 Project Description
The **Voting DApp** allows users to vote for their favorite candidates in a transparent and verifiable way.  
Each voter can vote **only once**, and every vote is stored **on-chain**, ensuring it cannot be modified or deleted.

This project is designed for **beginners learning Solidity** and **Celo smart contract development**.

---

## ⚙️ What It Does
- The **contract owner** deploys the smart contract.  
- The owner can **add candidates** before voting begins.  
- **Users** connect their wallet and vote for their preferred candidate.  
- Each wallet address can vote **only once**.  
- Anyone can view candidate details and vote counts.  

---

## 🌟 Features
🧠 **Beginner-Friendly** — Clean and simple Solidity code.  
🔒 **One-Vote Rule** — Each wallet address can vote only once.  
⛓️ **On-Chain Transparency** — Every vote is recorded publicly on the blockchain.  
🪙 **Deployed on Celo Sepolia** — Uses Celo’s eco-friendly testnet for smooth developer experience.  
👑 **Owner Privileges** — Only the contract deployer can add candidates.  

---

## 📄 Smart Contract Details
- **Language:** Solidity ^0.8.18  
- **Framework:** Remix IDE / Hardhat compatible  
- **Network:** Celo Sepolia Testnet  
- **License:** MIT  

### 🔗 Deployed Contract
**Contract Address:** `XXX`  
**View on Blockscout:** [Click Here](https://sepolia-blockscout.celo-testnet.org/)  

---

## 💻 Smart Contract Code
```solidity
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

    // Events
    event Voted(address indexed voter, uint256 candidateIndex);
    event CandidateAdded(string name);

    // Constructor — set the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Restrict functions to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Add candidate (only owner)
    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({name: _name, voteCount: 0}));
        emit CandidateAdded(_name);
    }

    // Vote for a candidate by index
    function vote(uint256 candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        require(candidateIndex < candidates.length, "Invalid candidate index");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;

        emit Voted(msg.sender, candidateIndex);
    }

    // Get total candidates
    function getTotalCandidates() public view returns (uint256) {
        return candidates.length;
    }

    // Get candidate details
    function getCandidate(uint256 index) public view returns (string memory, uint256) {
        require(index < candidates.length, "Invalid index");
        Candidate memory c = candidates[index];
        return (c.name, c.voteCount);
    }
}

