import fetch from 'node-fetch';
require('dotenv').config();
const { CONTRACT_NAME } = process.env;
const { task } = require("hardhat/config");
const { getContract } = require("./helpers");

task("mint", "Mints from the contract")
    .setAction(async function (taskArguments, hre) {
        const contract = await getContract(CONTRACT_NAME, hre);
        const transactionResponse = await contract.mint({
            gasLimit: 500_000,
        });
        console.log(`Transaction Hash: ${transactionResponse.hash}`);
    });