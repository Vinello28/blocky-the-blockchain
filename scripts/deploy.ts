import assert from "node:assert/strict";
import { network } from "hardhat";

const connection = await network.create();
try {
  const { ethers } = connection;
  const [deployer] = await ethers.getSigners();
  console.log("Deployer:", await deployer.getAddress());

  const contract = await ethers.deployContract("TestContract");
  await contract.waitForDeployment();
  const tx = contract.deploymentTransaction();
  assert.ok(tx, "A deployment transaction should exist");
  const receipt = await tx.wait();
  assert.ok(receipt && receipt.status === 1, "Deployment must succeed");

  const i = await contract.i();
  const j = await contract.j();
  assert.equal(i, 3000n);
  assert.equal(j, 100n);

  console.log("TestContract address:", await contract.getAddress());
  console.log("Deployment transaction:", tx.hash);
  console.log("Block:", receipt.blockNumber);
  console.log("Gas used:", receipt.gasUsed.toString());
  console.log("i =", i.toString());
  console.log("j =", j.toString());
  console.log("Deployment and both getter calls succeeded.");
} finally {
  await connection.close();
}
