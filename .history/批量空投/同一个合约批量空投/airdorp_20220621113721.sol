// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Mytoken is ERC20, Ownable {
    event sa(address indexed _to, uint256 _value);

    constructor() ERC20("mytoken", "MTK") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function Airdropper(address[] calldata  _to, uint256[] calldata _account)  public returns (bool) {
        require(_to.length > 0 && _to.length == _account.length);
        for(uint i = 0; i < _to.length; i++){
             transfer(_to[i], _account[i]);
             emit sa(_to[i], _account[i]);
        }
        return true;
    }
    // 测试数据
    // owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // _to: ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"]
    // _account: [22,66,99]
}