// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {AirdropLevel1} from "contracts/AirdropLevel1.sol";

contract DeployAirdropLevel1 is Script {
    bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;
    bytes16 public constant GROUP_ID = 0x311ece950f9ec55757eb95f3182ae5e2;

    function run() public {
        vm.startBroadcast();
        AirdropLevel1 airdropLevel1 = new AirdropLevel1({name: "My airdropLevel1 contract", symbol: "AIR1", appId: APP_ID, groupId: GROUP_ID});
        console.log("AirdropLevel1 Contract deployed at", address(airdropLevel1));
        vm.stopBroadcast();
    }
}