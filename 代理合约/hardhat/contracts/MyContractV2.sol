// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyContractV2 is Initializable, ERC20Upgradeable {
    
    mapping(string => uint256) private mappingArr;
    event logs(string indexed _key,uint256 _value);
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC20_init("MyToken", "MTK");
         _mint(msg.sender, 1000000000000000000 * 10 ** decimals());
    }
    
    function setMappingArr(string memory _key,uint256 _value) external{
        mappingArr[_key] = _value;
        emit logs(_key,_value);
    }

    function getMappingArr(string memory _key)public view returns(uint256){
       return  mappingArr[_key] + 1;
    }
}
