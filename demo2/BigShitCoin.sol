// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./SafeMath.sol";

contract BigShitCoinToken is IERC20{
    string public name = "BigShitCoin";
    string public symbol = "BSC";
    uint8 public decimals = 18;
    uint256 public override totalSupply;
    address private createed;

    // 用于保存每个账号拥有的余额
    mapping (address => uint256) private balances;
    // 用于保存授权的账户，授权函数approve
    mapping (address => mapping (address => uint256)) private allowed;
    // 引入 SafeMath 库
    using SafeMath for uint256;

    constructor(){
        // 总量10万枚代币，有小数点
        totalSupply = totalSupply.add(100000 * (10**decimals));
        // 创建者拥有所有代币
        createed = msg.sender;
        balances[createed] = totalSupply;
    }

    // balanceOf 显示地址为_owner的账户余额。
    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }

    // transfer 发送_value数量的token给地址_to。
    function transfer(address _to, uint256 _value) public override returns (bool success){
        // 发送前做余额检查
        require(_value <= balances[msg.sender],"Insufficient balance.");
        // 地址检查， 不是零值地址。
        require(_to != address(0),"missing address.");

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value); // 触发事件
        return true;
    }

    // transferFrom 从地址_from发送_value数量的token给地址_to。
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        require(_to != address(0));

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    // approve 授权_spender从用户账户里多次提取额度_value数量的token，函数再次被调用后一次的授权额度会重置前一次的授权。
    function approve(address _spender, uint256 _value) public override returns (bool success){
        require(_spender != address(0));
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // allowance 返回 _spender，也可从 _owner 查看 token 仍然可供消费者使用的代币数量（授权数量）。
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}
