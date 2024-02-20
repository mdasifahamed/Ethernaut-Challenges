// SPDX-License-Identifier: MIT
pragma solidity  0.7.6;
pragma abicoder v2;

import{Test,console} from "forge-std/Test.sol";

import{Token} from "../src/Token.sol";

contract TokenTest is Test {

    Token token;
    address tokenDeployer = makeAddr("TokenDeployer");
    address user1 = makeAddr("User1");
    address user2 = makeAddr("User2");
    uint256 constant InitialAmount = 10000;

    function setUp() public {
        vm.prank(tokenDeployer);
        token = new Token(InitialAmount);
        vm.stopPrank();
    }


    function test_basic() public {

        // token toatal supply should be 10000;

        assertEq(token.totalSupply(), InitialAmount);

        // `tokenDeployer` should have `InitialAmount` Amountof token

        assertEq(token.balanceOf(tokenDeployer), InitialAmount);

        /**
          Transfering 100 tokens from `tokenDeployer`
          to `user1`. `user1` should have 100 tokens
          and `tokenDeployer` Should Have = 10000-100 = 9900 tokens
         */

         vm.prank(tokenDeployer);
         token.transfer(user1, 100);
         vm.stopPrank();

        assertEq(token.balanceOf(tokenDeployer), InitialAmount-100);
        assertEq(token.balanceOf(user1), 100);

    }

    function test_attack() public {
        uint256 number = 0;
        if(number-300>0){
            console.log(300);

        }
        else{
            console.log(false);
        }
    }





} 