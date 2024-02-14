// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import{Fallback} from "../src/Fallback.sol";
import{Script} from "forge-std/Script.sol";

contract DeployFallback is Script {

    Fallback fallbackContract;

    address public fallbackOwner = makeAddr("Owner");
    

    function run() public returns(Fallback) {
        
        vm.broadcast(fallbackOwner);
        fallbackContract = new Fallback();
        return fallbackContract;
    }
}