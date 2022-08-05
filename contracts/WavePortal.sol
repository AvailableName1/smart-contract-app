// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint private seed;
    address[] whoInteracted;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping (address => uint256) public lastWavedAt;

    constructor() payable {
        console.log('torbik has been here');
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 1 minutes < block.timestamp,
            'wait 1 min please'
        );

        totalWaves += 1;
        whoInteracted.push(msg.sender);
        console.log('%s had waved w/ message is %s', msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log('seed is %d', seed);

        if (seed < 30) {
            uint256 prizeAmount;
            prizeAmount = 0.0001 ether;
            console.log('%s won!', msg.sender);
            require(
            prizeAmount <= address(this).balance, 'failed bc not enough money'
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}('');
            require(success, "Failed to withdraw money from contract");
        }

        lastWavedAt[msg.sender] = block.timestamp;

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waved', totalWaves);
        return totalWaves;
    }

    function getWhoInteracted() public view returns (address[] memory) {
        console.log('We have %d interacted', whoInteracted.length);
        return whoInteracted;
        
    }

    function getAllWaves() public view returns (Wave[] memory) {
        console.log(waves[0].message);
        return waves;
    }
}