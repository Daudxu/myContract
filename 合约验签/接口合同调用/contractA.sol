// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Iec20{
     function allowance(address _owner, address _spender) external view returns (uint256 remaining);
}

contract Airdropper {
    bytes public data;

    function  checkAllowance(address _addresss) external view returns(uint256 remaining) {
        return  Iec20(_addresss).allowance(msg.sender, address(this));
    }

    function batch(address tokenAddr, address[] calldata toAddr, uint256 [] calldata value) public returns (bool){
            
            require(toAddr.length == value.length && toAddr.length >= 1 && Iec20(tokenAddr).allowance(msg.sender, address(this)) > 0);
            
            for(uint256 i = 0 ; i < toAddr.length; i++){
        
                (bool success, bytes memory _data) = tokenAddr.call(
                    abi.encodeWithSignature("transferFrom(address,address,uint256)",  msg.sender, toAddr[i], value[i])
                );
                require(success, "call falled");
                data = _data;
            }
            return true;
    }
}