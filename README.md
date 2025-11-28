Multi-Signature Treasury on Sui
Secure · Threshold-Based · Trustless On-Chain Governance

This project implements a fully on-chain Multi-Signature Treasury system on the Sui blockchain.
It enables multiple owners to collectively approve high-value transactions using a threshold-based governance model.

This repository contains:

Complete Move smart contract modules
Testnet deployment proofs
Multisig proposal creation, signing, and execution flow
Real object IDs and transaction digests
Step-by-step usage guide

1. Problem Statement
Managing shared funds with centralized control is risky:
One compromised private key can drain the treasury
Team-based organizations need collective approval
DAO treasuries lack on-chain approval mechanisms
Sensitive transactions need multi-party validation

Goal:
Build a trustless, decentralized Multi-Signature Treasury where funds can only move after required approvals (threshold signatures).

2. Project Objective
The objective of this project is to:
Implement a secure Treasury contract held by multiple owners
Support proposal creation for transactions
Allow each owner to sign proposals
Enforce an approval threshold before execution
Guarantee immutability until threshold is satisfied
Provide testnet deployment + real execution proof

3. Architecture Overview
Modules
Module	Responsibility
treasury.move	Creates treasury, stores owners, threshold, executes proposals
proposal.move	Stores transaction details + signature list
policy_manager.move	Manages owner rights / policies
emergency.move	Emergency pause handling
utils.move	Helpers (address matching, list mgmt)

Core Features
Multi-owner treasury
Threshold-based signing (M-of-N)
Proposal creation & off-chain execution data
Signatures stored on-chain
Once threshold is met → automatic execution
Full testnet verification

4. Tech Stack
Sui Move (Smart Contracts)
Sui Client CLI
Sui Testnet
VS Code / GitHub Codespaces

5. Deployment Details
Package Published on Sui Testnet
0xa5e3dc99aca4ac0ef27be4dc9b5bd2d8b51a2be7c3f04410767e6d9d248363db

Modules deployed:
treasury
proposal
utils
policy_manager
emergency

6. Important Object IDs
Treasury Object
0x13fa2c61a27843b69c4061300b9d62ffe3e8b334cb4cbe5ff8f753543d2b1a7c

Proposal Object
0x8a46d312e181d46a3c03527d6a388a96a6b51f9a642c7657bb2249979d8cf49f

7. Verified Transactions (Proof of Working Flow)
Each transaction is executed on Sui Testnet and validated.

Contract Publish
2p3Kam23B57BwhSV9KvNjBsuk53pj3Lyptm33S5U3ZND

Treasury Created
8yMgmHwM2sZgiZvcYkfAyyywFuas9MVJZFLh3B14k6r5

Proposal Created
FLeAJ28W7ThVMeJNAqkxoHHzdtqZBg9kGq9gwb6ng5kb

Owner Signature 1
8vLyqnntKLepNphC6nZNAtsyph98frzuZ1Leuy3L2h9r

Owner Signature 2
87WEDWLVy51G6gpnWyaRwd9MRrrGuJ7wnmZKTgz39RAs

Proposal Executed
2P1SH3UhweudouzrkeWKPfqX8wyBuBrbMb7PkVGsDBdT

8. Usage Guide (Step by Step)
1. Publish Package
sui client publish .

2. Create Treasury
sui client call \
  --package <PACKAGE_ID> \
  --module treasury \
  --function create_treasury \
  --args '[owner1, owner2]' <threshold> \
  --gas-budget 10000000

3. Create Proposal
sui client call \
  --package <PACKAGE_ID> \
  --module proposal \
  --function create_proposal \
  --args <creator> <action_type> <amount> \
  --gas-budget 10000000

4. Sign Proposal
sui client call \
  --package <PACKAGE_ID> \
  --module proposal \
  --function sign_proposal \
  --args <proposal_object> <owner_address> \
  --gas-budget 10000000

Repeat for each required signer.

5. Execute Proposal
sui client call \
  --package <PACKAGE_ID> \
  --module treasury \
  --function execute_transactions \
  --args <treasury_object> \
  --gas-budget 10000000

9. Impact

Real working multisig architecture
Fully deployed on testnet
Actual execution of threshold-based flow
Clean module separation
Original implementation, not a copy
Demonstrates governance + security level
Clear documentation (this README)
End-to-end functional proof through transactions
