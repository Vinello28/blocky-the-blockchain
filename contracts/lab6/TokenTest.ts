import { network } from "hardhat";

const { ethers } = await network.getOrCreate();
const [creatorSigner, recipient] = await ethers.getSigners();

const creator = await ethers.deployContract("TokenCreator");
await creator.waitForDeployment();

const initialName = ethers.encodeBytes32String("TIK");
const changedName = ethers.encodeBytes32String("NEW");

const predictedAddress = await creator.createToken.staticCall(initialName);
const createTx = await creator.createToken(initialName);
await createTx.wait();

const code = await ethers.provider.getCode(predictedAddress);
if (code === "0x") {
  throw new Error("Created TikToken contract was not found at the predicted address");
}

const token = await ethers.getContractAt("TikToken", predictedAddress);

if ((await token.getOwner()) !== (await creator.getAddress())) {
  throw new Error("TikToken owner should be the TokenCreator contract");
}
if ((await token.getName()) !== initialName) {
  throw new Error("TikToken was created with the wrong name");
}

await (await creator.changeTokenName(predictedAddress, changedName)).wait();

if ((await token.getName()) !== changedName) {
  throw new Error("TokenCreator did not update the TikToken name");
}

await (await token.connect(creatorSigner).changeName(initialName)).wait();
if ((await token.getName()) !== changedName) {
  throw new Error("Unauthorized caller changed the TikToken name");
}

const creatorAddress = await creator.getAddress();
let allowedRecipient = "";
let deniedRecipient = "";

for (let i = 0; i < 1000 && (!allowedRecipient || !deniedRecipient); i++) {
  const candidate = ethers.Wallet.createRandom().address;
  const policyHash = ethers.solidityPackedKeccak256(
    ["address", "address"],
    [creatorAddress, candidate]
  );
  if (policyHash.startsWith("0x7f") && !allowedRecipient) {
    allowedRecipient = candidate;
  }
  if (!policyHash.startsWith("0x7f") && !deniedRecipient) {
    deniedRecipient = candidate;
  }
}

if (!allowedRecipient || !deniedRecipient) {
  throw new Error("Could not find addresses covering both transfer policy outcomes");
}

const transferAllowed = await creator.isTokenTransferOK(
  creatorAddress,
  allowedRecipient
);
const transferDenied = await creator.isTokenTransferOK(
  creatorAddress,
  deniedRecipient
);

if (!transferAllowed) {
  throw new Error("Expected-address pair was rejected by the transfer policy");
}
if (transferDenied) {
  throw new Error("Denied-address pair was accepted by the transfer policy");
}

console.log("Created token:", predictedAddress);
console.log("Initial name:", ethers.decodeBytes32String(initialName));
console.log("Changed name:", ethers.decodeBytes32String(changedName));
console.log("Creator:", await creator.getAddress());
console.log("Owner:", await token.getOwner());
console.log("Allowed transfer recipient:", allowedRecipient);
console.log("Allowed by policy:", transferAllowed);
console.log("Denied transfer recipient:", deniedRecipient);
console.log("Denied by policy:", transferDenied);
