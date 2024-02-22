## Ethernaut Delegate Contract Challange

**Challenge To Achive**
1. Take OwnerShip Of the Contract


**Exploit** Uses of `Delegate` Call Is Not Safe It Should Be Handled By Care. The vulnerability lies in the `fallback()` function of `Delegation` contract. 

``` javascript
  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
```
>"The delegate call is a low-level call in Solidity. The minimal concept of the delegate call is that it uses the storage of the contract that invokes the delegate call and employs functions from the contract called by the delegate call. An example can be illustrated with Contract A, which has certain functionalities. Contract B can utilize Contract A's functions by using a delegate call, but the storage used will be from Contract A, not Contract B. This means that if Contract A has a storage variable 'x' and Contract B has a unique function to do something with that storage variable 'x,' Contract A can use a delegate call to employ Contract B's function to update Contract A's storage variable, without affecting Contract B's storage variable.
**Note:** To use delegate  call both contract should have same storage layout and same function. <a href="https://docs.soliditylang.org/en/v0.8.24/control-structures.html#external-function-calls">Learn More About Delegate Call </a> and <a href= "https://solidity-by-example.org/delegatecall/">Delegate Examples</a>


## Try The Test 

Run The Following Command And See The Results

```shell
$ forge build
```

```shell
$ forge test
```

