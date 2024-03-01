// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import{Test, console} from "forge-std/Test.sol";

import {King} from "../src/King.sol";
import {Attacker} from "../src/Attack.sol";

contract AttackeTest is Test {

    address kingOwner = makeAddr("king");
    address attacker = makeAddr("Atacker");
    uint256 constant FIRSTAMOUNT = 2 ether;
    uint256 constant SECONDAMOUNT = 3 ether;

    King kingContract;
    Attacker attackerContract;

    function setUp() public {
        vm.deal(kingOwner, 3 ether);
        vm.deal(attacker, 5 ether);

        vm.startPrank(kingOwner);
        kingContract = new King{value:FIRSTAMOUNT}();
        vm.stopPrank();

        vm.startPrank(attacker);
        attackerContract = new Attacker();
        vm.stopPrank();
    }

    function test_basic() public  view {

        assert(kingContract.owner() == kingOwner);
        assert(kingContract.prize() == 2 ether);
        assert(kingContract._king() == kingOwner);
        assert(address(kingContract).balance == 2 ether);
        assert(address(kingOwner).balance == 1 ether); // as he has send has send 2 ether to the King conntract his balance should be 1 ether.
       
    }
    function test_attack_and_breakSystem() public payable  {

        // Before Attack Previous King Balance
        uint256 prevoiusKingBalanceBeforeAttack = address(kingOwner).balance;

        // Before Attack Previous King Shloud Be kingOwner

        assertEq(kingContract._king() , kingOwner);

        // Before Attack AttackerBalance 
        uint256 attackerBalanceBeforeAttack = address(attacker).balance;


        // Attack Starts
        vm.startPrank(attacker);
        (bool success,) = payable(address(attackerContract)).call{value: 3.5 ether}("");
        require(success, "Failed");
        attackerContract.attack(address(kingContract), SECONDAMOUNT);
        assertEq(kingContract._king() , address(attackerContract));
        
        vm.stopPrank();



    }


}
