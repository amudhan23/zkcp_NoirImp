// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { HonkVerifier } from "./target/verifier.sol";

contract ZKCP {
    HonkVerifier public verifier;
    address payable public seller;
    address payable public buyer;
    uint256 public price;
    bytes32 public Hk;
    bytes32 public Hfile;
    bool public settled;
    uint256 public expiryTime;
    bytes32[] public publicInputs;

    enum AuctionState { Created, Proved, Payed, Ended }
    AuctionState public state;

    constructor(
        address _verifier,
        address payable _buyer,
        uint256 _price,
        bytes32 _Hk,
        bytes32 _Hfile,
        uint256 _timeoutHours,
        bytes32[] memory _publicInputs
    ) {
        verifier = HonkVerifier(_verifier);
        seller=payable (msg.sender);
        buyer = _buyer;
        price = _price;
        Hk = _Hk;
        Hfile = _Hfile;
        expiryTime = block.timestamp + (_timeoutHours * 1 hours);

        for (uint256 i = 0; i < _publicInputs.length; i++) {
            publicInputs.push(_publicInputs[i]);
        }

        state = AuctionState.Created;
    }

    // Seller submits proof
    function prove(bytes calldata _proof) external {
        require(msg.sender==seller);    
        require(state == AuctionState.Created, "Need proof");
        require(block.timestamp < expiryTime, "Expired");
        
        require(verifier.verify(_proof, publicInputs), "Invalid proof");
        
        state = AuctionState.Proved;
        // seller.transfer(price);
    }

    // Buyer locks payment
    function buy() external payable {
        require(msg.sender==buyer);
        require(state == AuctionState.Proved, "Repayment not possible");
        require(msg.value == price, "Incorrect payment");
        state = AuctionState.Payed;
    }

    function keyReveal(bytes calldata _key) external payable {
        require(msg.sender==seller);
        require(Hk==sha256(_key));
        require(state == AuctionState.Payed);
        state = AuctionState.Ended;
        seller.transfer(price);
    }
    
    // Refund after timeout
    function refund() external {
        require(msg.sender==buyer);
        require(!settled, "Already settled");
        require(block.timestamp >= expiryTime, "Not expired yet");
        
        payable(msg.sender).transfer(address(this).balance);
    }
}
