## Telephone Challege

**Challenge To Achive**
1. Take OwnerShip Of the Contract

**Exploit** The vulnerability lies in the `tx.origin != msg.sender` Validation `Telephone` contract. 

```javascript
function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
```

we can assume that `(tx.origin != msg.sender)` it has been used to check that the caller is not `msg.sender` but as per documentation 
`tx.origin` is a global variable in Solidity that returns the address of the original external owned account (EOA) that started the transaction. It is different from msg. sender, which returns the immediate account (external or contract account) that invoked certain function. So if the caller is contract it cannot be detected by `tx.origin`. For Access Contro it is safer to compare `msg.sender` with a stored addess on the contract.


**POC** POC can be found At `./test/test_attack.js` have a look how the attack can be done.

## Try The Test 

Run The Following Command And See The Results

```shell
$ npm i
```

```shell
$ npx hardhat test 
```

