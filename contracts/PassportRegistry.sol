// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {IPAssetRegistry} from "./story-protocol/core/registries/IPAssetRegistry.sol";
import {RegistrationWorkflows} from "./story-protocol/periphery/workflows/RegistrationWorkflows.sol";
import {ISPGNFT} from "./story-protocol/periphery/interfaces/ISPGNFT.sol";

import {IPPassport} from "./IPPassport.sol";

/// @notice Register an NFT as an IP Account.
contract PassportRegistry {
    IPAssetRegistry public immutable IP_ASSET_REGISTRY;
    RegistrationWorkflows public immutable REGISTRATION_WORKFLOWS;
    IPPassport public immutable SIMPLE_NFT;
    ISPGNFT public immutable SPG_NFT;

    constructor(address ipAssetRegistry, address registrationWorkflows) {
        IP_ASSET_REGISTRY = IPAssetRegistry(ipAssetRegistry);
        REGISTRATION_WORKFLOWS = RegistrationWorkflows(registrationWorkflows);
        SIMPLE_NFT = new IPPassport("Game Plus Passport", "GPP");
        SPG_NFT = ISPGNFT(
            REGISTRATION_WORKFLOWS.createCollection(
                ISPGNFT.InitParams({
                    name: "Game Plus Passport Collection",
                    symbol: "GPP",
                    baseURI: "https://gameplus.com/demo/passport/metadata/",
                    contractURI: "https://gameplus.com/demo/passport/contracts/",
                    maxSupply: 100,
                    mintFee: 0,
                    mintFeeToken: address(0),
                    mintFeeRecipient: address(this),
                    owner: address(this),
                    mintOpen: true,
                    isPublicMinting: false
                })
            )
        );
    }

    /// @notice Mint an IP NFT and register it as an IP Account via Story Protocol core.
    /// @return ipId The address of the IP Account.
    /// @return tokenId The token ID of the IP NFT.
    function mintIp() external returns (address ipId, uint256 tokenId) {
        tokenId = SIMPLE_NFT.mint(msg.sender);
        ipId = IP_ASSET_REGISTRY.register(
            block.chainid,
            address(SIMPLE_NFT),
            tokenId
        );
    }
}
