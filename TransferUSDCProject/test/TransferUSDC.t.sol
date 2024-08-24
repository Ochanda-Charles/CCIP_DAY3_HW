// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/TransferUSDC.sol";

contract TransferUSDCTest is Test {
    TransferUSDC transferUsdc;
    address owner = address(this);
    address linkToken = address(0x123); // Replace with actual LINK token address
    address usdcToken = address(0x456); // Replace with actual USDC token address
    address ccipRouter = address(0x789); // Replace with actual CCIP router address

    function setUp() public {
        transferUsdc = new TransferUSDC(ccipRouter, linkToken, usdcToken);
        transferUsdc.allowlistDestinationChain(1, true); // Example chain selector
    }

    function testTransferUsdc() public {
        uint64 destinationChainSelector = 1;
        address receiver = address(0xABC); // Replace with actual receiver
        uint256 amount = 1000 ether;

        uint64 gasLimit = 500000; // Initial gas limit

        bytes32 messageId = transferUsdc.transferUsdc(
            destinationChainSelector,
            receiver,
            amount,
            gasLimit
        );

        assert(messageId != 0); // Basic assertion to check if the transaction went through
    }
}
