// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Fundme{

    address public owner;

    address[] public funders;

    constructor() public{

        owner = msg.sender;

    }

    mapping(address => uint256) public addressToAmount;

    function fund() public payable{

        uint256 minUSD = 50 * (10 ** 18);
        require(getConversionRate(msg.value) >= minUSD, "Trasaction Value should be greater than $50");
        addressToAmount[msg.sender] += msg.value;
        funders.push(msg.sender);
        
    }

    function getPrice() public view returns(uint256){
        
        AggregatorV3Interface currPrice = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = currPrice.latestRoundData();
    
    return uint256(answer) * (10 ** 10);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){

        uint256 ethPrice = getPrice();
        uint256 ethInUSD = (ethPrice * ethAmount) / 10 ** 18;
        return ethInUSD;
        // 0xF79aaaedb22e191a3B77B88dc7aD82e33b876Db0
    }

    modifier Owner {
        require(msg.sender == owner, "You can only withdraw funds that yourself have funded!");
        _;
    }

    function withdraw() Owner payable public{

        
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 fundersIndex=0; fundersIndex<funders.length; fundersIndex++){
            address funder = funders[fundersIndex];
            addressToAmount[funder] = 0;
        }
        funders = new address[](0);

    }
    
}
