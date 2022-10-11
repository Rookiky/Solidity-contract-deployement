pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

import  "./PriceConverter.sol";

error notOwner();

contract FundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18; 
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

  

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public payable onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array funders
        funders  = new address[](0);
        //withdraw the funds

        //transfer
        //payable(msg.sender).transfer(address(this).balance);
        //sends
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "send failed");
        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call error");
   }

   modifier onlyOwner{
    //require(msg.sender == i_owner, "don't have the permission");
    if(msg.sender != i_owner) {revert notOwner() ;}
    _;
   }

   receive() external payable {
    fund();
   }

    fallback() external payable {
        fund();
    }
}