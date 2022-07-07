
```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/proxy/utils/Initializable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/ERC20Upgradeable.sol";

contract BigCoin is Initializable, ERC20Upgradeable  {
    /*
    * @dev 初始化函数
    * @params name_ 代币的名称
    * @params symbol_ 代币的符号
    * @params initialSupply 代币的数量，会默认乘以10 ** 18
    */
    function initialize(string memory name_, string memory symbol_, uint256 initialSupply) public virtual initializer {
        require(initialSupply > 0, "Must be a number greater than 0");
        uint8 d = decimals();
        uint256 totalSupply = initialSupply * 10 ** d;
        __ERC20_init(name_,  symbol_);
        _mint(msg.sender, totalSupply); 
    }
}
```