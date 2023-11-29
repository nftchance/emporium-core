// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.19;

library NounsBidSocketHelpers {
	error InsufficientBalance();
	error InsufficientBid();
	error InsufficientReason();
	error InsufficientSettlement();
	error InsufficientOwnership();

	event Given(address indexed sender, uint256 value);
	event Used(
		address indexed sender,
		address indexed onBehalf,
		uint256 value,
		uint256 nounId
	);
	event Taken(
		address indexed sender,
		address indexed onBehalf,
		uint256 nounId
	);
}
