// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {AirdropLevel2} from "../contracts/AirdropLevel2.sol";
import {BaseTest} from "./base/BaseTest.t.sol";

contract AirdropLevel2Test is BaseTest {
  bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;
  bytes16 public constant GROUP_ID = 0x682544d549b8a461d7fe3e589846bb7b;
  bytes16 public constant GROUP_ID_2 = 0x1cde61966decb8600dfd0749bd371f12;

  AirdropLevel2 public airdropLevel2;

  function setUp() public {
    airdropLevel2 = new AirdropLevel2({name: "My airdropLevel2 contract", symbol: "AIR2", appId: APP_ID, groupId: GROUP_ID, groupId2: GROUP_ID_2});
  }

  function test_AirdropLevel2() public {

    // we register the dev tree root 
    // when we create a proof from an address that is eligible thanks to the devMode configuration
    _registerTreeRoot(0x1F992252E80BE8EA6BBDCF26461FA109ABCDBFB7360659557D53C34146E301A6);

    // Data Vault ownership
    // Group membership of Proof of Humanity (0x682544d549b8a461d7fe3e589846bb7b)
    // Group membership of Gitcoin Passport (0x1cde61966decb8600dfd0749bd371f12)
    // signature of address 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    bytes memory response = hex"0000000000000000000000000000000000000000000000000000000000000020f4977993e52606cfd67b7a1cde71706900000000000000000000000000000000b8e2054f8a912367e38a22ce773328ff000000000000000000000000000000007369736d6f2d636f6e6e6563742d76310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000070997970c51812dc3a010c7d01b50e0d17dc79c80000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000a2000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000682544d549b8a461d7fe3e589846bb7b000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c02897e3a0dc85ee5298979dd8168c7b0bb8d4026305ded2bf4a4b164954c3b5130e816fa572d7a7aba8356a1795ed6c0d8320dcc031b112b79bfa023707fd62e11dfa929991613125c02f5f2868bfad1204e958a49d7458ad48a4c2020576abd02d450f60b01a6afc78b8789922bffac7007cdba80b612f999359ff5ed783f49d19daa3dfc913b2e369a56699caea4cb19a2dbff21534a0e9d02fd3e6d1e2f06423f120cd8c3c188c8bef3445d6a5a8f32d512a9493bee220b828dda59f7c23f12ab924cbd48e00a1e0f0a0fe1b20d1109af6194cb8cb45803eea953a938f69642077502d41b6e3617d789a3e936c0290f10e0dae4ba761b8b89759f97cecfc3b00000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db741f992252e80be8ea6bbdcf26461fa109abcdbfb7360659557d53c34146e301a62595cec01ee5ca3c0353064de37babd3d2bb85ecdff9879b955a3a3221f647cc0f5b6e14789dee71c9d280807776990eb5fafb86dc5578b78e9f53a8c5e7fd670000000000000000000000000000000000000000000000000000000000000001075ca7ef8755640e675db2eb95440ac11bf9a3d480011edd783c14d81ffffffe000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000001cde61966decb8600dfd0749bd371f12000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c02e9198b3410acc8dd86f9f2dfc41321a3d13a5331382f16cc43edffcd6b9b2fd2b0e56813dc037fcc72e89b13912a55d5a94dfa054e7fbea0640fc4e1b2a44c01896bd60f73f092ff11820e0c1a467deadd89e88a8fece0ab29ab2081d0598130a415f6782d799830a8f66b7b23fb9e7211478945f2fc2d8af16aec73846425516e205c5cd43501b26b01cdb75f055af3b8ce36a24d1fc123097c15001fd86b41fc59b0d06f1f3009729d1ea98c705870031358e22984f9420818d5f5eea11232486199bc1b6e71c82a98949ef5e9e61c3d675d06aade60b7fd0b43561f3736e2e9868b46616c36e22708278b64d3d9736e4b2277d156c3a02cbd5f0ef5b160c00000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db741f992252e80be8ea6bbdcf26461fa109abcdbfb7360659557d53c34146e301a629397141311df07a81a9b47e43a9bf186517f7e8f9e0a0d7dbd0fb0c9a14087b1ba2707c08b5b2a6771169dd8a521a74efacfb2d891d9d0076e11a7eab0d771c00000000000000000000000000000000000000000000000000000000000000011cde61966decb8600dfd0749bd371f126c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000001a068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000004a00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e00000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0089e2a8f59ad52bd3f7afc57e42bf0922499b546095f340631b8f93d3f530e1714474527563fc5642b331eb344f0ee5cae732f4a25cebd79b5d1ead146ff25882ab64a6a7ff70bc3beaf0a8c523b2ff6b037977b1d330f57b7c039a3b47ce2fd14926d8ff588f339c071e33cd81aa6be4b674014b666c4b6af3381be2b852f830b9e7c366d63e120beed73d54646c057e608e944d7ca2ea63d1eea0aa5ccd3330fc9e0afad9b8a23266363640ed0321a12956a2177197fcb3500864020280c41212c5a0b7f990a697431290153ede4ef81efdcf5cc5dcd323ebd1812cbdced550757615c9b2e030b0033a4bbb981b38f9ac5dfafc7589bec2082221e0ecb54d500000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db7400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    airdropLevel2.claimWithSismoConnect(response, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
  }
}
