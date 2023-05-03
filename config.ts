import { Chain, createPublicClient, createWalletClient, http } from "viem";
import { privateKeyToAccount } from "viem/accounts";

///////////////////

// Replace with your address to become eligible for the airdrops
export const yourAddress = "0x855193BCbdbD346B423FF830b507CBf90ecCc90B"; // <--- Replace with your address

///////////////////

export const devGroups = [
  {
    // Proof of Humanity group : https://factory.sismo.io/groups-explorer?search=0x682544d549b8a461d7fe3e589846bb7b
    groupId: "0x682544d549b8a461d7fe3e589846bb7b",
    data: [
      // your address is added here so you can test the airdrops
      yourAddress,
      "0x2b9b9846d7298e0272c61669a54f0e602aba6290",
      "0xb01ee322c4f028b8a6bfcd2a5d48107dc5bc99ec",
      "0x938f169352008d35e065F153be53b3D3C07Bcd90",
    ],
  },
  {
    // Gitcoin Passport group : https://factory.sismo.io/groups-explorer?search=0x1cde61966decb8600dfd0749bd371f12
    groupId: "0x1cde61966decb8600dfd0749bd371f12",
    data: [
      // your address is added here so you can test the airdrops
      yourAddress,
      "0x2b9b9846d7298e0272c61669a54f0e602aba6290",
      "0xb01ee322c4f028b8a6bfcd2a5d48107dc5bc99ec",
      "0x938f169352008d35e065F153be53b3D3C07Bcd90",
    ],
  },
];

// The chain configuration of the chain you want to fork
// You don't need to change this
export const mumbaiFork = {
  id: 80_001,
  name: "Fork Mumbai",
  network: "mumbai",
  nativeCurrency: { name: "MATIC", symbol: "MATIC", decimals: 18 },
  rpcUrls: {
    default: {
      http: ["http://localhost:8545"],
    },
    public: {
      http: ["http://localhost:8545"],
    },
  },
  testnet: true,
} as const satisfies Chain;

// The private key of the second account of the local anvil network
// This account is used for this demo to allow the user to try it without connecting a wallet
export const account = privateKeyToAccount(
  "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d"
);

// setup the public and wallet client to interact with the contract deployed on a local fork
// the public client is used to read data from the contract or the chain
// the wallet client is used to send transactions to the contract
export const publicClient = createPublicClient({
  chain: mumbaiFork,
  transport: http("http://localhost:8545"),
});

export const walletClient = createWalletClient({
  account,
  chain: mumbaiFork,
  transport: http("http://localhost:8545"),
});
