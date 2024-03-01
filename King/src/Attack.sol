// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Attacker {


    function attack(address _target, uint256 amount) public payable {
        (bool done,) = payable(_target).call{value: amount ,gas:5000000000}(""); 
        require(done,"Not Done Yet");
    
    }

    receive() external payable{}
}