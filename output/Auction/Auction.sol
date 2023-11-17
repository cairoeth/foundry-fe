// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IAuction {
    event AuctionAlreadyEnded();
    event AuctionEndAlreadyCalled();
    event AuctionEnded(address indexed winner, uint256 amount);
    event AuctionNotYetEnded();
    event BidNotHighEnough(uint256 highest_bid);
    event Context();
    event HighestBidIncreased(address indexed bidder, uint256 amount);

    function auction_end() external payable;
    function bid() external payable;
    function check_ended() external view returns (bool);
    function check_highest_bid() external view returns (uint256);
    function check_highest_bidder() external view returns (address);
    function get_beneficiary() external view returns (address);
    function withdraw() external payable returns (bool);
}
