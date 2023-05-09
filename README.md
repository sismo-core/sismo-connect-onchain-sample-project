# Sismo Connect - Onchain Sample Project Repository

This repository aims at providing simple examples on how to integrate Sismo Connect onchain while allowing you to test the integration locally as easily as possible.

## Usage

### Prerequisites

- [Node.js](https://nodejs.org/en/download/) >= 18.15.0 (Latest LTS version)
- [Yarn](https://classic.yarnpkg.com/en/docs/install)
- [Foundry](https://book.getfoundry.sh/)

### Install dependencies

```bash
# install frontend / backend dependencies
yarn

# install contract dependencies with Forge
forge install
```

### Launch your local fork by forking Mumbai with Anvil

```bash
# start a local blockchain with mumbai fork
yarn anvil
# this triggers this anvil command behind the scene
# `anvil --fork-url https://rpc.ankr.com/polygon_mumbai`
```

### Start your local Next.js app

```bash
# this will start your Next.js app
# the frontend is available on http://localhost:3001/
# it also starts a local backend
# and deploys the contracts on the local blockchain
yarn dev
```

The frontend is now available on http://localhost:3001/ and the contracts have been deployed on your local blockchain.
You can now experiment the user flow by going to your local frontend http://localhost:3001/.

As you will see, the app showcase simple examples on how to create gated airdrops with Sismo Connect.
To be eligible for the airdrops, you just need to add your address in [`./config.ts`](./config.ts):

```ts
// Replace with your address to become eligible for the airdrops
export const yourAddress = "0x855193BCbdbD346B423FF830b507CBf90ecCc90B"; // <--- Replace with your address

...
```

ℹ️ You will be able to mint each airdrop only once with the same eligible address. If you wish to test the airdrop flow multiple times, you will need to change your eligible address or deploy again the contracts with the following command:

```bash
# this will deploy the contracts again on your local blockchain
yarn deploy-local
```

### Run contract tests

sismoConnectVerifier contracts are currently deployed on Goerli and Mumbai.
You can find the deployed addresses [here](https://docs.sismo.io/sismo-docs/technical-documentation/sismo-101).
You can then run tests on a local fork network to test your contracts.

```bash
## Run fork tests with goerli
forge test --fork-url https://rpc.ankr.com/eth_goerli

## Run fork tests with mumbai
forge test --fork-url https://rpc.ankr.com/polygon_mumbai

# you can aslo use the rpc url you want by passing an environment variable
forge test --fork-url $RPC_URL
```
