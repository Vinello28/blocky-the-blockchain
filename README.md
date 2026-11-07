# Lab 2 Solidity demonstration in VS Code

This project adapts the supplied Truffle and Ganache lab to Hardhat 3 for the
2026 demonstration. It keeps the original contract's two public variables,
`i = 3000` and `j = 100`. Students compile the contract, deploy it to a local
blockchain, and read its values from an interactive console.

This is a separate replacement project. The commands in the original Truffle
handout are not interchangeable with the commands below. Hardhat runs the local
blockchain in a terminal; this version does not reproduce the Ganache desktop GUI.

## 1 Check Node.js in your VS Code terminal

The Solidity and Prettier extensions help you edit code. They do not update the
Node.js runtime used by terminal commands or install this project's dependencies.

The original handout uses Windows. These instructions assume Windows too.
In VS Code, choose **Terminal > New Terminal**, open the terminal profile dropdown,
and choose **Command Prompt**. Run:

```bat
node --version
npm --version
where.exe node
node -p "process.execPath"
```

Use a current **Node.js 24 LTS** patch release for this project. The `engines`
entry deliberately selects Node 24 for a consistent classroom environment.
Hardhat 3 itself supports Node 22.13.0 and later maintained even-numbered major
versions; the project uses the narrower Node 24 choice.

If you installed Node with its ordinary Windows installer, download the Node 24
LTS Windows installer for your architecture from
<https://nodejs.org/en/download> and update that installation. If you already use
a Node version manager, select Node 24 with that manager instead of adding a
second installation method.

Close **all** VS Code windows after updating, reopen VS Code, create a new
terminal, and repeat the commands. `node --version` should show `v24.x.x`.
`npm --version` is a different version number and need not be 24.

If VS Code still shows the old version, the first entry returned by
`where.exe node` and the path printed by `process.execPath` identify the executable
being selected. Resolve the old PATH entry or version-manager selection before
installing the lab. Updating npm alone does not update Node.js.

If the warning continues, record the complete warning, the command that caused
it, and these four command outputs. A version warning cannot be diagnosed
precisely from the words "outdated Node" alone.

On macOS or Linux, use the same npm commands below; replace `where.exe node` with
`command -v node` and select Node 24 using your existing installation method.

## 2 Open the project and install dependencies

Extract the ZIP into a new directory. In VS Code use **File > Open Folder** and
open the `lab2-hardhat-2026` folder that contains `package.json` and
`hardhat.config.ts`. Open the terminal there.

```bat
npm ci
npm run compile
```

`npm ci` installs the dependency versions recorded in `package-lock.json`.
Keep that file when distributing the project. Installation requires internet.
The Solidity compiler is included as a pinned npm dependency, so compilation
uses the local compiler rather than downloading another compiler.

Do this rehearsal before class on the actual demonstration laptop. Do not run
`create-react-app`, `truffle init`, or `hardhat --init` inside this prepared project.

## 3 Show the Solidity contract

Open `contracts/TestContract.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract TestContract {
    uint public i = 3000;
    int public j = 100;
}
```

- `uint` is an unsigned 256-bit integer; `int` is a signed 256-bit integer.
- `public` makes Solidity generate getter functions named `i()` and `j()`.
- These initial values are stored when the contract is deployed.
- This contract has no setter function. Making a variable `public` does not
  automatically provide a way to change it from outside the contract.

Compilation produces ABI and bytecode files under `artifacts/`. It does not
deploy the contract or write a transaction to the blockchain.

## 4 Start the local blockchain in terminal 1

```bat
npm run node
```

Leave this terminal running. The node listens on `http://127.0.0.1:8545`
with chain ID `31337` and displays funded development accounts.
These accounts and their displayed private keys are only for local testing.

## 5 Deploy in terminal 2

Open a second VS Code terminal in the same project directory:

```bat
npm run deploy
```

The script deploys a new `TestContract`, waits for the deployment transaction,
reads both variables, and checks their values. It prints the actual address,
transaction hash, block number, gas used, and:

```text
i = 3000
j = 100
Deployment and both getter calls succeeded.
```

Copy the **TestContract address** from this run for the next step. The command
always deploys a new instance, so do not assume an address from a previous run.
The node terminal shows the deployment and RPC activity.

## 6 Read the deployed contract in the console

In terminal 2:

```bat
npm run console
```

At the `>` prompt, enter these JavaScript commands one line at a time. Replace
`PASTE_DEPLOYED_ADDRESS_HERE` with the address printed in step 5, keeping quotes.

