// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyContractProxyTest is Initializable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    mapping(string => uint256) private mappingArr;

    event logs(string indexed _key,uint256 _value);

    function setMappingArr(string memory _key,uint256 _value) external{
        mappingArr[_key] = _value;
        emit logs(_key,_value);
    }


    function getMappingArr(string memory _key)public view returns(uint256){
        return mappingArr[_key];
    }
}