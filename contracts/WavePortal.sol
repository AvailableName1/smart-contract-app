// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] whoInteracted;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() {
        console.log('torbik has been here');
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        whoInteracted.push(msg.sender);
        console.log('%s had waved w/ message is %s', msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

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