## FallOut Challege

**Challenge To Achive**
1. Take OwnerShip Of the Contract

**Exploit** The vulnerability lies in the `Fal1out()` function of `Fallout` contract. 

```javascript
  function Fal1out() public payable {
    owner = payable(msg.sender);
    allocations[owner] = msg.value;
  }
```
Which Sets The Owner Of Contract Using `owner = payable(msg.sender)` which is not proper to set this type state varible 
the varibale should be set from the `constructor()` which only executes once  at the time of deployment. This `Fal1out()` is can be call by any user. But `constructor()` is only called at tome of deployment and the sepolyer is the caller / executor of the `constructor()`.

**POC** POC can be found At `./test/FallOutTest.t.sol` have a look how the attack can be done.

## Try The Test 

Run The Following Command And See The Results

```shell
$ forge build
```

```shell
$ forge test
```

