## Ethernaut Fallback  Contract Challange

**Challenge To Achive**
1. Take OwnerShip Of the Contract
2. Make Contract Balance to Zero

**Exploit** The vulnerability lies in the `receive()` function of `Fallback` contract. 

``` javascript
 receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
@>  owner = msg.sender;
  }
```
Which let user to send ether to contract directly. But it set `owner` variable to `msg.sender` that means anyone sends ether to contract can be the owner of owner and gets control of contract as well as the  `withdraw()` function.

**POC** POC can be found At `./test/FallbackTest.t.sol` have a look how the attack can be done.

## Try The Test 

Run The Following Command And See The Results

```shell
$ forge build
```

```shell
$ forge test
```


