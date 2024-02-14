// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import{Test} from "forge-std/Test.sol";
import{DeployFallback} from "../script/DeployFallback.s.sol";
import{Fallback} from "../src/Fallback.sol";


contract FallbackTest is Test {

    Fallback fallbackContract;
    address contributor = makeAddr("contributor");
    address attacker = makeAddr("attacker");
    address fallbackContractOwner;
    DeployFallback deploy;

    function setUp() public {
        vm.deal(contributor,5 ether);
        vm.deal(attacker,1 ether);
        deploy = new DeployFallback();
        fallbackContract = deploy.run();
        fallbackContractOwner = deploy.fallbackOwner();
    }

    function test_Owner() public {

        assert(fallbackContract.owner() == fallbackContractOwner);
    }






}