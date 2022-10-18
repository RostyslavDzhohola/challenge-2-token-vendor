pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    payable(msg.sender).transfer(address(this).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 amount) public {
    uint256 amountOfEth = amount / tokensPerEth;
    require(address(this).balance >= amountOfEth, "Not enough ETH in the reserve");
    yourToken.transferFrom(msg.sender, address(this), amount);
    payable(msg.sender).transfer(amountOfEth);
  }
}
