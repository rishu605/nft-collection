// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract Iteractions is Script {
    function run() external {
        address mostRecentlyDepoyed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTOnContract(mostRecentlyDepoyed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        // BasicNFT(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}