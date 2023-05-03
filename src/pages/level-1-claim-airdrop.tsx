import BackButton from "@/components/BackButton";
import {
  SismoConnectButton,
  SismoConnectClientConfig,
  SismoConnectResponse,
  AuthType,
} from "@sismo-core/sismo-connect-react";
import { useState } from "react";
import { abi as AirdropLevel1ABI } from "../../abi/AirdropLevel1.json";
import { transactions as AirdropLevel1Transactions } from "../../broadcast/AirdropLevel1.s.sol/80001/run-latest.json";
import { account, devGroups, publicClient, walletClient } from "../../config";
import { encodeAbiParameters, getContract } from "viem";

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
  const [userInput, setUserInput] = useState("");
  const [verifiedUser, setVerifiedUser] = useState<{ id: string }>(null);

  // On text input change, we update the userInput react state variable
  function onUserInput(e) {
    localStorage.setItem("userInput", e.target.value);
    setUserInput(e.target.value);
  }

  async function verify(responseBytes: string) {
    // first we update the react state to show the loading state
    setVerifying(true);
    setUserInput(localStorage.getItem("userInput") ?? account.address);

    // contract address of the AirdropLevel0 contract on the local anvil fork network
    // this contractAddress should be replaced with the correct address if the contract is deployed on a different network
    const contractAddress = AirdropLevel1Transactions.find(
      (tx) => tx.contractName == "AirdropLevel1"
    ).contractAddress as `0x${string}`;
    const contract = getContract({
      address: contractAddress,
      abi: AirdropLevel1ABI,
      walletClient,
      publicClient,
    });

    console.log("responseBytes", responseBytes);
    try {
      // We send the response to the contract to verify the proof
      await contract.simulate.claimWithSismoConnect([
        responseBytes,
        localStorage.getItem("userInput") ?? account.address,
      ]);

      const txHash = await contract.write.claimWithSismoConnect([
        responseBytes,
        localStorage.getItem("userInput") ?? account.address,
      ]);

      localStorage.removeItem("userInput");

      // sleep 2 seconds to wait for the tx to be mined
      // before fetching the tx receipt
      await new Promise((resolve) => setTimeout(resolve, 2000));
      const receipt = await publicClient.getTransactionReceipt({ hash: txHash });

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
    }
  }

  return (
    <>
      <BackButton />
      <div className="container">
        {!verifiedUser && (
          <>
            <h1>Are you a human?</h1>
            <p style={{ marginBottom: 20 }}>
              Level 1: Select on which address to receive the airdrop and sign it with Sismo Connect
              while proving you are a human.
            </p>

            {!error && !verifiedUser && (
              <div className="input-group">
                <label htmlFor="userName">Address where you want to receive the airdrop</label>
                <input
                  id="userName"
                  type="text"
                  value={userInput}
                  onChange={onUserInput}
                  disabled={verifying}
                />
              </div>
            )}

            {!error && (
              <SismoConnectButton
                config={sismoConnectConfig}
                auths={[{ authType: AuthType.VAULT }]}
                claims={[{ groupId: "0x682544d549b8a461d7fe3e589846bb7b" }]}
                // we use the AbiCoder to encode the data we want to sign
                // by encoding it we will be able to decode it on chain
                // TODO: make it not crash if the user type something instead of copy pasting directly
                signature={{
                  message: encodeAbiParameters(
                    [{ type: "address", name: "airdropAddress" }],
                    [
                      !userInput.match(/^0x[a-fA-F0-9]{40}$/)
                        ? account.address
                        : (userInput as `0x${string}`),
                    ]
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
            <p style={{ marginBottom: 20 }}>
              The user has proved that he is a member of the Proof of Humanity group
            </p>
            <div className="profile-container">
              <div>
                <h2>NFT Claimed</h2>
                <b>tokenId: {verifiedUser?.id}</b>
                <p>Address used: {userInput}</p>
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
