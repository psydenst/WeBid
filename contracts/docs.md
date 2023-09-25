# Avaiable functions

- [createNewAuction](docs.md#createNewAuction)
- [bid](docs.md#bid)
- [tradeAuction](docs.md#tardeAuction)
- [withdrawBid](docs.md#withdrawBid)

## Functions

### createNewAuction

▸ **createNewAuction**(uint `durationTime`, uint `startPrice`, uint `_minIncrease`): returns (uint)

A function that creates a new acution setting its duration time in seconds (`durationTime`), its start price and minimum increase in wei (`startPrice`, `minIncrease`).
The function returns a uint that identify the auction index within the `AuctionHouse.sol` contract.


### bid

▸ **bid**(uint `aucIndex`) public payable onGoing(aucIndex)
A function to put a new bit into an on going acution. It receives an uint  that identify the auction index within the `AuctionHouse.sol` contract.


### tradeAuction

▸ **tradeAuction**(uint `aucIndex`) public onlyOwner onlyFinished(aucIndex) openAuction(aucIndex)
A function to make the necessary transactions once the Auction is closed (i.e. the time od the auction ended).
It will return any loser bids still in the contract to its bidders wallets; transfer 95% of the winning bid to the auctioneer; and the NFT to the winning bidder.
It receives an uint  that identify the auction index within the `AuctionHouse.sol` contract.

### withdrawBid

▸ **withdrawBid**(uint `aucIndex`) public openAuction(aucIndex)
A function to return any loser bids upon call while the auction is still on going.
It receives an uint  that identify the auction index within the `AuctionHouse.sol` contract.
