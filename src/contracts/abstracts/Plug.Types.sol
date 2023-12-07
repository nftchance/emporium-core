// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.19;

import {ECDSA} from 'solady/src/utils/ECDSA.sol';

/**
 * @title Plug:PlugTypes
 * @notice The base EIP-712 types that power a modern intent framework.
 * @dev This file was auto-generated by @nftchance/plug-types/cli
 *      and should not be edited directly otherwise the alchemy
 *      will fail and you will have to pay with a piece of your soul.
 *      (https://github.com/nftchance/plug-types)
 * @dev This interface and the consuming abstract are auto-generated by
 *      types declared in the framework configuration at (./config.ts).
 *      As an extensible base, all projects build on top of Pins
 *      and Plugs.
 * @author @nftchance
 * @author @nftchance/plug-types (2023-12-07)
 * @author @danfinlay (https://github.com/delegatable/delegatable-sol)
 * @author @KamesGeraghty (https://github.com/kamescg)
 */
library PlugTypesLib {
	/**
	 * @notice This struct is used to encode EIP712Domain data into a hash and
	 *         decode EIP712Domain data from a hash.
	 *
	 * @dev EIP712Domain extends EIP712<{
	 * 		{ name: 'name', type: 'string' }
	 * 		{ name: 'version', type: 'string' }
	 * 		{ name: 'chainId', type: 'uint256' }
	 * 		{ name: 'verifyingContract', type: 'address' }
	 * }>
	 */
	struct EIP712Domain {
		string name;
		string version;
		uint256 chainId;
		address verifyingContract;
	}

	/**
	 * @notice This struct is used to encode Fuse data into a hash and
	 *         decode Fuse data from a hash.
	 *
	 * @dev Fuse extends EIP712<{
	 * 		{ name: 'neutral', type: 'address' }
	 * 		{ name: 'live', type: 'bytes' }
	 * 		{ name: 'forced', type: 'bool' }
	 * }>
	 */
	struct Fuse {
		address neutral;
		bytes live;
		bool forced;
	}

	/**
	 * @notice This struct is used to encode Pin data into a hash and
	 *         decode Pin data from a hash.
	 *
	 * @dev Pin extends EIP712<{
	 * 		{ name: 'neutral', type: 'address' }
	 * 		{ name: 'live', type: 'bytes32' }
	 * 		{ name: 'fuses', type: 'Fuse[]' }
	 * 		{ name: 'salt', type: 'bytes32' }
	 * 		{ name: 'forced', type: 'bool' }
	 * }>
	 */
	struct Pin {
		address neutral;
		bytes32 live;
		Fuse[] fuses;
		bytes32 salt;
		bool forced;
	}

	/**
	 * @notice This struct is used to encode Current data into a hash and
	 *         decode Current data from a hash.
	 *
	 * @dev Current extends EIP712<{
	 * 		{ name: 'ground', type: 'address' }
	 * 		{ name: 'voltage', type: 'uint256' }
	 * 		{ name: 'data', type: 'bytes' }
	 * }>
	 */
	struct Current {
		address ground;
		uint256 voltage;
		bytes data;
	}

	/**
	 * @notice This struct is used to encode LivePin data into a hash and
	 *         decode LivePin data from a hash.
	 *
	 * @dev LivePin extends EIP712<{
	 * 		{ name: 'pin', type: 'Pin' }
	 * 		{ name: 'signature', type: 'bytes' }
	 * }>
	 */
	struct LivePin {
		Pin pin;
		bytes signature;
	}

	/**
	 * @notice This struct is used to encode Plug data into a hash and
	 *         decode Plug data from a hash.
	 *
	 * @dev Plug extends EIP712<{
	 * 		{ name: 'current', type: 'Current' }
	 * 		{ name: 'pins', type: 'LivePin[]' }
	 * 		{ name: 'forced', type: 'bool' }
	 * }>
	 */
	struct Plug {
		Current current;
		LivePin[] pins;
		bool forced;
	}

	/**
	 * @notice This struct is used to encode Breaker data into a hash and
	 *         decode Breaker data from a hash.
	 *
	 * @dev Breaker extends EIP712<{
	 * 		{ name: 'nonce', type: 'uint256' }
	 * 		{ name: 'queue', type: 'uint256' }
	 * }>
	 */
	struct Breaker {
		uint256 nonce;
		uint256 queue;
	}

	/**
	 * @notice This struct is used to encode Plugs data into a hash and
	 *         decode Plugs data from a hash.
	 *
	 * @dev Plugs extends EIP712<{
	 * 		{ name: 'plugs', type: 'Plug[]' }
	 * 		{ name: 'breaker', type: 'Breaker' }
	 * }>
	 */
	struct Plugs {
		Plug[] plugs;
		Breaker breaker;
	}

	/**
	 * @notice This struct is used to encode LivePlugs data into a hash and
	 *         decode LivePlugs data from a hash.
	 *
	 * @dev LivePlugs extends EIP712<{
	 * 		{ name: 'plugs', type: 'Plugs' }
	 * 		{ name: 'signature', type: 'bytes' }
	 * }>
	 */
	struct LivePlugs {
		Plugs plugs;
		bytes signature;
	}
}

