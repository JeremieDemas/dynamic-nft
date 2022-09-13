# NFT-collection-template

Creation of a template for setting up an NFT collection.

## Getting Started

1. Install all modules and their dependencies.

```
npm install
```

2. Create the "contracts" folder into the root folder and write your contract into it.

3. Create a new ".env" file into the root folder of the project.

```
ALCHEMY_KEY = "alchemy-api-key"
ACCOUNT_PRIVATE_KEY = "wallet-private-key"
NETWORK = "blockchain-network"
CONTRACT_NAME = "your-contract-name"
```

4. Compile your contract.
```
npx hardhat compile
```

5. Deploy your contract.
```
npx hardhat deploy
```

6. Add the contract address into the ".env" file.
```
CONTRACT_ADDRESS = "contract-address"
```

7. Mint from your contract.
```
npx hardhat mint
```