# zkcp_NoirImp

**Zero Knowledge Contingent Payment (ZKCP) Implementation using Noir and Ethereum**

## Introduction

zkcp_NoirImp is a proof-of-concept implementation of a Zero Knowledge Contingent Payment (ZKCP) protocol. ZKCP enables fair exchange of digital goods between two parties on Ethereum, using zero-knowledge proofs (ZKPs) to guarantee that the seller possesses the correct file *before* the buyer makes payment-without revealing the file itself. This approach removes the need for trusted third parties, reduces on-chain transaction costs, and minimizes dispute resolution complexity.

## Features

- **Fair Exchange Protocol**: Ensures buyers only pay if the seller possesses the correct file.
- **Zero-Knowledge Proofs**: Utilizes Noir for succinct, non-interactive SNARK proofs.
- **Ethereum Smart Contracts**: Handles payments and proof verification.
- **No Trusted Third Party**: All verification is cryptographically enforced.

## How It Works

1. **Agreement**: Buyer and seller agree on file properties (auxiliary info).
2. **Proof Generation**: Seller generates a ZK proof (using Noir) of file possession.
3. **Proof Verification**: Buyer verifies the proof off-chain.
4. **Payment**: Buyer locks payment in the smart contract.
5. **Key Reveal**: Seller reveals the decryption key.
6. **File Decryption**: Buyer decrypts the file and completes the exchange.

## Technology Stack

- **Ethereum** (Solidity, `solc` 0.8.30)
- **Noir** (ZK language, `nargo` 1.0.0-beta.3)
- **SNARKs** (Succinct Non-interactive Arguments of Knowledge)


## Deployment

**Smart Contract Addresses (Ethereum Testnet):**
- `HonkVerifier`: `0xa1ae13a7fc3b83aa3fe01b6db0c82326e900125f`
- `ZKCP`: `0xb5546b239bc6227c90abadb620d1d7a0e7ce1621`

## Gas and Transaction Costs

| Contract Function | Gas Cost  | Tx Cost (ETH) |
|-------------------|-----------|---------------|
| `prove`           | 2,052,068 | 0.01          |
| `buy`             |   31,020  | 0.0002        |
| `keyReveal`       |   43,684  | 0.0002        |

*(Assuming gas price ≈ 4.8 Gwei)*

## Getting Started

### Prerequisites

- Remix, hardhat or any other platform for you to deploy and interact with smart contract
- [Noir & Nargo](https://noir-lang.org/)
- Ethereum testnet wallet (e.g., [MetaMask](https://metamask.io/))

### Build and Test

1. **Clone the repository:**
git clone https://github.com/amudhan23/zkcp_NoirImp.git
cd zkcp_NoirImp

2. **Compile Noir circuits:**
nargo build
3. **Deploy smart contracts:**
- Use [Hardhat](https://hardhat.org/) or your preferred tool.
- Update contract addresses as needed.

4. **Run protocol:**
- Generate a proof with Noir.
- Interact with the smart contract to submit proofs and payments.

### Note
Nargo command for proof generates one single output that contains both the proof and the public parameters. Follow the steps in this doc [Instructions for segregating proof and pub params](https://noir-lang.org/docs/how_to/how-to-solidity-verifier) to seperate out these both.  

### Example Usage

- See `proof.txt` and `publicParameter.txt` for sample proof and public parameter files.
- Review `zkcp.sol` for protocol contract logic.
- Verifier.sol(in target folder) is the solidity file noir generates for on chain proof verification.

## Future Work
 Recursive SNARKs for efficient large file verification

## References

1. M. Campanelli, R. Gennaro, S. Goldfeder, and L. Nizzardo. *Zero-knowledge contingent payments revisited: Attacks and payments for services*. In Proceedings of the 2017 ACM SIGSAC Conference on Computer and Communications Security, CCS ’17, pages 229–243, New York, NY, USA, 2017. Association for Computing Machinery.
2. S. Dziembowski, L. Eckey, and S. Faust. *Fairswap: How to fairly exchange digital goods*. In Proceedings of the 2018 ACM SIGSAC Conference on Computer and Communications Security, CCS ’18, page 967–984, New York, NY, USA, 2018. Association for Computing Machinery.
3. [Noir Language Documentation](https://noir-lang.org/)

