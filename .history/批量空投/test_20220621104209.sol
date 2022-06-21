// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Airdropper is Ownable {
     //日志
     event Transfer(address  _from, address indexed _to, uint256  _value);

    function batch(address  tokenAddr, address [] calldata toAddr, uint256 []  value) returns external (bool){

        require(toAddr.length == value.length && toAddr.length >= 1);

        bytes4 fID= bytes4(keccak256("transferFrom(address,address,uint256)"));

        for(uint256 i = 0 ; i < toAddr.length; i++){

            if(!tokenAddr.call(fID, msg.sender, toAddr[i], value[i])) { revert(); }
        }
    }
}

