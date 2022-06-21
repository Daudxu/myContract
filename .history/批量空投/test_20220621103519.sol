// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Airdropper is Ownable {
     //日志
     event Transfer(address  _from, address indexed _to, uint256  _value);

    function batch(address storge tokenAddr, address [] calldata toAddr, uint256 []  value) returns (bool){

        require(toAddr.length == value.length && toAddr.length >= 1);

        bytes4 fID= bytes4(keccak256("transferFrom(address,address,uint256)"));

        for(uint256 i = 0 ; i < toAddr.length; i++){

            if(!tokenAddr.call(fID, msg.sender, toAddr[i], value[i])) { revert(); }
        }
    }
    
    // 授信
    // function approve(address spender, uint256 amount) public virtual override returns (bool) {
    //     address owner = msg.sender;
        // _approve(owner, spender, amount);
        // return true;
    // }

    // // 发送空投
    // function AirTransferTest2(address[] calldata  _to, uint  _values, address _from) onlyOwner public returns (bool) {
    //     require(_to.length > 0);
    //     for(uint i = 0; i < _to.length; i++){
    //          emit Transfer(_from, _to[i], _values);
    //     }
    //     return true;
    // }
// [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db]
}

