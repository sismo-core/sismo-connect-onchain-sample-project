// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {AirdropLevel2} from "../contracts/AirdropLevel2.sol";
import {BaseTest} from "./base/BaseTest.t.sol";

contract AirdropLevel2Test is BaseTest {
  bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;
  bytes16 public constant GROUP_ID = 0x311ece950f9ec55757eb95f3182ae5e2;
  bytes16 public constant GROUP_ID_2 = 0x1cde61966decb8600dfd0749bd371f12;

  AirdropLevel2 public airdropLevel2;

  function setUp() public {
    airdropLevel2 = new AirdropLevel2({name: "My airdropLevel2 contract", symbol: "AIR2", appId: APP_ID, groupId: GROUP_ID, groupId2: GROUP_ID_2});
  }

  function test_AirdropLevel2() public {

    // we register the dev tree root 
    // when we create a proof from an address that is eligible thanks to the devMode configuration
    _registerTreeRoot(0x133fba9f5914e82f4c773aeb3586dd1e6233abad177487ec59e1025be110856f);

    // Data Vault ownership
    // Group membership of Nouns DAO NFT Holders (0x311ece950f9ec55757eb95f3182ae5e2)
    // Group membership of Gitcoin Passport (0x1cde61966decb8600dfd0749bd371f12)
    // signature of address 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    bytes memory response = hex"0000000000000000000000000000000000000000000000000000000000000020f4977993e52606cfd67b7a1cde71706900000000000000000000000000000000b8e2054f8a912367e38a22ce773328ff000000000000000000000000000000007369736d6f2d636f6e6e6563742d76310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000070997970c51812dc3a010c7d01b50e0d17dc79c80000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000a2000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000311ece950f9ec55757eb95f3182ae5e2000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c020d51a0d5a70ec653b74c60211eff379505289b78b8d8aabfd0389d17d49b9261d7bcbf3fb0d8d60f76099f0a8d4b72e74878adea7068139401c315eccc44a57217455a1a5f48d39ba90dcb7a23b565f70c80d44090d4ae97f031638077a2b7e0ff1cfeb0abaa161a5cc48f210322c061fe3b590fe3c2fdc7121fc654757073828e7faf0ed275709946886703d52ae2d11b720176abd067d7baf5b98014bdbe4237d0965abe8ecf7f01407e20c1cd3b12f0cf07ca66a762506d24e84beee939e0dfe20a0480de11d76bc28db9a470a5b1a9c4dc9cb863787c6b527d41bc000ef2ee0e402b4f3f24b2029fa30357dc38cd77b02dd77d50d6cfb2cdbb5e843ecdd00000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db74133fba9f5914e82f4c773aeb3586dd1e6233abad177487ec59e1025be110856f0412d59e4b26962c96a5a709070aef8fdb3e7b784b93377cc2827b70353c321a1ea593fb85a7c4d7c661935aff576dca99bb0663c48a9668ae8f8e23377cad7a000000000000000000000000000000000000000000000000000000000000000100ba80222e6d252d9f9b503c96a98d85442d8c1cf9ba8f6ebc1e0a6c0fffffff000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000001cde61966decb8600dfd0749bd371f12000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c02116bb546de06273345a16ae9ccda25e8ebaab49367a135e6385c36b02ffd5e50535b78d8b1f53d9f648b5e7028cecd57ec717620bda19364487d8d820a1934f2d2abc32541188e610a14e92aa8d15ab6a6a0d47512520c084e405833e5373681809414b4c52d7777f97f49a3afdd8d330d2d7b2d66b86d3bc668acbb1bbe7452dbfc6d360c81d417cd3b1fb5798cc01c4838d4b71bc68ad50a1e32acad9d80029c4ce9d3e52cdc6f00af09c8e58a8b9d9827f7f81da63bd1c40fa33b785508628e494f6b2989cfebc02722a0d04bf86414a7d32f56c23d16b6521e3f3a42df7125ac16de5bbb9ea92107dc61645fae510f14423c7fdb0315097d2f9585c9a9600000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db74133fba9f5914e82f4c773aeb3586dd1e6233abad177487ec59e1025be110856f29397141311df07a81a9b47e43a9bf186517f7e8f9e0a0d7dbd0fb0c9a14087b1ba2707c08b5b2a6771169dd8a521a74efacfb2d891d9d0076e11a7eab0d771c00000000000000000000000000000000000000000000000000000000000000011cde61966decb8600dfd0749bd371f126c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000001a068796472612d73322e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000004a00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e00000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c00ec1ede5e6879c388de6940f5d9d48ee1ece905de32906d459b8365431f9088101795c11cdf4bbcb96b84acaf1bdca0df018861d21846e867e02db7d9ef3812628a77ca5922bf1a255ab20b40089a63996e68f18f65d7159a71bc575dacfc5d9206d382f31f4e45e54b71daee492825bd39f39287d07500a3811fd0ce7a6921b0c3ac8254130f7e621418f5c30a08bf56f9432222f4d352a59a429e9596543a42565542e95b709a5f0f2bb3dbeadc2e8574771a936deaec0778c9b40c10710251a6cf584064fde98c64026df40fcfffd9ecde3f7fc178f5c953c4e73499079242124232a8f0345b8371c08178623b23f4622638e92ac8ab436f3969c8fa62f1100000000000000000000000000000000000000000000000000000000000000001c22bb924d4df7679181b00cc5891585ff0b9efac15f0f66d5d498ea4804fb712ab71fb864979b71106135acfa84afc1d756cda74f8f258896f896b4864f025630423b4c502f1cd4179a425723bf1e15c843733af2ecdee9aef6a0451ef2db7400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001b42aaebc220a0702a5ee7e7ccf1a58f85a7b0bfc7e9ebe6de3fc5ab562a23e02c02b0c8903e5f139b466d5bc5ceda4a647c4c72486e6d61de22fc3805abdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    vm.prank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
    airdropLevel2.claimWithSismoConnect(response);
  }
}
