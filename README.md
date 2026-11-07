# Blocky the Blockchain

![Hardhat](https://img.shields.io/badge/Hardhat-3.20.0-FFF100?style=for-the-badge&labelColor=FFF100&logo=hardhat&logoColor=000000)
![Solidity](https://img.shields.io/badge/Solidity-0.8.28-363636?style=for-the-badge&labelColor=363636&logo=solidity&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6?style=for-the-badge&labelColor=3178C6&logo=typescript&logoColor=white)
![Ethers.js](https://img.shields.io/badge/Ethers.js-6.17.0-2535A0?style=for-the-badge&labelColor=2535A0&logo=ethereum&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-24.x-5FA04E?style=for-the-badge&labelColor=5FA04E&logo=nodedotjs&logoColor=white)
![npm](https://img.shields.io/badge/npm-11.x-CB3837?style=for-the-badge&labelColor=CB3837&logo=npm&logoColor=white)

Educational Solidity workspace for exploring smart contracts, data structures and
deployment workflows with Hardhat 3.

The repository contains the practical exercises for the *Software Security &
Blockchain* course. Each lab is intentionally small and focused, making it easy
to inspect the Solidity source, compile it locally and experiment with the
resulting contracts.

## Contents

| Directory | Topics |
| --- | --- |
| [`contracts/lab2`](contracts/lab2) | Contract basics and state variables |
| [`contracts/lab3`](contracts/lab3) | Functions and control structures |
| [`contracts/lab4`](contracts/lab4) | Structs, arrays, mappings and messages |
| [`scripts`](scripts) | TypeScript deployment scripts |
| [`artifacts`](artifacts) | Generated contract artifacts |

## Tech stack

- **Hardhat 3** — compilation, local development node and task runner
- **Solidity 0.8.28** — smart contract language and compiler
- **Ethers.js 6** — contract deployment and interaction
- **TypeScript** — scripts and developer tooling
- **Node.js 24** — supported runtime

## Prerequisites

- Node.js 24.x
- npm 11.x
- A terminal and a code editor

Check the installed versions before starting:

```bash
node --version
npm --version
```

## Getting started

Clone the repository, install the dependencies and compile the contracts:

```bash
git clone https://github.com/Vinello28/blocky-the-blockchain.git
cd blocky-the-blockchain
npm ci
npm run compile
```

If no lockfile is available in your checkout, use `npm install` once to resolve
the dependencies and generate it.

Compilation uses the locally installed Solidity compiler configured in
[`hardhat.config.ts`](hardhat.config.ts) and writes generated files to
[`artifacts`](artifacts).

## Local development workflow

### Start a local node

In the first terminal, start the JSON-RPC development node:

```bash
npm run node
```

The node is available at `http://127.0.0.1:8545` with chain ID `31337`.
Development accounts are funded automatically and must only be used for local
testing.

### Deploy the example contract

In a second terminal, deploy `TestContract`:

```bash
npm run deploy
```

The deployment script waits for the transaction receipt, prints the deployed
address and verifies that the public values are:

```text
i = 3000
j = 100
```

### Interact from the console

Connect to the same local node:

```bash
npm run console
```

At the interactive prompt, replace the placeholder with the address printed by
the deployment command:

```javascript
const { ethers } = await network.create();
const instance = await ethers.getContractAt("TestContract", "DEPLOYED_ADDRESS");
(await instance.i()).toString();
(await instance.j()).toString();
await instance.getAddress();
```

Exit with:

```text
.exit
```

The local chain runs in memory. Restarting `npm run node` clears its deployed
contracts and transaction history, so deploy again after every restart.

## Available scripts

| Command | Description |
| --- | --- |
| `npm run compile` | Compile all Solidity contracts |
| `npm run node` | Start the local JSON-RPC development node |
| `npm run deploy` | Deploy `TestContract` to the local node |
| `npm run console` | Open an interactive console connected to the local node |

## Project conventions

- Keep contracts grouped by exercise under `contracts/lab*`.
- Use Solidity `0.8.28` unless an exercise explicitly requires another version.
- Treat `artifacts/` and `cache/` as generated output.
- Keep deployment and interaction logic in TypeScript under `scripts/`.
- Never use development private keys or local accounts outside a local test
  environment.

## Troubleshooting

| Symptom | Resolution |
| --- | --- |
| `ECONNREFUSED 127.0.0.1:8545` | Start `npm run node` and keep that terminal open. |
| Contract not found after restarting the node | Deploy again and use the new address. |
| Missing artifact | Run `npm run compile` from the repository root. |
| Node version warning | Use Node.js 24.x and reopen the terminal after changing versions. |
| `npm.ps1 cannot be loaded` on Windows | Use a Command Prompt terminal or invoke `npm.cmd`. |

For the environment details and validation checks used for this project, see
[`VALIDATION.md`](VALIDATION.md).

## License

This project is intended for educational use as part of the course material.
