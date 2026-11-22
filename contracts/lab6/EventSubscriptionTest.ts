import { network } from "hardhat";

const { ethers } = await network.getOrCreate();
const [sender, recipient] = await ethers.getSigners();

const contract = await ethers.deployContract("EventExample");
await contract.waitForDeployment();

const transferReceived = new Promise<{
  from: string;
  to: string;
  amount: bigint;
}>((resolve, reject) => {
  const timeout = setTimeout(
    () => reject(new Error("Timed out waiting for Transfer event subscription")),
    10_000
  );

  contract.once(
    "Transfer",
    (from: string, to: string, amount: bigint) => {
      clearTimeout(timeout);
      resolve({ from, to, amount });
    }
  );
});

const tx = await contract.transfer(recipient.address, 250);
await tx.wait();

const event = await transferReceived;

if (event.from !== sender.address) {
  throw new Error(`Unexpected event sender: ${event.from}`);
}
if (event.to !== recipient.address) {
  throw new Error(`Unexpected event recipient: ${event.to}`);
}
if (event.amount !== 250n) {
  throw new Error(`Unexpected event amount: ${event.amount}`);
}

console.log("Subscription event:", event);
