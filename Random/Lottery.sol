pragma solidity > 0.6.0;

contract Lottery{

    uint mintAmountToEnter;
    uint maxEntries;
    bool isLotteryLive;

    mapping(address => Player) players;
    address[] lotteryIndex;


    struct Player{
        bool isEntered;
        string name;
        uint entries;
        uint amount;
    }

    event NewPlayer(string name, uint amount, uint entries);

    function AddToLottery(string memory _name) public payable{
        require(isLotteryLive, "The lottery is not live yet");
        require(bytes(_name).length > 0 , "Bro, where is your name?");
        require(msg.value == mintAmountToEnter * 1 ether , "Bro, pay the right entry...");
        require(players[msg.sender].entries < maxEntries, "Bro, back off. Too many entries");
        
        if(_IsNewEntrie(msg.sender)){
            Player(true, _name, 1, msg.value);
            lotteryIndex.push(msg.sender);
        }
        else{
            players[msg.sender].name = _name;
            players[msg.sender].entries += 1;
            players[msg.sender].amount += msg.value;
        }
        emit NewPlayer(_name, players[msg.sender].amount, players[msg.sender].entries);
    }

    function _IsNewEntrie(address player)private view returns(bool) {
        return players[player].isEntered;
    }

    function SetLotteryLive(uint _mintAmountToEnter, uint _maxEntries)public {
        require(_mintAmountToEnter > 0, "The min amount must be higher than 0");
        require(_maxEntries > 0, "The max entires must be higher than 0");
        isLotteryLive = true;
        mintAmountToEnter = _mintAmountToEnter;
        maxEntries = _maxEntries;
    }

    function GetLotteryWinner()private{

    }

    function GetPlayer(address _playerAddress)private{
        
    }
    function GetLotteryAmount() public view returns (uint) {
        return address(this).balance;
    }
}