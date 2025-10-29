# 🗳️ Voting DApp on Celo  

A simple decentralized voting application built with Solidity and deployed on the **Celo Blockchain (Sepolia Testnet)**.  
This project demonstrates how blockchain ensures fair, transparent, and tamper-proof voting.  
Perfect for beginners learning Solidity and smart contract deployment.
 <img width="1896" height="955" alt="Screenshot 2025-10-29 140429" src="https://github.com/user-attachments/assets/3fcdb6d3-6ba7-46d6-acac-4707456d9d0e" />

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
```

---

## 🚀 How to Run Locally

### 🧭 1️⃣ Clone the Repository
```bash
git clone https://github.com/Anamika-kumari-pandey/Voting-DApp-on-Celo.git
cd Voting-DApp-on-Celo
```

### 💻 2️⃣ Open Remix IDE
- Visit [Remix IDE](https://remix.ethereum.org)  
- Create a new file named `VotingApp.sol`  
- Paste the code above  

### ⚙️ 3️⃣ Compile & Deploy
1. Go to the **Solidity Compiler** tab  
2. Select **Compiler Version → 0.8.18**  
3. Click **Compile VotingApp.sol**  
4. Go to the **Deploy & Run Transactions** tab  
5. Choose **Injected Web3** and connect your **Celo wallet**  
6. Click **Deploy**  

### 🗳️ 4️⃣ Interact with the Contract
- `addCandidate("Alice")` → Add a candidate  
- `vote(0)` → Vote for candidate at index 0  
- `getCandidate(0)` → View candidate details and vote count  

---

## 🧩 Future Enhancements
- 🖥️ Build a React or Next.js front-end using **Celo Composer** or **Ethers.js**  
- 🧾 Add voter registration and time-based voting limits  
- 📊 Display live vote counts on UI  
- 🔐 Integrate decentralized identity (Celo Identity SDK)  

---

## 🙌 Acknowledgments
- 🌍 **Celo Blockchain** — for sustainable Web3 infrastructure  
- 🧪 **Remix IDE** — for beginner-friendly smart contract testing  
- 🔍 **Blockscout** — for transparent on-chain analytics  

---

## 💡 Pro Tip
Start small — experiment, break things, and learn how decentralized apps work under the hood!

---

## 🧠 Made with ❤️ by  
**Anamika Kumari Pandey**  
_Beginner Solidity Developer | Exploring Web3 on Celo 🌿_
