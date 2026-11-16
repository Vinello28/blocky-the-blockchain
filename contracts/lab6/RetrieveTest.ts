import { network } from "hardhat";

const { ethers } = await network.getOrCreate();
const [sender, recipient] = await ethers.getSigners();

const contract = await ethers.deployContract("EventExample");
await contract.waitForDeployment();

const tx = await contract.transfer(recipient.address, 100);
const receipt = await tx.wait();

const event = receipt?.logs.find(
  (log) =>
    log instanceof ethers.EventLog &&
    log.eventName === "Transfer"
);

if (!(event instanceof ethers.EventLog)) {
  throw new Error("Transfer event was not emitted");
}

console.log("Event:", event.eventName);
console.log("From:", event.args[0]);
console.log("To:", event.args[1]);
console.log("Amount:", event.args[2].toString());