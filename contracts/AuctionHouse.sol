// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "./Auction.sol";

contract AuctionHouse is Ownable
{
    Auction[] public    auctions;
    uint                profit;

    modifier onlyFinished(uint aucIndex) {
        Auction auction = Auction(auctions[aucIndex]);
        require(!auction.finished(), "The auction hasn't finished yet."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables, probably yes https://ethereum.stackexchange.com/questions/123381/when-should-i-use-require-vs-custom-revert-errors
        _;
    }

    modifier onGoing(uint aucIndex) {
        Auction auction = Auction(auctions[aucIndex]);
        require(auction.finished(), "The auction has finished."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables, probably yes https://ethereum.stackexchange.com/questions/123381/when-should-i-use-require-vs-custom-revert-errors
        _;
    }

    modifier openAuction(uint aucIndex) {
        Auction auction = Auction(auctions[aucIndex]);
        require(!auction.isClosed(), "The auction is closed."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables, probably yes https://ethereum.stackexchange.com/questions/123381/when-should-i-use-require-vs-custom-revert-errors
        _;
    }

    function createNewAuction(uint durationTime, uint startPrice, uint _minIncrease) public returns(uint) {
        require(startPrice > _minIncrease, "Start price must be greater than increase");
        Auction auction = new Auction(durationTime, msg.sender, _minIncrease, startPrice - _minIncrease);
        auctions.push(auction);
        return (auctions.length - 1);
    }

    function getLastAuctionIndex() public view returns(uint) {
        return (auctions.length - 1);
    }

    function bid(uint aucIndex) public payable onGoing(aucIndex) { //check if require can go to function in Actio.sol and if revert will revert this call and not receive the ether
        require(msg.value > 0, "Bid amount must be greater than zero."); //use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables, probably yes https://ethereum.stackexchange.com/questions/123381/when-should-i-use-require-vs-custom-revert-errors
        Auction auction = Auction(auctions[aucIndex]);
        uint newAmount = auction.getBiddersBalance(msg.sender) + msg.value;
        require(newAmount >= auction.getHighestBid() + auction.getMinIncrease() , "New bid amount must be greater than current bid"); // implement minimum increment /use error/revert instead ? https://ethereum.stackexchange.com/questions/123342/returning-error-message-with-variables, probably yes https://ethereum.stackexchange.com/questions/123381/when-should-i-use-require-vs-custom-revert-errors
        auction.putBid(newAmount, msg.sender);
    }

    function takeAuctionHouseProfit(uint percentage) public onlyOwner {
        uint amount;
        amount = (profit * percentage) / 100;
        profit = profit - amount;
        payable(msg.sender).transfer(amount);
    }

    function returnLoserBids (uint aucIndex) public onlyOwner {
        Auction auction = Auction(auctions[aucIndex]);
        uint lenght = auction.getBidderAddressCount();
        for(uint i = 0; i < lenght; i++)
        {
            address payable bidderAddress;
            uint    biddedAmount;
            (bidderAddress, biddedAmount) = auction.getBidderAddressAmount(i);
            if(bidderAddress != auction.getHighestBidder()) { //check if a get function is really necessary // ACRESCENTAR VERIFICAÇÃO PRA NAO FAZER TRANSACAO A TOA ---> && biddedAmount
                auction.resetAmount(bidderAddress);
                bidderAddress.transfer(biddedAmount);
            }
        }
    }

    function withdrawBid (uint aucIndex) public openAuction(aucIndex) {
        Auction auction = Auction(auctions[aucIndex]);
        require(msg.sender != auction.getHighestBidder(), "Current winner. Can't withdraw.");
        uint    biddedAmount;
        biddedAmount = auction.getBiddersBalance(msg.sender);
        require(biddedAmount != 0, "Current amount bidded in the auction is 0.");
        auction.resetAmount(msg.sender);
        (payable(msg.sender)).transfer(biddedAmount);
    }

    function tradeAuction(uint aucIndex) public onlyOwner onlyFinished(aucIndex) openAuction(aucIndex) {
        Auction auction = Auction(auctions[aucIndex]);
        auction.closeAuction();
        payable(auction.getAuctioneer()).transfer(auction.calcAuctioneerEarnings());
        profit = profit + (auction.getHighestBid() - auction.calcAuctioneerEarnings());
        returnLoserBids(aucIndex);
    }

    //get contract Balance
    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }

    function getProfitBalance() public view returns (uint){
        return profit;
    }

    function _getBiddersBalance(uint _aucIndex) public view returns (uint){
        Auction auction = Auction(auctions[_aucIndex]);
        return auction.getBiddersBalance(msg.sender);
    }

    function _getMinIncrease(uint _aucIndex) public view returns (uint){
        Auction auction = Auction(auctions[_aucIndex]);
        return auction.getMinIncrease();
    }

    //get Highest BidAmount
    function _getHighestBid(uint _aucIndex) public view returns(uint){
        Auction auction = Auction(auctions[_aucIndex]);
        return auction.getHighestBid();
    }

    //get Highest Bidder Address
    function _getHighestBidder(uint _aucIndex) public view returns(address){
        Auction auction = Auction(auctions[_aucIndex]);
        return auction.getHighestBidder();
    }

    //get Auctioneer Address
    function _getAuctioneer(uint _aucIndex) public view returns(address){
        Auction auction = Auction(auctions[_aucIndex]);
        return auction.getAuctioneer();
    }

}