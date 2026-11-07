# Lab 2 validation

Prepared on 19 October 2026. This package was executed in a Linux x64 environment;
it has not been executed on your own Windows installation.

| Component | Version used |
| --- | --- |
| Node.js | 24.19.0 |
| npm | 11.9.0 |
| Hardhat | 3.20.0 |
| Hardhat ethers plugin | 4.2.1 |
| ethers | 6.17.0 |
| solc | 0.8.28 |

The four project dependencies are pinned to exact versions in `package.json`.
The transitive dependency resolutions are recorded in `package-lock.json`.
Node 24 is the selected classroom runtime; use a current supported patch release.

## Checks completed

- Installed the declared dependencies successfully.
- Ran `npm run compile`: one Solidity file compiled with solc 0.8.28,
  EVM target Cancun.
- Started the local node and confirmed chain ID 31337 through its JSON-RPC API.
- Ran `npm run deploy` against that node. The deployment receipt had success
  status, block number 1, and gas usage 153838 in this fresh-chain run.
- The deployment script read and asserted `i == 3000` and `j == 100`.
- Opened the interactive console against the same node and ran the README's
  connection, attachment, getter, and address commands. The getters returned
  `'3000'` and `'100'`; the address matched the deployed contract.
- Exited the console and stopped the test node.

The archive excludes installed packages, build outputs, and local blockchain
state. Run `npm ci` and `npm run compile` after extracting it. The compiler is
installed as the `solc` dependency and loaded locally by the Hardhat configuration.

The Windows terminal guidance follows the official documentation. The remaining
check is to repeat the README on the actual teaching computer before class.
