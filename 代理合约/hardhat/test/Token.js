const { expect } = require("chai");
const { ethers } = require("hardhat");
 
describe("Hello", function(){
  it("Should return the new hello once it's changed", async function(){
    const MyContract = await ethers.getContractFactory("MyContract");
    // const hello = await Hello.deploy("hello ,tracy, I am testing");
    // await hello.deployed();
    const sa = await MyContract.attach("0xAdD5857503A750D16a6feA5c0A009f3A5c0ff5bA")
    // sa.setMappingArr(a,3)
    const a = await sa.setMappingArr(a,3)
    // await sa.getMappingArr(a)
    // console.log("hell address:", a);
 
    // //expect(await hello.getMsg());
 
    // console.log("origin getMsg:", await hello.getMsg());
    // const setMsg = await hello.setMsg("new Msg, hello, I am here");
 
    // await setMsg.wait();
    // //expect(await hello.getMsg());
    // console.log("new getMsg:", await hello.getMsg());
  });
});