// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SuperMarioGame is ERC20, Ownable {

    uint public constant InitialLives = 3;
    mapping(address => uint) private playerLives;
     constructor() 
     ERC20("SuperMarioGame", "SMG") 
     Ownable(msg.sender) {
        _mint(msg.sender, InitialLives);
        playerLives[msg.sender] = InitialLives;
    }

    function mintPowerup(address account, uint amount) public onlyOwner {
        _mint(account, amount);
    }

    function acquirePowerup(uint amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough powerups");
        _burn(msg.sender, amount);
    }

    function playerHit() public {
        require(playerLives[msg.sender] > 0, "No lives left");
        playerLives[msg.sender]--;
    }

    function getPlayerLives(address player) public view returns (uint) {
        return playerLives[player];
    }
}
