// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Casino {
    // 拥有者
    address public owner;

    uint256 public totalBet;   // 总投注额
    uint256 public numberOfBets; // 投注数
    uint256 public maxAmountOfBets = 2; //最大投注数
    uint256 public minimumBet;  // 最低投注限额；
    address[] public players;   // 玩家数组
    uint256 public decimals = 10 ** 18;
    struct Players { // 每个玩家的定义
        uint256 amountBet; // 每个玩家投注的数额
        uint256 numberSelected; // 每个玩家投注的数
    }
    //映射玩家地址到玩家的投注信息。
    mapping(address => Players) public playerInfo;

    constructor() {
        owner = msg.sender;
        minimumBet = 1 * decimals;
    }

    function setMinimumbet(uint256 _minimumbet) public {
        if (owner == msg.sender && _minimumbet > 0) {
            minimumBet = _minimumbet;
        }
    }

    // numberSelected 对1~10之间的数下注的函数
    // betAmount， 下注的数量
    function bet(uint256 numberSelected) public payable {
        // require(msg.value == betAmount*decimals);
        require(!checkPlayerExists(msg.sender));    // 玩家必须存在。
        require(numberSelected >= 1 && numberSelected <= 10);//玩家可投注的数在1~10之间。
        require(msg.value >= minimumBet);
        playerInfo[msg.sender].amountBet = msg.value; // 在playerInfo里保存相应信息。
        playerInfo[msg.sender].numberSelected = numberSelected;
        numberOfBets++;
        players.push(msg.sender); // 加新玩家到玩家数组。
        totalBet += msg.value; // 总投注额调整。
        if (numberOfBets >= maxAmountOfBets) {
            generateNumberWinner();
        }
    }

    // 检查玩家是否已经存在，一局只能下一次注。
    function checkPlayerExists(address player) public view returns(bool){
        for(uint256 i = 0; i < players.length;i++) {
            if (players[i] == player) {
                return true;
            }
        }
        return false;
    }
    // 生成1~10区间的一个数，决定赢家。
    function generateNumberWinner() public {
        uint256 numberGenerated = block.number % 2 + 1; // 不安全。
        distributePrizes(numberGenerated); //发送给赢家；
    }
    // 将奖金发送给赢家。
    function distributePrizes(uint256 numberWinner) public {
        address payable[100] memory winners;
        uint256 count = 0;
        for(uint256 i = 0; i < players.length; i++) {
            address payable playerAddress = payable(players[i]);
            // 如果投注号码和开奖号码一致，则存入赢家数组，赢家数 +1。
            if (playerInfo[playerAddress].numberSelected == numberWinner) {
                winners[count] = playerAddress;
                count++;
            }
            delete playerInfo[playerAddress];   //删除所有玩家
        }
        delete players; //删除所有的玩家数组。全部重置为0；
        uint256 winnerEthAmount = totalBet/winners.length; // 所有中奖者平分奖金
        for(uint256 j = 0; j < count; j++) {
            if (winners[j] != address(0)) { // 赢家地址不能为0
                winners[j].transfer(winnerEthAmount); // 调用transfer发送奖金
            }
        }
    }

    function getNumberOfBets() public view returns(uint256) {
        return numberOfBets;
    }

    function getPlayerInfo(address target) public view returns(Players memory) {
        return playerInfo[target];
    }

    function getMiniBet() public view returns (uint256) {
        return minimumBet;
    }
    
    function getPlayers() public view returns(address[] memory) {
        return players;
    }
    function getTotalBet() public view returns(uint256) {
        return totalBet;
    }

    receive() external payable{}
}