// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import{Test} from "forge-std/Test.sol";

import{Fallout} from "../src/Fallout.sol";

contract FalloutTest is Test {

    // Make Owner Of FallOut Contract
    address falloutOwner = makeAddr("onwer");
    address contributor1 = makeAddr("C1");
    address contributor2 = makeAddr("C2");
    address attacker  = makeAddr("Attacker");

    Fallout falloutContact;

    function setUp() public {
        
        falloutContact = new Fallout();

        // give Some Balance To Our Accounts

        vm.deal(falloutOwner, 2 ether);
        vm.deal(contributor1, 2 ether);
        vm.deal(contributor2, 2 ether);
        vm.deal(attacker, 1 ether);

        // lets call the Fal1out() function and 
        // set the falloutOwner as the FallOut Contract Owner

        vm.startPrank(falloutOwner);
        falloutContact.Fal1out{value: 1 ether}();
        vm.stopPrank();
     }


     function test_Sample() public {

        assertEq(falloutContact.owner() ,falloutOwner);
        assertEq(address(falloutContact).balance , 1 ether); // as we sent through 1 ether to the contract using Fal1out() from above setUp function 


     } 


}