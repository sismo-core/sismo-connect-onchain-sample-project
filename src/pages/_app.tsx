import "@/styles/globals.css";
import { getDefaultProvider } from "ethers";
import type { AppProps } from "next/app";
import { mumbaiFork } from "../../config";

export default function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <img
        style={{ position: "absolute", right: 0, zIndex: -1 }}
        src="/assets/sismo-landing-art.svg"
        alt="sismo art"
      />
      <Component {...pageProps} />
    </>
  );
}
