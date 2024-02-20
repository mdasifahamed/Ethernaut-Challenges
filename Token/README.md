# Token Challenge

**Challenge To Achive**
The goal of this level is for you to hack the basic token contract below.
You are given 20 tokens to start with and you will beat the level if you somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.

**Exploit** The vulnerability lies in the `transfer()` function of the `Token` contract, where integer overflow/underflow is not handled. Versions before `solidity 0.8.0` do not automatically handle this issue.


```javascript

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

```
In the above code, `require(balances[msg.sender] >= _value);` checks if the remaining balance of the sender is greater than or equal to zero. Since the contract uses `Solidit`y version `0.6.0,` which does not automatically handle `integer overflow and underflow`, it cannot be handled automatically.

**POC** If user a user has 20 token and tries to send 100 token he can success fully can do it becasue
20-100 = - 80 (this is a underflow)
but it was uint type data and that `-80` will be converted to 0 and as per the condition `require(balances[msg.sender] - _value >= 0);` 
if we let  `balances[msg.sender]` = `20` and `_value` = `100`.

then it will be `balances[msg.sender] - _value` = `0` 
this `balances[msg.sender] - _value >=0` will be `0>=0` and this is true so the rest of line of function `transfer()` will be exectued.

A witrren test can be found At `./test/TokenTest.t.sol` have a look how the attack can be done.

## Try The Test 

Run The Following Command And See The Results

```shell
$ forge build
```

```shell
$ forge test
```

**Mitigation** There Are Few Mitigation Steps Can be Taken 
1. Instead of checking the remainder, check if the actual balance is greater than the transfer amount.
```diff
-  require(balances[msg.sender] - _value >= 0);
+  require(balances[msg.sender] > _value);
```
2. Update The Solidity Version To `0.8.0`.

3. Use Openzeppelin <a href="https://docs.openzeppelin.com/contracts/2.x/api/math#SafeMath">SafeMath Libray</a> if your are stick to older solidity version
