// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Auction is Ownable
{

    mapping(address => uint) biddersData;
    address[] addressBidders;  // guardar o endereço dos bidders pra devolver os lances em um loop
    address highestBidder;
    address auctioneer;
    uint highestBidAmount; //use biddersData[highestBidder] and save gas
    uint minIncrease;
    uint startTime;
    uint endTime;
    bool aucClosed;
    bool retrieveProfit;
    // address nftCollectionAddress = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    // AuctionWinnerNFT NFT = AuctionWinnerNFT(nftCollectionAddress); // change initialization to constructor? this way we could sent different NFTs

    constructor (uint _durationSeconds, address _auctioneer, uint _minIncrease, uint _highestBidAmount) {
        auctioneer = _auctioneer;
        startTime = block.timestamp;
        endTime = startTime + _durationSeconds;
        minIncrease = _minIncrease;
        highestBidAmount = _highestBidAmount;
    }

    function finished() external view returns (bool) {
        if (block.timestamp > endTime)
            return (false);
        else
            return (true);
    }

    function getMinIncrease() external view returns(uint) {
        return (minIncrease);
    }

    function isClosed() external view returns(bool) {
        return (aucClosed);
    }

    function storeBidderAddress(address bidder) public view returns(bool) //in case we don't accept bids after the withdraw, we can check directly in the mapping if the value is zero
    {
        for (uint256 i = 0; i < addressBidders.length; i++) {
            if(addressBidders[i] == bidder)
                return false;
        }
        return true;
     }

    //put new bid
    function putBid(uint _newAmount, address bidder) public //change to external an see what oders can be external https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices
    {
        biddersData[bidder] = _newAmount;
        highestBidAmount = _newAmount;
        highestBidder = bidder;
        if(storeBidderAddress(bidder)) // guardar os endereços pra devolver lance pros perdedores
            addressBidders.push(bidder);
    }

    function resetAmount (address bidderAddress) external onlyOwner {
        biddersData[bidderAddress] = 0;
    }


    //get Bidders Balance
    function getBiddersBalance(address _address) public view returns (uint){
        return biddersData[_address];
    }

    //get Highest BidAmount
    function getHighestBid() public view returns(uint){
        return highestBidAmount;
    }

    //get Highest Bidder Address
    function getHighestBidder() public view returns(address){
        return highestBidder;
    }

    //get Auctioneer Address
    function getAuctioneer() public view returns(address){
        return auctioneer;
    }

    function getBidderAddressCount() public view returns(uint256) {
        return addressBidders.length;
    }

    function getBidderAddressAmount(uint256 index) public view returns(address payable, uint) {
        return (payable(addressBidders[index]), biddersData[addressBidders[index]]);
    }

    //withdraw bid
    // function withdrawBid(address _address) public onlyOwner returns(uint) {
    //     uint _biddedAmount; //prevent reentrancy attacks, is it necessary when using transfer?

    //     require(_address != highestBidder, "Auction winner, can't withdraw."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables
    //     require(biddersData[_address] > 0, "Current balance is 0. Nothing to withdraw."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables
    //     _biddedAmount = biddersData[_address];
    //     biddersData[_address] = 0; //prevent reentrancy attacks, is it necessary when using transfer?
    //     // _address.transfer(_biddedAmount);
    //     return (_biddedAmount);
    // }

    function closeAuction() external onlyOwner {
        aucClosed = true;
        // if(highestBidder != 0x0000000000000000000000000000000000000000)
        //     sendAuctionWinnerNFT();
    }

    function calcAuctioneerEarnings() public view returns(uint){
        uint earnings;

        earnings = (highestBidAmount * 95) / 100; // use SafeMath to prevent from overflows and other possible errors
        return (earnings); //use variable directly instead of function call
    }


    // function sendAuctionWinnerNFT() private { //add functionality to auction an previously owned NFT
    //    NFT.mint(payable(getHighestBidder())); //use variable directly instead of function call
    // }

    //implement onlyOwner function to change nftCollectionAddress

    //implement functionality to receive an NFT and auction it instead of creating one at the end of the auction (or send both?)

    // function withdraw() public onlyOwner {
    //     uint profit;

    //     require(!retrieveProfit, "AuctionHouse profit already retrieved."); //use error/revert instead
    //     retrieveProfit = true; //remove variable, declare int variable for profit and check if it is 0 as condition, using less variables - need to use error/reverse
    //     profit = highestBidAmount - ((highestBidAmount * 95) / 100);
    //     address _owner = owner();
    //     (bool sent, ) =  _owner.call{value: profit}("");
    //     require(sent, "Failed to send Ether");
    // }

    // function setNewNFTCollection (address newCollection) public onlyOwner {
    //     nftCollectionAddress = newCollection;
    // }
}


//the person who is auctioning the procudt will need to spent an initial quantitiy of ETH to create the auction (deploy the contract)
//function to return the funds of a given account
//in the front end the person will have the chance to ask for the refund once she/he doesn't have the highest bid anymore
//the options will be 'giveup' or 'increase bid', in the case of increase bid the person only needs to send the extra amount to overbid the current highest bidder
//protect the giveup function (withdrawBid) against reentrancy attacks
//is if less cost than require/error/revert? probably yes, require/error/revert probably use if conditions
//check if transfer succeeded, trhrow error otherwise
//create auction house contract, create function to send auction profit to "auction house" contract
//dcheck size of ints and uints declared
//nothing newest than 0.8.19 in the zeniq smartchain !!