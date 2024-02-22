// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import{Test,console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "../src/Delegates.sol";
import{Attacker} from "../src/Attacker.sol";


contract DelegateTest is Test {

    address DelegateContractOwner = makeAddr("DOwner");
    address AttackerOwner = makeAddr("attacker");
    


    Delegate delegate;
    Delegation delegation;
    Attacker attacker;
    function setUp() public{


        vm.startPrank(DelegateContractOwner);

        delegate = new Delegate(DelegateContractOwner);

        delegation = new Delegation(address(delegate));
        vm.stopPrank();

        vm.startPrank(AttackerOwner);
        attacker = new Attacker(address(delegation));
        vm.stopPrank();

     
    }


    function test_basic() public{

        assertEq(delegate.owner(), DelegateContractOwner);
        assertEq(delegation.owner(), DelegateContractOwner);

    }


    function test_AttackWithContract() public {
        //Before Attack 

        assertEq(delegation.owner(), DelegateContractOwner);

        vm.startPrank(AttackerOwner);
        attacker.attack();
        vm.stopPrank();
        
        // After Attack The Attackeer Contract Should be The Owner
        assertEq(delegation.owner(), address(attacker));



        
    }




}