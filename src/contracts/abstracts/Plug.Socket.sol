// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.23;

import { PlugSocketInterface } from "../interfaces/Plug.Socket.Interface.sol";
import { PlugSimulation } from "./Plug.Simulation.sol";
import { PlugTypesLib } from "./Plug.Types.sol";

/**
 * @title Plug
 * @notice The core contract for the Plug framework that enables
 *         counterfactual revokable pin of extremely
 *         granular pin and execution paths.
 * @author @nftchance (chance@utc24.io)
 * @author @danfinlay (https://github.com/delegatable/delegatable-sol)
 * @author @KamesGeraghty (https://github.com/kamescg)
 */
contract PlugSocket is PlugSocketInterface, PlugSimulation {
    /**
     * See {IPlug-plug}.
     */
    function plug(PlugTypesLib.LivePlugs calldata $livePlugs)
        external
        payable
        returns (bytes[] memory $results)
    {
        /// @dev Determine who signed the intent.
        address intentSigner = getLivePlugsSigner($livePlugs);

        /// @dev Prevent random people from plugging.
        _enforceSigner(intentSigner);

        /// @dev Invoke the plugs.
        $results = _plug($livePlugs, intentSigner);
    }

    // TODO: Finish the implementation of this.
    /**
     * See {IPlug-plugContract}.
     */
    // function plugContract(PlugTypesLib.Plug[] calldata $plugs)
    //     external
    //     payable
    //     returns (bytes[] memory $result)
    // {
    //     /// @dev Prevent random contracts from plugging.
    //     _enforceSigner(msg.sender);
    //
    //     $result = _plug($plugs, msg.sender);
    // }

    /**
     * @notice Confirm that signer of the intent has permission to declare
     *         the execution of an intent.
     * @dev If you would like to limit the available signers override this
     *      function in your contract with the additional logic.
     */
    function _enforceSigner(address $signer) internal view virtual { }
}
