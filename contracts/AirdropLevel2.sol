// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import SismoConnect Solidity library
import "sismo-connect-solidity/SismoLib.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title ZKDropERC721
 * @author Sismo
 * @notice ZkDropERC721 is a contract that allows users to privately claim and transfer ERC721 tokens using SismoConnect.
 */
contract AirdropLevel2 is
    ERC721,
    SismoConnect // the contract inherits from SismoConnect
{
    using SismoConnectHelper for SismoConnectVerifiedResult;
    // specify the groupIds from which users should be members of to claim the token
    bytes16 public immutable GROUP_ID;
    bytes16 public immutable GROUP_ID_2;

    error RegularERC721TransferFromAreNotAllowed();
    error RegularERC721SafeTransferFromAreNotAllowed();

    constructor(
        string memory name,
        string memory symbol,
        bytes16 appId, // the appId of your sismoConnect app (you need to register your sismoConnect app on https://factory.sismo.io)
        bytes16 groupId, // the groupId from which users should be members of to claim the token
        bytes16 groupId2 // the groupId from which users should optionally be members of to claim the token
    ) ERC721(name, symbol) SismoConnect(appId) {
        GROUP_ID = groupId;
        GROUP_ID_2 = groupId2;
    }

    /**
     * @notice Claim a ERC721 on the address `to` thanks to a sismoConnect response containing a valid proof
     *         with respect to the auth,claims and message signature requests
     * @param response the sismoConnect response from the Data Vault app in bytes
     * @param to the address to mint the token to
     */
    function claimWithSismoConnect(bytes memory response, address to) public returns (uint256) {
        ClaimRequest[] memory claims = new ClaimRequest[](2);
        claims[0] = ClaimRequestBuilder.build({groupId: GROUP_ID});
        claims[1] = ClaimRequestBuilder.build({groupId: GROUP_ID_2, isOptional: true});


        AuthRequest[] memory auths = new AuthRequest[](1);
        auths[0] = AuthRequestBuilder.build({authType: AuthType.VAULT});

        SismoConnectRequest memory request = RequestBuilder.buildRequest({
          claims: claims,
          auths: auths,
          signature: buildSignature({message: abi.encode(to)}),
          appId: appId
        });
        
        // the verify function will check that the sismoConnectResponse proof is cryptographically valid
        // with respect to the auth, claims and message signature requests
        // i.e it checks that the user is the owner of a Sismo Data Vault
        // and that the user is a member of the groupId specified in the claim request
        // and that the message signature is valid  
        SismoConnectVerifiedResult memory result = verify({
          responseBytes: response,
          request: request
        });

        // if the proof is valid, we mint the token to the address `to`
        // the tokenId is the anonymized userId of the user that claimed the token
        // if the user calls the claimWithSismoConnect function multiple times
        // he will only be able to claim one token
        uint256 tokenId = result.getUserId(AuthType.VAULT);
        _mint(to, tokenId);

        return tokenId;
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        revert RegularERC721TransferFromAreNotAllowed();
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        revert RegularERC721SafeTransferFromAreNotAllowed();
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data)
        public
        virtual
        override
    {
        revert RegularERC721SafeTransferFromAreNotAllowed();
    }
}