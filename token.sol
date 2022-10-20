//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Contract is ERC20("cmonToken", "CMT"){

    address admin = msg.sender;
    address[] whitelist;
    
    uint256 etap0 = block.timestamp + 3 minutes;
    uint256 etap1 = block.timestamp + 4 minutes;
    uint256 etap2 = block.timestamp + 10 minutes;

    address inv1 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address inv2 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address inv3 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    address dev1 = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;
    address dev2 = 0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
    address dev3 = 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678;

    uint256 dec = 10**decimals();
    uint256 summa = 200000*dec;

    struct User{
        string login;
        address wallet;
        uint256 balance;
        bool white;
        bool dev;
    }

    struct Dev {
        address wallet;
        uint256 counter;
    }

    constructor(){
        _mint(admin, 650000*dec);
        _mint(inv1, 200000*dec);
        _mint(inv2, 100000*dec);
        _mint(inv3, 50000*dec);
        userMap[inv1] = User("inv1", inv1, balanceOf(inv1), false, false);
        userLoginMap["inv1"] = inv1;
        userPassMap["inv1"] = "123";
        userMap[inv1] = User("inv2", inv2, balanceOf(inv2), false, false);
        userPassMap["inv2"] = "123";
        userLoginMap["inv2"] = inv2;
        userMap[inv1] = User("inv3", inv3, balanceOf(inv3), false, false);
        userPassMap["inv3"] = "123";
        userLoginMap["inv3"] = inv3;
        devMap[dev1] = Dev(dev1, 0);
        userMap[dev1] = User("dev1", dev1, balanceOf(dev1), false, true);
        devMap[dev2] = Dev(dev2, 0);
        userMap[dev2] = User("dev2", dev2, balanceOf(dev2), false, true);
        userIsDev[dev2] = true;
        devMap[dev3] = Dev(dev3, 0);
        userMap[dev3] = User("dev3", dev3, balanceOf(dev3), false, true);
        userIsDev[dev3] = true;
    }

    mapping(address => User) public userMap;
    mapping(string => address) public userLoginMap;
    mapping(string => string) public userPassMap;
    mapping(address => bool) public userIsDev;
    mapping(address => Dev) public devMap;

    function register(string memory _login, string memory _password) public{
        userMap[msg.sender] = User(_login, msg.sender, balanceOf(msg.sender), false, false);
        userPassMap[_login] = _password;
    }

    function auth(string memory _login, string memory _password) public view returns (User memory){
        require(keccak256(abi.encode(userLoginMap[_login])) == keccak256(abi.encode(_login)) && keccak256(abi.encode(userPassMap[_login])) == keccak256(abi.encode(_password)), "Wrong pair login/password");
        return userMap[userLoginMap[_login]];
    }

    function sendRequest() public {
        whitelist.push(msg.sender);
    }

    function requests() public view isAdmin returns (address[] memory){
        return whitelist;
    }

    function takeRequest(uint256 _index, bool _solut) public isAdmin {
        if(_solut){
            userMap[whitelist[_index]].white = true;
            whitelist.push(whitelist[_index]);
        }
        delete whitelist[_index];
    }

    function takeTokens() public isDev{
        require(devMap[msg.sender].counter < 4, "Enough");
        uint _counter = 0;
        if(block.timestamp >= etap1){
            _counter++;
            if(block.timestamp >= etap1 + 3 minutes){
                _counter++;
                if(block.timestamp >= etap1 + 6 minutes){
                    _counter++;
                    if(block.timestamp >= etap1 + 9 minutes){
                        _counter++;
                    }
                }
            }
            transferFrom(admin, msg.sender, 10000*dec*(_counter - devMap[msg.sender].counter));
            devMap[msg.sender].counter = _counter;
        }
        userMap[msg.sender].balance = balanceOf(msg.sender);
    }

    function buyToken() public payable isWhite{
        uint256 tokenPrice = 1 ether;
        if(block.timestamp >= etap2){
            tokenPrice = 2 ether;
            payable(admin).transfer(msg.value);
            transferFrom(admin, msg.sender, (msg.value/tokenPrice) * dec);
        }
        else if(summa >= msg.value/tokenPrice * dec && block.timestamp >= etap0){
            payable(admin).transfer(msg.value);
            transferFrom(admin, msg.sender, (msg.value/tokenPrice) * dec);
            summa -= msg.value/tokenPrice*dec;
        }
        else{
            revert("Net tokenov");
        }
        userMap[msg.sender].balance = balanceOf(msg.sender);
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    modifier isAdmin(){
        require(msg.sender == admin, "You are not admin");
        _;
    }

    modifier isWhite(){
        require((userMap[msg.sender].white == true || block.timestamp >= etap2), "You are not white");
        _;
    }

    modifier isDev() {
        require(userMap[msg.sender].dev, "Not a dev");
        _;
    }

}
