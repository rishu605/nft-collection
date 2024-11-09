// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {

    BasicNFT public basicNFT;
    DeployBasicNFT public deployer;
    address public user = address(0x123);

    function setUp() public {
        // Deploy the BasicNFT contract using the DeployBasicNFT contract
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    // Test if the contract deploys correctly
    function testDeployment() public {
        assertEq(address(basicNFT) != address(0), true, "BasicNFT contract should be deployed");
        assertEq(basicNFT.name(), "Dogie", "NFT name should be 'Dogie'");
        assertEq(basicNFT.symbol(), "DOG", "NFT symbol should be 'DOG'");
    }

    // Test minting a new NFT
    function testMintNFT() public {
        string memory tokenUri = "https://myapi.com/metadata/1";
        
        // Mint the NFT
        vm.prank(user); // Simulate user as the sender
        basicNFT.mintNft(tokenUri);

        // Check that the token counter has increased to 1
        // assertEq(basicNFT.totalSupply(), 1, "Token counter should be 1 after minting");

        // Verify that the token owner is the user
        assertEq(basicNFT.ownerOf(0), user, "The owner of the token should be the user");

        // Check that the token URI is stored correctly
        assertEq(basicNFT.tokenURI(0), tokenUri, "The token URI should match the minted URI");
    }

    // Test minting multiple NFTs
    function testMintMultipleNFTs() public {
        string memory tokenUri1 = "https://myapi.com/metadata/1";
        string memory tokenUri2 = "https://myapi.com/metadata/2";
        
        // Mint the first NFT
        vm.prank(user);
        basicNFT.mintNft(tokenUri1);
        
        // Mint the second NFT
        vm.prank(user);
        basicNFT.mintNft(tokenUri2);
        
        // Check the total supply
        // assertEq(basicNFT.totalSupply(), 2, "Total supply should be 2 after minting 2 NFTs");

        // Check that the token URIs are correct for each token
        assertEq(basicNFT.tokenURI(0), tokenUri1, "The token URI for token ID 0 should match the first URI");
        assertEq(basicNFT.tokenURI(1), tokenUri2, "The token URI for token ID 1 should match the second URI");

        // Check that the owners of the tokens are correct
        assertEq(basicNFT.ownerOf(0), user, "Owner of token 0 should be the user");
        assertEq(basicNFT.ownerOf(1), user, "Owner of token 1 should be the user");
    }

    // Test only allowing the correct address to mint NFTs
    // function testMintingAccessControl() public {
    //     string memory tokenUri = "https://myapi.com/metadata/1";

    //     // Trying to mint from a non-owner address should fail
    //     vm.expectRevert("Ownable: caller is not the owner");
    //     basicNFT.mintNft(tokenUri); // Non-owner calling minting function should fail
    // }

    // Test tokenURI function for valid retrieval
    function testTokenURI() public {
        string memory tokenUri = "https://myapi.com/metadata/1";

        // Mint an NFT
        vm.prank(user);
        basicNFT.mintNft(tokenUri);

        // Check if the token URI is correctly returned
        assertEq(basicNFT.tokenURI(0), tokenUri, "The token URI should be the same as the mint URI");
    }

    // Test that the counter increments correctly on minting
    function testTokenCounterIncrements() public {
        string memory tokenUri1 = "https://myapi.com/metadata/1";
        string memory tokenUri2 = "https://myapi.com/metadata/2";
        
        // Mint first NFT
        vm.prank(user);
        basicNFT.mintNft(tokenUri1);
        
        // Mint second NFT
        vm.prank(user);
        basicNFT.mintNft(tokenUri2);
        
        // Check that token IDs are incremented correctly
        assertEq(basicNFT.ownerOf(0), user, "Owner of token 0 should be the user");
        assertEq(basicNFT.ownerOf(1), user, "Owner of token 1 should be the user");
    }
}