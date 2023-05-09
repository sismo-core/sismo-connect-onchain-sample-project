import { exec } from "child_process";
import { useRouter } from "next/router";
import { useEffect } from "react";

export default function Home() {
  const router = useRouter();

  return (
    <div className="container">
      <h1>
        Sample Project
        <br />
        Sismo Connect Onchain
      </h1>
      <section>
        <ul>
          <li onClick={() => router.push("/level-0-claim-airdrop")}>
            <h3>Claim an airdrop anonymously</h3>
            <p>Sign an address with Sismo Connect where you wish to receive the airdrop</p>
          </li>
          <li onClick={() => router.push("/level-1-claim-airdrop")}>
            <h3>Claim a gated airdrop anonymously</h3>
            <p>
              Sign an address with Sismo Connect where you wish to receive the airdrop while proving
              that you own a Nouns DAO NFT
            </p>
          </li>
          <li onClick={() => router.push("/level-2-claim-airdrop")}>
            <h3>
              Claim a gated airdrop anonymously <br />
              while proving that you are human
            </h3>
            <p>
              Sign an address with Sismo Connect where you wish to receive the airdrop while proving
              that you own a Nouns DAO NFT and a Gitcoin Passport
            </p>
          </li>
        </ul>
      </section>
    </div>
  );
}
