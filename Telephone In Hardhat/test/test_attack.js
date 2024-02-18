const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Telepohne", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployTelephone() {
    const [contractDeployer, user1, newOnwer] = await ethers.getSigners();
    const contract = await ethers.getContractFactory("Telephone")
    const telephone = await contract.connect(contractDeployer).deploy();
    const contract2 = await ethers.getContractFactory("Attacker"); 
    const telephonAddress  = await telephone.getAddress();
    const attacker = await contract2.connect(newOnwer).deploy(telephonAddress);
    return { telephone,contractDeployer, user1, newOnwer,attacker};
  }

  it("contractDeployer should be the contract owner", async()=>{

    const  { telephone,contractDeployer, user1, newOnwer,attacker } = await loadFixture(deployTelephone);
    
    expect(await telephone.owner()).to.be.equal(contractDeployer.address);

    try {
      await telephone.connect(user1).changeOwner(newOnwer.address);
    } catch (error) {
      console.log(error);
    }

    expect(await telephone.owner()).to.be.not.equal(newOnwer.address);

  });

  it("Owners of The Attacker Should Be The Telephone Contract owner", async()=>{


    const  { telephone,contractDeployer, user1, newOnwer, attacker } = await loadFixture(deployTelephone);
    
    expect(await telephone.owner()).to.be.equal(contractDeployer.address);
    try {
      await telephone.connect(user1).changeOwner(newOnwer.address);
    } catch (error) {
      console.log(error);
    }

    expect(await telephone.owner()).to.be.not.equal(newOnwer.address);

    // Attacker
    expect(await attacker.owner()).to.be.equal(newOnwer.address);

    try {
      await attacker.connect(newOnwer).claim();
    } catch (error) {
      console.log(error);
    }

    expect(await telephone.owner()).to.be.equal(newOnwer.address);

  });
});


