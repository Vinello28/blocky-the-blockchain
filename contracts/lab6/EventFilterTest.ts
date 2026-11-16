import { network } from "hardhat";

const { ethers } = await network.getOrCreate();
const [sender, recipient] = await ethers.getSigners();

const contract = await ethers.deployContract("EventExample");
await contract.waitForDeployment();

const tx = await contract.transfer(recipient.address, 100);
const receipt = await tx.wait();

if (!receipt) {
  throw new Error("Transaction receipt was not available");
}

const transferFilter = contract.filters.Transfer(
  sender.address,
  recipient.address
);
const events = await contract.queryFilter(
  transferFilter,
  receipt.blockNumber,
  receipt.blockNumber
);
const event = events[0];

if (!(event instanceof ethers.EventLog)) {
  throw new Error("Filtered Transfer event was not found");
}

console.log("Event:", event.eventName);
console.log("From:", event.args[0]);
console.log("To:", event.args[1]);
console.log("Amount:", event.args[2].toString());
