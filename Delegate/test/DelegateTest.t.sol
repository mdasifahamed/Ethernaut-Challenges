// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import{Test,console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "../src/Delegates.sol";

contract DelegateTest is Test {

    address DelegateContractOwner = makeAddr("DOwner");
    address AttackerOwner = makeAddr("attacker");


    Delegate delegate;
    Delegation delegation;
    function setUp() public{


        vm.startPrank(DelegateContractOwner);

        delegate = new Delegate(DelegateContractOwner);

        delegation = new Delegation(address(delegate));
        vm.stopPrank();

     
    }


    function test_basic() public{

        assertEq(delegate.owner(), DelegateContractOwner);
        assertEq(delegation.owner(), DelegateContractOwner);

    }



}