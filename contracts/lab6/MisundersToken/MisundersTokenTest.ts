import { network } from "hardhat";

const { ethers } = await network.getOrCreate();
const [deployer, recipient, spender] = await ethers.getSigners();

const token = await ethers.deployContract("MisundersToken", [1000]);
await token.waitForDeployment();
const tokenAddress = await token.getAddress();

const initialBalance = await token.balanceOf(deployer.address);
const initialSupply = await token.totalSupply();

if ((await token.name()) !== "MisundersToken") {
  throw new Error("Unexpected token name");
}
if ((await token.symbol()) !== "MUND") {
  throw new Error("Unexpected token symbol");
}
if ((await token.decimals()) !== 18n) {
  throw new Error("Unexpected token decimals");
}

const unit = 10n ** 18n;
if (initialBalance !== 1000n * unit) {
  throw new Error("Initial owner balance is incorrect");
}
if (initialSupply !== 1000n * unit) {
  throw new Error("Initial total supply is incorrect");
}

await (await token.transfer(recipient.address, 25n * unit)).wait();
if ((await token.balanceOf(recipient.address)) !== 25n * unit) {
  throw new Error("Transfer did not update the recipient balance");
}

await (await token.approve(spender.address, 10n * unit)).wait();
if ((await token.getAllowance(deployer.address, spender.address)) !== 10n * unit) {
  throw new Error("Allowance was not stored");
}

await (await token.connect(spender).transferFrom(
  deployer.address,
  recipient.address,
  5n * unit
)).wait();

await (await token.mint(recipient.address, 100)).wait();
await (await token.burn(recipient.address, 25)).wait();

const interfaceCaller = await ethers.deployContract("ERC20InterfaceCall", [tokenAddress]);
await interfaceCaller.waitForDeployment();

await (await token.mint(await interfaceCaller.getAddress(), 20)).wait();
await (await interfaceCaller.sellToken(recipient.address, 7n * unit)).wait();

console.log("MisundersToken:", tokenAddress);
console.log("Name:", await token.name());
console.log("Symbol:", await token.symbol());
console.log("Owner:", await token.owner());
console.log("Total supply:", (await token.totalSupply()) / unit, "MUND");
console.log("Deployer balance:", (await token.balanceOf(deployer.address)) / unit, "MUND");
console.log("Recipient balance:", (await token.balanceOf(recipient.address)) / unit, "MUND");