```javascript
const { ethers } = await network.create();
const instance = await ethers.getContractAt("TestContract", "PASTE_DEPLOYED_ADDRESS_HERE");
(await instance.i()).toString();
(await instance.j()).toString();
await instance.getAddress();
```

The two getter calls return the strings `'3000'` and `'100'`.
Without `.toString()`, ethers returns JavaScript BigInts such as `3000n` and
`100n`; the `n` suffix does not indicate an error.

Getter calls here use `eth_call`: they read state without submitting a
transaction or charging the caller a transaction fee. Deployment submits a
transaction, consumes gas, and changes blockchain state.

Exit the console with:

```text
.exit
```

The supplied npm scripts select `--network localhost` explicitly, so deployment
and console commands connect to the same running node.

## 7 Repeat the demonstration from the beginning

1. Exit the interactive console.
2. Stop the node in terminal 1 with **Ctrl+C**.
3. Run `npm run node` again in terminal 1.
4. Run `npm run deploy` in terminal 2.
5. Run `npm run console` and use the address from the new deployment.

The default local blockchain is in memory. Stopping and restarting its process
clears its contracts, balances modified during the demo, and transaction history.
The Solidity files and compiled artifacts remain on disk. You do not need to
reinstall dependencies for every demonstration.

## Troubleshooting

| Symptom | Action |
| --- | --- |
| Node version warning | Check `node --version` and `node -p "process.execPath"` in the same VS Code terminal that fails. Reopen VS Code after an update. |
| `npm.ps1 cannot be loaded` | Use the Command Prompt terminal profile, or call `npm.cmd` / `npx.cmd` from PowerShell. No permanent execution-policy change is needed for these commands. |
| `ECONNREFUSED` or cannot connect to 127.0.0.1:8545 | Start `npm run node` in terminal 1 and leave it running. |
| Address already in use on port 8545 | Check whether your earlier lab node is still running. Stop that known process, then start one instance. |
| Cannot find `package.json` or Hardhat config | Open the actual extracted project folder containing those files. |
| Missing artifact | Run `npm run compile` and ensure the contract name is exactly `TestContract`. |
| Empty return data or contract missing after restart | Redeploy to the restarted node and copy the newly printed address. |
| `Identifier has already been declared` in console | Exit and reopen the console, then enter each `const` declaration once. |
| Windows native module or missing runtime DLL error | Check the Microsoft Visual C++ Redistributable requirement linked from the official Hardhat setup guide. |

## Corrections to the old handout

| Original step | Updated interpretation |
| --- | --- |
| Create a React app | Unnecessary for this contract-only lab. There is no React frontend in the exercise. Create React App is also deprecated. |
| Install Truffle locally and globally | This project installs Hardhat locally through `npm ci`; its npm scripts select that local version. |
| Ganache desktop | `npm run node` starts Hardhat's local blockchain in a terminal. |
| `TestContract` versus `artifacts.require("testCon")` | The screenshot names differ. Contract identifiers must be consistent. This project uses `TestContract` throughout. |
| Compiled contract shown in Ganache | A GUI can display local artifacts; compilation alone does not put bytecode on the blockchain. |
| `truffle migrate -reset` | The documented Truffle option is `--reset`. It is not a Hardhat command. |
| `TestContract.deployed()` described as verification | It obtains an instance associated with Truffle's recorded deployment. It is not source-code verification. Here the script confirms a successful deployment receipt and getter results. |

If your course specifically requires the Truffle and Ganache interfaces, keep
that as a separate legacy environment. The supplied screenshots show Truffle
5.11.5 and Node 20.18.0. They are historical environment details, not a current
Node recommendation. Do not assume installing Node 24 will make every archived
Truffle dependency compatible.

## Official references

- Node downloads: <https://nodejs.org/en/download>
- Hardhat Node support: <https://hardhat.org/docs/reference/nodejs-support>
- Hardhat setup and Windows C++ runtime requirement: <https://hardhat.org/docs/tutorial/setup>
- Local node: <https://hardhat.org/docs/guides/hardhat-node>
- Ethers plugin: <https://hardhat.org/docs/plugins/hardhat-ethers>
- Console: <https://hardhat.org/docs/guides/hardhat-console>
- Custom compiler: <https://hardhat.org/docs/cookbook/custom-solidity-compiler>
- Truffle and Ganache retirement announcement: <https://consensys.com/blog/consensys-announces-the-sunset-of-truffle-and-ganache-and-new-hardhat>
- Create React App deprecation: <https://react.dev/blog/2025/02/14/sunsetting-create-react-app>

Use `VALIDATION.md` for the exact environment and checks run when preparing this
package. These do not replace rehearsal on your own Windows computer.
