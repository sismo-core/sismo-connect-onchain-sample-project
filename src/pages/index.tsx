import { useRouter } from "next/router";

export default function Home() {
  const router = useRouter();

  return (
    <div className="container">
      <h1>
        Getting Started
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
            <h3>Claim an airdrop gated to Humans (PoH)</h3>
            <p>
              Sign an address with Sismo Connect where you wish to receive the airdrop while proving
              that you have a Proof of Humanity profile
            </p>
          </li>
          <li onClick={() => router.push("/level-2-claim-airdrop")}>
            <h3>Claim an airdrop gated to Humans</h3>
            <h3>(PoH or Gitcoin)</h3>
            <p>
              Sign an address with Sismo Connect where you wish to receive the airdrop while proving
              that you have a Proof of Humanity profile and optionally a Gitcoin Passport
            </p>
          </li>
        </ul>
      </section>
    </div>
  );
}
