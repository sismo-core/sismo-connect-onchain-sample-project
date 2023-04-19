// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {AirdropLevel0} from "contracts/AirdropLevel0.sol";

contract DeployAirdropLevel0 is Script {
    bytes16 public constant APP_ID = 0xf4977993e52606cfd67b7a1cde717069;

    function run() public {
        vm.startBroadcast();
        AirdropLevel0 airdropLevel0 = new AirdropLevel0({name: "My airdropLevel0 contract", symbol: "AIR0", appId: APP_ID});
        console.log("AirdropLevel0 Contract deployed at", address(airdropLevel0));
        vm.stopBroadcast();
    }
}