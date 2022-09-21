require('dotenv').config();
const { CONTRACT_NAME } = process.env;
const { task } = require("hardhat/config");
const { getAccount } = require("./helpers");

task("check-balance", "Prints out the balance of your account").setAction(async function (taskArguments, hre) {
    const account = getAccount();
    console.log(`Account balance for ${account.address}: ${await account.getBalance()}`);
});

task("deploy", "Deploys the contract").setAction(async function (taskArguments, hre) {
    const contract = await hre.ethers.getContractFactory(CONTRACT_NAME, getAccount());
    const deployedContract = await contract.deploy();
    console.log(`Contract deployed to address: ${deployedContract.address}`);
});