// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

contract FundMe{
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    AggregatorV3Interface priceFeed;

    constructor() {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(0x62CAe0FA2da220f43a51F86Db2EDb36DcA9A5A08);
    }


    function fund() public payable {
        uint256 minimumUsd = 10 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUsd, "Please use atleast 10$ worth of eth to fund the contract");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getConversionRate(uint256 amount) public view returns (uint256) {
        uint256 ethPrice = getLatestPrice();
        uint256 ethAmountInUsd = (ethPrice * amount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner of this smart contract cannot withdraw from it");
        _;
    }

    function withdraw() payable onlyOwner public {
        payable(msg.sender).transfer(address(this).balance);

        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }

    function getVersion() public view returns (uint256) {
        // make sure the contract address is correct or you will keep sratching your heads on what is going wrong.
        return priceFeed.version();
    }

     /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (uint256) {
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 10000000000);
    }
}

contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            ,
            /*uint80 roundID*/ int price /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/,
            ,
            ,

        ) = priceFeed.latestRoundData();
        return price;
    }
}
