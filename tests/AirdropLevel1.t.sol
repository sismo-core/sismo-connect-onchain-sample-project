// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {AirdropLevel1} from "../contracts/AirdropLevel1.sol";
import {BaseTest} from "./base/BaseTest.t.sol";

contract AirdropLevel1Test is BaseTest {
  bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;
  bytes16 public constant GROUP_ID = 0x682544d549b8a461d7fe3e589846bb7b;

  AirdropLevel1 public airdropLevel1;

  function setUp() public {
    airdropLevel1 = new AirdropLevel1({name: "My airdropLevel1 contract", symbol: "AIR1", appId: APP_ID, groupId: GROUP_ID});
  }

  function test_AirdropLevel0() public {

    // we register the dev tree root 
    // when we create a proof from an address that is eligible thanks to the devMode configuration
    _registerTreeRoot(0x2a524a21315a641da25b81ff5ee9526e89d1281c380740cf3f1252dbbff08437);

    // Data Vault ownership
    // Group membership of Proof of Humanity (0x682544d549b8a461d7fe3e589846bb7b)
    // signature of address 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    bytes memory response = hex"0000000000000000000000000000000000000000000000000000000000000020f4977993e52606cfd67b7a1cde71706900000000000000000000000000000000b8e2054f8a912367e38a22ce773328ff000000000000000000000000000000007369736d6f2d636f6e6e6563742d76310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000070997970c51812dc3a010c7d01b50e0d17dc79c800000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000052000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000682544d549b8a461d7fe3e589846bb7b000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c02d50214650481c33b21d915744a8a5e4c89afd9cfa9d02eb6baaea4fa1b03162266b2cccf0d6ae3f82ec292cefcddb5b56977b33667499704fca7a7a21810a4d18bb841f277b95d3e8c1ee4d730faedc7c211809300df052b7d4fd4f518686eb1263ad9c26c6b7a7c7632928fe647b2c0bc0e3a40d646b0496e977f6b3277cc61c43a2281d203c90055320a8032b42428dd1bb41c95486106f9a38f799f9c3300fd17df4c0d757eccd9daa76d5d94caa623446878f847d70b4731981a33111f614c9814c8a6fe6f50f5807fcda29c03bc40c551c509ea4361d824866cb5a794b115509bfc4e7982840ab398e1ad6eaa0bfe365afe6ba7e378a4c01df64a1579100000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db742a524a21315a641da25b81ff5ee9526e89d1281c380740cf3f1252dbbff084372595cec01ee5ca3c0353064de37babd3d2bb85ecdff9879b955a3a3221f647cc0f5b6e14789dee71c9d280807776990eb5fafb86dc5578b78e9f53a8c5e7fd670000000000000000000000000000000000000000000000000000000000000001075ca7ef8755640e675db2eb95440ac11bf9a3d480011edd783c14d81ffffffe000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000001a068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000004a00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e00000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c02b26adb8f50c089cd6f0d697c673afdace52220eb5dbb6302c948a4b5b984adf02c57486dd6e5f6e7e60ca164eb166bfcd4779f44789e72b4f329d07c330109b1cba8f0d8873bd85d60de9fcea2052972eca2bbcc8d3358629435723a6178ef301864fa12d3231f829d8babaafffb6940b08ef16b50f3d717824b6c0728a14e83052e28c0a44c3a70e5ded28c49ada47d3cb7819ab695271d8849d8ba1d5b7ba2fffab5911704675d46a524353df3f210a2f94aa294f10a33cc4b4de1d81df8e2a5f2d6540d86acf040927bed1622aa23f21fc0013198acdec0f656efc9175290bcd1300db73d706188dfc1024674c6bffcf22031e69cb8ed68cbb39d85220bf00000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db7400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    airdropLevel1.claimWithSismoConnect(response, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
  }
}