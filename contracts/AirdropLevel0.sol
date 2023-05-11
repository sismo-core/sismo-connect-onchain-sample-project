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
contract AirdropLevel0 is
    ERC721,
    SismoConnect // the contract inherits from SismoConnect
{
    using SismoConnectHelper for SismoConnectVerifiedResult;

    error RegularERC721TransferFromAreNotAllowed();
    error RegularERC721SafeTransferFromAreNotAllowed();

    constructor(
        string memory name,
        string memory symbol,
        bytes16 appId // the appId of your sismoConnect app (you need to register your sismoConnect app on https://factory.sismo.io)
    ) ERC721(name, symbol) SismoConnect(appId) {}

    /**
     * @notice Claim a ERC721 on the address `to` thanks to a sismoConnect response containing a valid proof
     *         with respect to the auth and message signature requests
     * @param response the sismoConnect response from the Data Vault app in bytes
     */
    function claimWithSismoConnect(bytes memory response) public returns (uint256) {
        // the verify function will check that the sismoConnectResponse proof is cryptographically valid
        // with respect to the auth and message signature requests
        // i.e it checks that the user is the owner of a Sismo Data Vault
        // and that the message signature is valid
        SismoConnectVerifiedResult memory result = verify({
            responseBytes: response,
            auth: buildAuth({authType: AuthType.VAULT}),
            signature: buildSignature({message: abi.encode(msg.sender)})
        });

        // if the proof is valid, we mint the token to the address `to`
        // the tokenId is the anonymized userId of the user that claimed the token
        // if the user calls the claimWithSismoConnect function multiple times
        // he will only be able to claim one token
        uint256 tokenId = result.getUserId(AuthType.VAULT);
        _mint(msg.sender, tokenId);

        return tokenId;
    }

    function transferFrom(address, address, uint256) public virtual override {
        revert RegularERC721TransferFromAreNotAllowed();
    }

    function safeTransferFrom(address, address, uint256) public virtual override {
        revert RegularERC721SafeTransferFromAreNotAllowed();
    }

    function safeTransferFrom(address, address, uint256, bytes memory)
        public
        virtual
        override
    {
        revert RegularERC721SafeTransferFromAreNotAllowed();
    }
}