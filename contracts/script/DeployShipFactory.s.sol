// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ShipFactory} from "../src/ShipFactory.sol";
import {console} from "forge-std/console.sol";

contract DeployShipFactory is Script {
    // Network Configuration
    struct NetworkConfig {
        string name;
        address router;
        uint64 chainSelector;
    }

    mapping(uint256 => NetworkConfig) public getNetworkConfig;

    constructor() {
        // Ethereum Testnet
        getNetworkConfig[11155111] = NetworkConfig({
            name: "Sepolia",
            router: 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59,
            chainSelector: 16015286601757825753
        });

        // Arbitrum Testnet
        getNetworkConfig[421614] = NetworkConfig({
            name: "Arbitrum Sepolia",
            router: 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165,
            chainSelector: 3478487238524512106
        });

        // Optimism Sepolia Testnet
        getNetworkConfig[11155420] = NetworkConfig({
            name: "Optimism Sepolia",
            router: 0x114A20A10b43D4115e5aeef7345a1A71d2a60C57,
            chainSelector: 2664363617261496610
        });

        // Polygon Testnet
        getNetworkConfig[80002] = NetworkConfig({
            name: "Polygon Amoy",
            router: 0x9C32fCB86BF0f4a1A8921a9Fe46de3198bb884B2,
            chainSelector: 16281711391670634445
        });

        // Avalanche Testnet
        getNetworkConfig[43113] = NetworkConfig({
            name: "Fuji",
            router: 0xF694E193200268f9a4868e4Aa017A0118C9a8177,
            chainSelector: 14767482510784806043
        });

        // Base Testnet
        getNetworkConfig[84532] = NetworkConfig({
            name: "Base Sepolia",
            router: 0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93,
            chainSelector: 5790810961207155433
        });

    }

    function run() external {
        // Get current chain ID
        uint256 chainId = block.chainid;
        
        // Get network config
        NetworkConfig memory config = getNetworkConfig[chainId];
        require(config.router != address(0), "Network not supported");

        // Log pre-deployment info
        console.log("\n=== Pre-Deployment Info ===");
        console.log("Network:", config.name);
        console.log("Chain ID:", chainId);
        console.log("Chain Selector:", config.chainSelector);
        console.log("Router Address:", config.router);
        
        // Start broadcasting transactions
        vm.startBroadcast();
        
        // Deploy ShipFactory
        ShipFactory shipFactory = new ShipFactory(config.router);
        
        // Stop broadcasting
        vm.stopBroadcast();
        
        // Log deployment results
        console.log("\n=== Deployment Results ===");
        console.log("ShipFactory Address:", address(shipFactory));
        
        console.log("\n=== Capacity Fees ===");
        console.log("Capacity 1:", shipFactory.getCapacityFee(1));
        console.log("Capacity 2:", shipFactory.getCapacityFee(2));
        console.log("Capacity 5:", shipFactory.getCapacityFee(5));
        console.log("Capacity 10:", shipFactory.getCapacityFee(10));
        console.log("Token Creation Fee:", shipFactory.TOKEN_CREATION_FEE());
    }
}

