//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Contract is ERC20("cmonToken", "CMT"){

    address admin = msg.sender;
    address[] whitelist;
    uint256 etap1 = block.timestamp;
    uint256 etap2 = etap1 + 3 minutes;
    uint256 etap3 = etap2 + 2 minutes;
    uint256 etap4 = etap3 + 5 minutes;

    address inv1 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address inv2 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address inv3 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    address rab1 = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;
    uint256 summa = 30*(10**decimals());

    struct User{
        string login;
        address wallet;
        uint256 balance;
        bool white;
        bool razrab;
    }

    constructor(){
        uint256 dec = 10**decimals();
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
    }

    mapping(address => User) public userMap;
    mapping(string => address) public userLoginMap;
    mapping(string => string) public userPassMap;
    mapping(address => bool) public userWhiteMap;
    mapping(address => bool) public userIsRab;

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

    function takeRequest(uint256 _index, bool _solut) public isAdmin {
        if(_solut){
            userMap[whitelist[_index]].white = true;
            whitelist.push(whitelist[_index]);
            userWhiteMap[whitelist[_index]] = true;
        }
        delete whitelist[_index];
    }

    function takeTokens() public isRab{
        require(block.timestamp == 4 minutes || block.timestamp == 7 minutes || block.timestamp == 10 minutes || block.timestamp == 13 minutes, "Rano eshe");
        transferFrom(admin, msg.sender, 10000*(10**decimals()));
        userMap[msg.sender].balance = balanceOf(msg.sender);
    }

    function buyToken() public payable isWhite{
        uint256 tokenPrice = 1 ether;
        if(block.timestamp < etap4 && summa >= msg.value/tokenPrice * decimals()){
            payable(admin).transfer(msg.value);
            transferFrom(admin, msg.sender, msg.value/tokenPrice * decimals());
            summa -= msg.value/tokenPrice*decimals();
        }
        else{
            // анлаки братан токенов нет
        }
        if(block.timestamp >= etap4){
            tokenPrice = 2 ether;
        }
        payable(admin).transfer(msg.value);
        transferFrom(admin, msg.sender, msg.value/tokenPrice* decimals());
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
        require(userWhiteMap[msg.sender] == true || block.timestamp >= etap4, "You are not white");
        _;
    }

    modifier isRab() {
        require(userIsRab[msg.sender] == true);
        _;
    }

}
