// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";


contract Airdropper is Ownable {

     event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // GAS费消耗 843307 
    function AirTransferTest1(address[] memory  _to, uint  _values, address _from) onlyOwner public returns (bool) {
        require(_to.length > 0);
        for(uint i = 0; i < _to.length; i++){
             emit Transfer(_from, _to[i], _values);
        }
 
        return true;
    }
    // GAS费消耗 637498 
    function AirTransferTest2(address[] calldata  _to, uint  _values, address _from) onlyOwner public returns (bool) {
        require(_to.length > 0);
        for(uint i = 0; i < _to.length; i++){
             emit Transfer(_from, _to[i], _values);
        }
 
        return true;
    }
     


    // GAS费消耗 637498 638464 638996 
    function AirTransferTest3(address[] calldata to, uint  values, address from) onlyOwner public returns (bool) {
        require(to.length > 0);
        address _from =  from;
        uint _values =  values;
        for(uint i = 0; i < to.length; i++){
             emit Transfer(_from, to[i], _values);
        }
        return true;
    }
// [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db]
}

