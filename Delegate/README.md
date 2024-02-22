## Ethernaut Delegate Contract Challange

**Challenge To Achive**
1. Take OwnerShip Of the Contract


**Exploit:** Uses of `Delegate` Call Is Not Safe It Should Be Handled By Care. The vulnerability lies in the `fallback()` function of `Delegation` contract. 

``` javascript
  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
```


The delegate call is a low-level call in Solidity. The minimal concept of the delegate call is that it uses the storage of the contract that invokes the delegate call and employs functions from the contract called by the delegate call. An example can be illustrated with Contract A, which has certain functionalities. Contract B can utilize Contract A's functions by using a delegate call, but the storage used will be from Contract A, not Contract B. This means that if Contract A has a storage variable 'x' and Contract B has a unique function to do something with that storage variable 'x,' Contract A can use a delegate call to employ Contract B's function to update Contract A's storage variable, without affecting Contract B's storage variable.
**Note:** To use delegate  call both contract should have same storage layout and same function. <a href="https://docs.soliditylang.org/en/v0.8.24/control-structures.html#external-function-calls">Learn More About Delegate Call </a> and <a href= "https://solidity-by-example.org/delegatecall/">Delegate Examples</a>

The use of `Delegate` call with the `Fallback` makes the contract riskier here. <a href= "https://docs.soliditylang.org/en/latest/contracts.html">Learn More About Fallback Function</a> 

**POC:** Contract `Delegate` has function to change the onwer of a contract which is `pwn()`.

Delegate Contract

```javascript
contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

@>  function pwn() public {
    owner = msg.sender;
  }
}
```
Contract `Delegation` uses `Delegate` contract in its fallback contract with `delegatecall`.

Delegation Contract

```javascript

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

@>  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}
```
If someone sends a transaction to the `Delegation` contract with or without ether but includes in the data field the name of the `pwn()` function, the transaction will use `msg.data` for that transaction. Since `Delegation` does not have any function named `pwn()`, but it does have a fallback function, the transaction will trigger the `fallback()` function. The `fallback()` function is implemented with a delegate call to the `Delegate` contract, as the `msg.data` contains `pwn()`. The `Delegate` contract has the `pwn()` function, and the delegate call expects a parameter, which is provided by `msg.data` as `pwn()`. Consequently, the logic of `pwn()` will be executed in the `Delegation` contract, resulting in a change of ownership.

There is 2 scenrio of test can be found at `./test/DelegateTest.sol`.




## Try The Test 

Run The Following Command And See The Results.

```shell
$ forge build
```

```shell
$ forge test
```

