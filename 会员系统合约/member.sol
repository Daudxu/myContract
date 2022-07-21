// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface TokenErc {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // event Transfer(address indexed from, address indexed to, uint256 value);
    // event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract DigiTools is Ownable {
    event LogTokenAirdrop(uint256 total, address tokenAddress);

    using SafeMath for uint;
    // cashier Address
    address public  cashierAddress;
    // Supported token addresses
    address public tokenAddress;
    // Token required to open Vip
    uint256 public VIPTokenFee;
    // vip list mapping
    mapping(address => bool) public vipList;
    // vip sign time mapping
    mapping(address => uint) public vipSignUpTime;

    /*
     *  sigin up  VIP
     */
    function  registerVIP() external  {
        uint256 balanceOf = TokenErc(tokenAddress).balanceOf(msg.sender);
        require(balanceOf > VIPTokenFee, "Check the token balanceOf");
        uint256 allowance = TokenErc(tokenAddress).allowance(msg.sender, address(this));
        require(allowance > VIPTokenFee, "Check the token allowance");
        TokenErc(tokenAddress).transferFrom(msg.sender, cashierAddress, VIPTokenFee);
        vipList[msg.sender] = true;
        vipSignUpTime[msg.sender] = block.timestamp;
    }

    /*
     *  VIP list
     */
    function addToVIPList(address[] calldata _vipList) onlyOwner public {
        for (uint i = 0; i < _vipList.length; i++) {
            vipList[_vipList[i]] = true;
        }
    }

    /*
     * Remove VIP 
     */
    function removeVIPList(address[] calldata _vipList) onlyOwner public {
        for (uint i = 0; i < _vipList.length; i++) {
            vipList[_vipList[i]] = false;
        }
    }

    /*
     * Check isVIP
     */
    function isVIP(address _addr) public view returns(bool) {
        return  vipList[_addr];
    }
    
    /*
     * view VIP Time
     */
    function viewVIPTime(address _addr) public view returns(uint) {
        return  vipSignUpTime[_addr];
    }

    /*
     * set cashier address
     */
    function setCashierAddress(address _addr) onlyOwner public {
        require(_addr != address(0));
        cashierAddress = _addr;
    }

    /*
        * set vip Tokenfee
    */
    function setVIPTokenFee(uint256 _TokenFee) onlyOwner public {
        VIPTokenFee = _TokenFee;
    }

    /*
     * set vip Tokenfee
     */
    function setTokenAddress (address _tokenAddress) onlyOwner public {
        tokenAddress = _tokenAddress;
    }

    modifier hasFee() {
        bool vip = isVIP(msg.sender);
        if (!vip) {
            revert("You need to open a member");
        }
        _;
    }

    /**
    * token Airdrop
    */
    function tokenAirdrop(address token, address[] _contributors, uint256[] _balances) public hasFee payable {
        if (token == 0x000000000000000000000000000000000000bEEF){
             etherAirdrop(_contributors, _balances);
        } else {
            uint256 total = 0;
            require(_contributors.length <= arrayLimit());
            ERC20 erc20token = ERC20(token);
            uint8 i = 0;
            for (i; i < _contributors.length; i++) {
                erc20token.transferFrom(msg.sender, _contributors[i], _balances[i]);
                total += _balances[i];
            }
            emit LogTokenAirdrop(total, token);
        }
    }

    /**
    * ether Airdrop
    */
    function etherAirdrop(address[] _contributors, uint256[] _balances) public hasFee payable {
        
    }

    
}