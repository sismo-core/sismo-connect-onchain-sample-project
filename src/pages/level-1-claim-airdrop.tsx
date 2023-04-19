import BackButton from "@/components/BackButton";
import {
  SismoConnectButton,
  SismoConnectClientConfig,
  SismoConnectResponse,
  AuthType,
} from "@sismo-core/sismo-connect-react";
import { ethers } from "ethers";
import { useState } from "react";
import { abi as AirdropLevel1ABI } from "../../abi/AirdropLevel1.json";
import { transactions as AirdropLevel1Transactions } from "../../broadcast/AirdropLevel1.s.sol/80001/run-latest.json";
import { devGroups } from "../../groups";

export const sismoConnectConfig: SismoConnectClientConfig = {
  // you can create a new Sismo Connect app at https://factory.sismo.io
  appId: "0xf4977993e52606cfd67b7a1cde717069",
  devMode: {
    // enable or disable dev mode here to create development groups and use the development vault.
    enabled: true,
    devGroups: [devGroups[0]],
  },
};

type UserType = {
  id: string;
};

// setup the provider and signer to interact with the contract deployed on a local fork
const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");
const signer = new ethers.Wallet(
  "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d"
).connect(provider);

export default function Level1ClaimAirdrop() {
  const [verifying, setVerifying] = useState(false);
  const [error, setError] = useState(null);
  const [userInput, setUserInput] = useState("");
  const [verifiedUser, setVerifiedUser] = useState<UserType>(null);

  // On text input change, we update the userInput react state variable
  function onUserInput(e) {
    localStorage.setItem("userInput", e.target.value);
    setUserInput(e.target.value);
  }

  async function verify(responseBytes: string) {
    // first we update the react state to show the loading state
    setVerifying(true);

    // contract address of the AirdropLevel0 contract on the local anvil fork network
    // this contractAddress should be replaced with the correct address if the contract is deployed on a different network
    const contractAddress = AirdropLevel1Transactions.find(
      (tx) => tx.contractName == "AirdropLevel1"
    ).contractAddress as `0x${string}`;
    const instance = new ethers.Contract(contractAddress, AirdropLevel1ABI, signer);

    try {
      console.log("responseBytes", responseBytes);
      // We send the response to the contract to verify the proof
      const txReceipt = await (
        await instance.claimWithSismoConnect(responseBytes, localStorage.getItem("userInput"), {
          gasLimit: 20000000,
        })
      ).wait();

      setUserInput(localStorage.getItem("userInput"));
      localStorage.removeItem("userInput");

      if (!txReceipt.status) {
        const tx = await provider.getTransaction(txReceipt.hash);
        // get error message from revert reason
        const error = await provider.call(tx);
      }

      // the UserId is the 4th topic of the event emitted by the contract
      // it is the tokenId of the NFT minted by the contract
      const userId = txReceipt.logs[0].topics[3];

      // If the proof is valid, we update the user react state to show the user profile
      setVerifiedUser({
        id: userId,
      });
    } catch (e) {
      // else if the proof is invalid, we show an error message
      const code = e.data?.replace("Reverted ", "");
      let reason = ethers.utils.toUtf8String(code ? code : "0x00");
      setError(reason);
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

            <SismoConnectButton
              config={sismoConnectConfig}
              auths={[{ authType: AuthType.VAULT }]}
              claims={[{ groupId: "0x682544d549b8a461d7fe3e589846bb7b" }]}
              // we use the AbiCoder to encode the data we want to sign
              // by encoding it we will be able to decode it on chain
              // TODO: make it not crash if the user type something instead of copy pasting directly
              signature={{
                message: ethers.utils.defaultAbiCoder.encode(
                  ["address"],
                  [!userInput.match(/^0x[a-fA-F0-9]{40}$/) ? signer.address : userInput]
                ),
              }}
              onResponseBytes={(responseBytes: string) => verify(responseBytes)}
              verifying={verifying}
              callbackPath={"/level-1-claim-airdrop"}
            />
            <>{error}</>
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
      </div>
    </>
  );
}
