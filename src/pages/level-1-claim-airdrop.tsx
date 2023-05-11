import BackButton from "@/components/BackButton";
import {
  SismoConnectButton,
  SismoConnectClientConfig,
  SismoConnectResponse,
  AuthType,
} from "@sismo-core/sismo-connect-react";
import { useEffect, useState } from "react";
import { abi as AirdropLevel1ABI } from "../../abi/AirdropLevel1.json";
import { transactions as AirdropLevel1Transactions } from "../../broadcast/AirdropLevel1.s.sol/5151110/run-latest.json";
import { devGroups, mumbaiFork, publicClient } from "../../config";
import {
  WalletClient,
  createWalletClient,
  custom,
  encodeAbiParameters,
  getContract,
  http,
  parseEther,
} from "viem";
import { privateKeyToAccount } from "viem/accounts";

export const sismoConnectConfig: SismoConnectClientConfig = {
  // you can create a new Sismo Connect app at https://factory.sismo.io
  appId: "0xf4977993e52606cfd67b7a1cde717069",
  devMode: {
    // enable or disable dev mode here to create development groups and use the development vault.
    enabled: true,
    devGroups: [devGroups[0]],
  },
};

export default function Level1ClaimAirdrop() {
  const [verifying, setVerifying] = useState(false);
  const [error, setError] = useState(null);
  const [verifiedUser, setVerifiedUser] = useState<{ id: string }>(null);
  const [account, setAccount] = useState<`0x${string}`>(null);
  const [walletClient, setWalletClient] = useState<WalletClient | undefined>();
  const [isAirdropAddressKnown, setIsAirdropAddressKnown] = useState<boolean>(false);

  useEffect(() => {
    if (typeof window === "undefined") return;
    setWalletClient(
      createWalletClient({
        chain: mumbaiFork,
        transport: custom(window.ethereum, {
          key: "windowProvider",
        }),
      }) as WalletClient
    );

    setIsAirdropAddressKnown(localStorage.getItem("airdropAddress") ? true : false);
    if (isAirdropAddressKnown) {
      setAccount(localStorage.getItem("airdropAddress") as `0x${string}`);
    }
  }, [isAirdropAddressKnown]);

  async function connectWallet(): Promise<`0x${string}`> {
    await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    const permissions = await window.ethereum.request({
      method: "wallet_requestPermissions",
      params: [
        {
          eth_accounts: {},
        },
      ],
    });
    const address = permissions[0].caveats[0].value[0];
    localStorage.setItem("airdropAddress", address);
    setAccount(address);
    setIsAirdropAddressKnown(true);

    // Create a wallet client with a publicly known private key
    const client = createWalletClient({
      chain: mumbaiFork,
      transport: http("http://127.0.0.1:8545"),
    });

    // third private key of anvil accounts
    const anvilAccount = privateKeyToAccount(
      "0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a"
    );

    // send 1 token to the connected user on the local fork
    const tx = await client.sendTransaction({
      account: anvilAccount as any as never,
      to: address as any as never,
      value: parseEther("5") as any as never,
      chain: mumbaiFork as any as never,
    });

    return address;
  }

  const switchNetwork = async () => {
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: `0x${mumbaiFork.id.toString(16)}` }],
      });
    } catch (error) {
      // This error code means that the chain we want has not been added to MetaMask
      // In this case we ask the user to add it to their MetaMask
      if (error.code === 4902) {
        try {
          // add mumbai fork chain to metamask
          await window.ethereum.request({
            method: "wallet_addEthereumChain",
            params: [
              {
                chainId: `0x${mumbaiFork.id.toString(16)}`,
                chainName: mumbaiFork.name,
                rpcUrls: mumbaiFork.rpcUrls.default.http,
                nativeCurrency: {
                  name: mumbaiFork.nativeCurrency.name,
                  symbol: mumbaiFork.nativeCurrency.symbol,
                  decimals: mumbaiFork.nativeCurrency.decimals,
                },
              },
            ],
          });
        } catch (error) {
          console.log(error);
        }
      } else {
        console.log(error);
      }
    }
  };

  async function verify(responseBytes: string) {
    // first we update the react state to show the loading state
    setVerifying(true);

    // we switch the network to the mumbai fork
    await switchNetwork();

    console.log("responseBytes", responseBytes);

    // contract address of the AirdropLevel1 contract on the local anvil fork network
    // this contractAddress should be replaced with the correct address if the contract is deployed on a different network
    const contractAddress = AirdropLevel1Transactions.find(
      (tx) => tx.contractName == "AirdropLevel1"
    ).contractAddress as `0x${string}`;

    const contract = getContract({
      address: contractAddress as any as never,
      abi: AirdropLevel1ABI as any as never,
      publicClient,
      walletClient,
    });
    console.log("responseBytes", responseBytes);
    try {
      const txArgs = {
        address: contractAddress as any as never,
        abi: AirdropLevel1ABI as any as never,
        functionName: "claimWithSismoConnect" as any as never,
        args: [responseBytes, account] as any as never,
        account: account as any as never,
        chain: mumbaiFork as any as never,
        value: 0 as any as never,
      };
      // We simulate the call to the contract to get the error if the tx is invalid
      await publicClient.simulateContract(txArgs);

      // If the simulation is successful, we call the contract
      const txHash = await walletClient.writeContract(txArgs);

      // sleep 2 seconds to wait for the tx to be mined on the fork
      // before fetching the tx receipt
      await new Promise((resolve) => setTimeout(resolve, 2000));
      const receipt = await publicClient.waitForTransactionReceipt({ hash: txHash });

      // the UserId is the 4th topic of the event emitted by the contract
      // it is the tokenId of the NFT minted by the contract
      const userId = (receipt as { logs: { topics: string[] }[] }).logs[0].topics[3];

      // If the proof is valid, we update the user react state to show the user profile
      setVerifiedUser({
        id: userId,
      });
    } catch (e) {
      // else if the tx is invalid, we show an error message
      // it is either because the proof is invalid or because the user already claimed the airdrop
      console.log("error", { ...e });
      console.log("e.shortMessage", e.shortMessage);
      e.shortMessage ===
      'The contract function "claimWithSismoConnect" reverted with the following reason:\nERC721: token already minted'
        ? setError("Airdrop already claimed!")
        : setError(e.shortMessage);
      localStorage.removeItem("userInput");
    } finally {
      // We set the loading state to false to show the user profile
      setVerifying(false);
      localStorage.removeItem("airdropAddress");
    }
  }

  return (
    <>
      <BackButton />
      <div className="container">
        {!verifiedUser && (
          <>
            <h1>Claim a gated airdrop anonymously</h1>
            {!isAirdropAddressKnown && (
              <p style={{ marginBottom: 20 }}>
                Select on which address to receive the airdrop and sign it with Sismo Connect while
                proving you own a Nouns DAO NFT.
              </p>
            )}

            {isAirdropAddressKnown ? (
              <p style={{ marginBottom: 40 }}>You are connected with the address {account}</p>
            ) : (
              !error && (
                <button className="connect-wallet-button" onClick={() => connectWallet()}>
                  Connect Wallet
                </button>
              )
            )}

            {!error && isAirdropAddressKnown && (
              <SismoConnectButton
                config={sismoConnectConfig}
                auths={[{ authType: AuthType.VAULT }]}
                claims={[{ groupId: devGroups[0].groupId }]} // Nouns DAO NFT Holders group
                // we use the AbiCoder to encode the data we want to sign
                // by encoding it we will be able to decode it on chain
                // TODO: make it not crash if the user type something instead of copy pasting directly
                signature={{
                  message: encodeAbiParameters(
                    [{ type: "address", name: "airdropAddress" }],
                    [(account as `0x${string}`) ?? "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"]
                  ),
                }}
                onResponseBytes={(responseBytes: string) => verify(responseBytes)}
                verifying={verifying}
                callbackPath={"/level-1-claim-airdrop"}
              />
            )}
          </>
        )}

        {verifiedUser && (
          <>
            <h1>Airdrop claimed!</h1>
            <p style={{ marginBottom: 20 }}>The user has proved that he owns a Nouns DAO NFT</p>
            <div className="profile-container">
              <div>
                <h2>NFT Claimed</h2>
                <b>tokenId: {verifiedUser?.id}</b>
                <p>Address used: {account}</p>
              </div>
            </div>
          </>
        )}

        {error && (
          <>
            <h2>{error}</h2>
            <p>
              You can try again with another address or deploy again the contracts to restart (see
              README)
            </p>
          </>
        )}
      </div>
    </>
  );
}
