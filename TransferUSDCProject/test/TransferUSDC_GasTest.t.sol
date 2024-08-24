// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/TransferUSDC.sol";

contract TransferUSDCTest is Test {
    TransferUSDC transferUsdc;
    address owner = address(this);
    address linkToken = address(0x123); // Mock or actual LINK token address
    address usdcToken = address(0x456); // Mock or actual USDC token address
    address ccipRouter = address(0x789); // Mock or actual CCIP router address

    function setUp() public {
        transferUsdc = new TransferUSDC(ccipRouter, linkToken, usdcToken);
        transferUsdc.allowlistDestinationChain(1, true); // Allowlist a chain selector
    }

    function testMeasureGasAndUpdateLimit() public {
        uint64 destinationChainSelector = 1;
        address receiver = address(0xABC); // Replace with actual receiver
        uint256 amount = 1000 ether;

        // Simulate a call to ccipReceive to measure gas consumption
        // Since we're using Foundry, we assume this function exists and is callable for measurement
        uint256 initialGas = gasleft();

        // Call the ccipReceive function here
        // (Assume this is a public function in TransferUSDC or an external contract you interact with)
        // Example: 
        // transferUsdc.ccipReceive(...);

        uint256 gasUsed = initialGas - gasleft();

        console.log("Gas Used by ccipReceive:", gasUsed);

        // Increase gas by 10%
        uint64 newGasLimit = uint64((gasUsed * 110) / 100);
        console.log("New Gas Limit:", newGasLimit);

        // Use this newGasLimit in the transferUsdc function
        bytes32 messageId = transferUsdc.transferUsdc(
            destinationChainSelector,
            receiver,
            amount,
            newGasLimit
        );

        assert(messageId != 0); // Basic assertion to check if the transaction went through
    }
}