/**
 * @title Plug:PlugTypes
 * @dev This file was auto-generated by @nftchance/plug-types/cli.
 *      (https://github.com/nftchance/plug-types)
 * @dev This abstract contract is auto-generated and should not be edited directly
 *      however it should be directly inherited from in the consuming protocol
 *      to power the processing of generalized plugs.
 * @author @nftchance
 * @author @nftchance/plug-types (2023-12-07)
 * @author @danfinlay (https://github.com/delegatable/delegatable-sol)
 * @author @KamesGeraghty (https://github.com/kamescg)
 */
abstract contract PlugTypes {
	/// @notice Use the ECDSA library for signature verification.
	using ECDSA for bytes32;

	/// @notice The hash of the domain separator used in the EIP712 domain hash.
	bytes32 public domainHash;

	/**
	 * @notice Type hash representing the EIP712Domain data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev EIP712_DOMAIN_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'name', type: 'string' }
	 *      { name: 'version', type: 'string' }
	 *      { name: 'chainId', type: 'uint256' }
	 *      { name: 'verifyingContract', type: 'address' }
	 * }>>
	 */
	bytes32 constant EIP712_DOMAIN_TYPEHASH =
		keccak256(
			'EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'
		);

	/**
	 * @notice Type hash representing the Fuse data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev FUSE_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'neutral', type: 'address' }
	 *      { name: 'live', type: 'bytes' }
	 *      { name: 'forced', type: 'bool' }
	 * }>>
	 */
	bytes32 constant FUSE_TYPEHASH =
		keccak256('Fuse(address neutral,bytes live,bool forced)');

	/**
	 * @notice Type hash representing the Pin data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev PIN_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'neutral', type: 'address' }
	 *      { name: 'live', type: 'bytes32' }
	 *      { name: 'fuses', type: 'Fuse[]' }
	 *      { name: 'salt', type: 'bytes32' }
	 *      { name: 'forced', type: 'bool' }
	 * }>>
	 */
	bytes32 constant PIN_TYPEHASH =
		keccak256(
			'Pin(address neutral,bytes32 live,Fuse[] fuses,bytes32 salt,bool forced)Fuse(address neutral,bytes live,bool forced)'
		);

	/**
	 * @notice Type hash representing the Current data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev CURRENT_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'ground', type: 'address' }
	 *      { name: 'voltage', type: 'uint256' }
	 *      { name: 'data', type: 'bytes' }
	 * }>>
	 */
	bytes32 constant CURRENT_TYPEHASH =
		keccak256('Current(address ground,uint256 voltage,bytes data)');

	/**
	 * @notice Type hash representing the LivePin data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev LIVE_PIN_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'pin', type: 'Pin' }
	 *      { name: 'signature', type: 'bytes' }
	 * }>>
	 */
	bytes32 constant LIVE_PIN_TYPEHASH =
		keccak256(
			'LivePin(Pin pin,bytes signature)Fuse(address neutral,bytes live,bool forced)Pin(address neutral,bytes32 live,Fuse[] fuses,bytes32 salt,bool forced)'
		);

	/**
	 * @notice Type hash representing the Plug data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev PLUG_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'current', type: 'Current' }
	 *      { name: 'pins', type: 'LivePin[]' }
	 *      { name: 'forced', type: 'bool' }
	 * }>>
	 */
	bytes32 constant PLUG_TYPEHASH =
		keccak256(
			'Plug(Current current,LivePin[] pins,bool forced)Current(address ground,uint256 voltage,bytes data)Fuse(address neutral,bytes live,bool forced)LivePin(Pin pin,bytes signature)Pin(address neutral,bytes32 live,Fuse[] fuses,bytes32 salt,bool forced)'
		);

	/**
	 * @notice Type hash representing the Breaker data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev BREAKER_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'nonce', type: 'uint256' }
	 *      { name: 'queue', type: 'uint256' }
	 * }>>
	 */
	bytes32 constant BREAKER_TYPEHASH =
		keccak256('Breaker(uint256 nonce,uint256 queue)');

	/**
	 * @notice Type hash representing the Plugs data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev PLUGS_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'plugs', type: 'Plug[]' }
	 *      { name: 'breaker', type: 'Breaker' }
	 * }>>
	 */
	bytes32 constant PLUGS_TYPEHASH =
		keccak256(
			'Plugs(Plug[] plugs,Breaker breaker)Breaker(uint256 nonce,uint256 queue)Current(address ground,uint256 voltage,bytes data)Fuse(address neutral,bytes live,bool forced)LivePin(Pin pin,bytes signature)Pin(address neutral,bytes32 live,Fuse[] fuses,bytes32 salt,bool forced)Plug(Current current,LivePin[] pins,bool forced)'
		);

	/**
	 * @notice Type hash representing the LivePlugs data type providing EIP-712
	 *         compatability for encoding and decoding.
	 * @dev LIVE_PLUGS_TYPEHASH extends TypeHash<EIP712<{
	 *      { name: 'plugs', type: 'Plugs' }
	 *      { name: 'signature', type: 'bytes' }
	 * }>>
	 */
	bytes32 constant LIVE_PLUGS_TYPEHASH =
		keccak256(
			'LivePlugs(Plugs plugs,bytes signature)Breaker(uint256 nonce,uint256 queue)Current(address ground,uint256 voltage,bytes data)Fuse(address neutral,bytes live,bool forced)LivePin(Pin pin,bytes signature)Pin(address neutral,bytes32 live,Fuse[] fuses,bytes32 salt,bool forced)Plug(Current current,LivePin[] pins,bool forced)Plugs(Plug[] plugs,Breaker breaker)'
		);

	/**
	 * @notice Initialize the contract with the name and version of the protocol.
	 * @param $name The name of the protocol.
	 * @param $version The version of the protocol.
	 * @dev The chainId is pulled from the block and the verifying contract is set to the
	 *      address of the contract.
	 */
	function _initializeSocket(
		string memory $name,
		string memory $version
	) internal virtual {
		/// @dev Sets the domain hash for the contract.
		domainHash = getEIP712DomainHash(
			PlugTypesLib.EIP712Domain({
				name: $name,
				version: $version,
				chainId: block.chainid,
				verifyingContract: address(this)
			})
		);
	}

	/**
	 * @notice Encode EIP712Domain data into a packet hash and verify decoded EIP712Domain data
	 *         from a packet hash to verify type compliance.
	 * @param $input The EIP712Domain data to encode.
	 * @return $hash The packet hash of the encoded EIP712Domain data.
	 */
	function getEIP712DomainHash(
		PlugTypesLib.EIP712Domain memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				EIP712_DOMAIN_TYPEHASH,
				keccak256(bytes($input.name)),
				keccak256(bytes($input.version)),
				$input.chainId,
				$input.verifyingContract
			)
		);
	}

	/**
	 * @notice Encode Fuse data into a packet hash and verify decoded Fuse data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Fuse data to encode.
	 * @return $hash The packet hash of the encoded Fuse data.
	 */
	function getFuseHash(
		PlugTypesLib.Fuse memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				FUSE_TYPEHASH,
				$input.neutral,
				keccak256($input.live),
				$input.forced
			)
		);
	}

	/**
	 * @notice Encode Pin data into a packet hash and verify decoded Pin data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Pin data to encode.
	 * @return $hash The packet hash of the encoded Pin data.
	 */
	function getPinHash(
		PlugTypesLib.Pin memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				PIN_TYPEHASH,
				$input.neutral,
				$input.live,
				getFuseArrayHash($input.fuses),
				$input.salt,
				$input.forced
			)
		);
	}

	/**
	 * @notice Encode Fuse[] data into hash and verify the
	 *         decoded Fuse[] data from a packet hash to verify type compliance.
	 * @param $input The Fuse[] data to encode.
	 * @return $hash The packet hash of the encoded Fuse[] data.
	 */
	function getFuseArrayHash(
		PlugTypesLib.Fuse[] memory $input
	) public pure virtual returns (bytes32 $hash) {
		/// @dev Load the stack.
		bytes memory encoded;
		uint256 i;
		uint256 length = $input.length;

		/// @dev Encode each item in the array.
		for (i; i < length; ) {
			encoded = bytes.concat(encoded, getFuseHash($input[i]));

			unchecked {
				i++;
			}
		}

		/// @dev Hash the encoded array.
		$hash = keccak256(encoded);
	}

	/**
	 * @notice Encode Current data into a packet hash and verify decoded Current data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Current data to encode.
	 * @return $hash The packet hash of the encoded Current data.
	 */
	function getCurrentHash(
		PlugTypesLib.Current memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				CURRENT_TYPEHASH,
				$input.ground,
				$input.voltage,
				keccak256($input.data)
			)
		);
	}

	/**
	 * @notice Encode LivePin data into a packet hash and verify decoded LivePin data
	 *         from a packet hash to verify type compliance.
	 * @param $input The LivePin data to encode.
	 * @return $hash The packet hash of the encoded LivePin data.
	 */
	function getLivePinHash(
		PlugTypesLib.LivePin memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				LIVE_PIN_TYPEHASH,
				getPinHash($input.pin),
				keccak256($input.signature)
			)
		);
	}

	/**
	 * @notice Encode Plug data into a packet hash and verify decoded Plug data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Plug data to encode.
	 * @return $hash The packet hash of the encoded Plug data.
	 */
	function getPlugHash(
		PlugTypesLib.Plug memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				PLUG_TYPEHASH,
				getCurrentHash($input.current),
				getLivePinArrayHash($input.pins),
				$input.forced
			)
		);
	}

	/**
	 * @notice Encode LivePin[] data into hash and verify the
	 *         decoded LivePin[] data from a packet hash to verify type compliance.
	 * @param $input The LivePin[] data to encode.
	 * @return $hash The packet hash of the encoded LivePin[] data.
	 */
	function getLivePinArrayHash(
		PlugTypesLib.LivePin[] memory $input
	) public pure virtual returns (bytes32 $hash) {
		/// @dev Load the stack.
		bytes memory encoded;
		uint256 i;
		uint256 length = $input.length;

		/// @dev Encode each item in the array.
		for (i; i < length; ) {
			encoded = bytes.concat(encoded, getLivePinHash($input[i]));

			unchecked {
				i++;
			}
		}

		/// @dev Hash the encoded array.
		$hash = keccak256(encoded);
	}

	/**
	 * @notice Encode Breaker data into a packet hash and verify decoded Breaker data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Breaker data to encode.
	 * @return $hash The packet hash of the encoded Breaker data.
	 */
	function getBreakerHash(
		PlugTypesLib.Breaker memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(BREAKER_TYPEHASH, $input.nonce, $input.queue)
		);
	}

	/**
	 * @notice Encode Plugs data into a packet hash and verify decoded Plugs data
	 *         from a packet hash to verify type compliance.
	 * @param $input The Plugs data to encode.
	 * @return $hash The packet hash of the encoded Plugs data.
	 */
	function getPlugsHash(
		PlugTypesLib.Plugs memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				PLUGS_TYPEHASH,
				getPlugArrayHash($input.plugs),
				getBreakerHash($input.breaker)
			)
		);
	}

	/**
	 * @notice Encode Plug[] data into hash and verify the
	 *         decoded Plug[] data from a packet hash to verify type compliance.
	 * @param $input The Plug[] data to encode.
	 * @return $hash The packet hash of the encoded Plug[] data.
	 */
	function getPlugArrayHash(
		PlugTypesLib.Plug[] memory $input
	) public pure virtual returns (bytes32 $hash) {
		/// @dev Load the stack.
		bytes memory encoded;
		uint256 i;
		uint256 length = $input.length;

		/// @dev Encode each item in the array.
		for (i; i < length; ) {
			encoded = bytes.concat(encoded, getPlugHash($input[i]));

			unchecked {
				i++;
			}
		}

		/// @dev Hash the encoded array.
		$hash = keccak256(encoded);
	}

	/**
	 * @notice Encode LivePlugs data into a packet hash and verify decoded LivePlugs data
	 *         from a packet hash to verify type compliance.
	 * @param $input The LivePlugs data to encode.
	 * @return $hash The packet hash of the encoded LivePlugs data.
	 */
	function getLivePlugsHash(
		PlugTypesLib.LivePlugs memory $input
	) public pure virtual returns (bytes32 $hash) {
		$hash = keccak256(
			abi.encode(
				LIVE_PLUGS_TYPEHASH,
				getPlugsHash($input.plugs),
				keccak256($input.signature)
			)
		);
	}

	/**
	 * @notice Encode Pin data into a digest hash that has been
	 *         localized to the domain of the contract.
	 * @param $input The Pin data to encode.
	 * @return $digest The digest hash of the encoded Pin data.
	 */
	function getPinDigest(
		PlugTypesLib.Pin memory $input
	) public view virtual returns (bytes32 $digest) {
		$digest = keccak256(
			abi.encodePacked('\x19\x01', domainHash, getPinHash($input))
		);
	}

	/**
	 * @notice Encode Plugs data into a digest hash that has been
	 *         localized to the domain of the contract.
	 * @param $input The Plugs data to encode.
	 * @return $digest The digest hash of the encoded Plugs data.
	 */
	function getPlugsDigest(
		PlugTypesLib.Plugs memory $input
	) public view virtual returns (bytes32 $digest) {
		$digest = keccak256(
			abi.encodePacked('\x19\x01', domainHash, getPlugsHash($input))
		);
	}

	/**
	 * @notice Get the signer of a LivePin data type.
	 * @param $input The LivePin data to encode.
	 * @return $signer The signer of the LivePin data.
	 */
	function getLivePinSigner(
		PlugTypesLib.LivePin memory $input
	) public view virtual returns (address $signer) {
		$signer = getPinDigest($input.pin).recover($input.signature);
	}

	/**
	 * @notice Get the signer of a LivePlugs data type.
	 * @param $input The LivePlugs data to encode.
	 * @return $signer The signer of the LivePlugs data.
	 */
	function getLivePlugsSigner(
		PlugTypesLib.LivePlugs memory $input
	) public view virtual returns (address $signer) {
		$signer = getPlugsDigest($input.plugs).recover($input.signature);
	}
}
