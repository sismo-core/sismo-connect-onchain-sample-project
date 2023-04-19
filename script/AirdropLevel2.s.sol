// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {AirdropLevel2} from "contracts/AirdropLevel2.sol";

contract DeployAirdropLevel2 is Script {
    bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;
    bytes16 public constant GROUP_ID = 0x682544d549b8a461d7fe3e589846bb7b;
    bytes16 public constant GROUP_ID_2 = 0x1cde61966decb8600dfd0749bd371f12;

    function run() public {
        vm.startBroadcast();
        AirdropLevel2 airdropLevel2 = new AirdropLevel2({name: "My airdropLevel2 contract", symbol: "AIR2", appId: APP_ID, groupId: GROUP_ID, groupId2: GROUP_ID_2});
        console.log("AirdropLevel2 Contract deployed at", address(airdropLevel2));
        vm.stopBroadcast();
    }
}