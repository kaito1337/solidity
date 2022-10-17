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
    struct User{
        string login;
        address wallet;
        uint256 balance;
        bool white;
    }

    constructor() payable {
        _mint(admin, 1000000);
        address inv1 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        address inv2 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
        address inv3 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
        address sale = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;
        transfer(inv1, 200000);
        transfer(inv2, 100000);
        transfer(inv3, 50000);
        transfer(sale, 200000);
        userMap[inv1] = User("inv1", inv1, balanceOf(inv1), false);
        userLoginMap["inv1"] = inv1;
        userPassMap["inv1"] = "123";
        userMap[inv1] = User("inv2", inv2, balanceOf(inv2), false);
        userPassMap["inv2"] = "123";
        userLoginMap["inv2"] = inv2;
        userMap[inv1] = User("inv3", inv3, balanceOf(inv3), false);
        userPassMap["inv3"] = "123";
        userLoginMap["inv3"] = inv3;
    }

    mapping(address => User) public userMap;
    mapping(string => address) public userLoginMap;
    mapping(string => string) public userPassMap;
    mapping(address => bool) public userWhiteMap;

    function register(string memory _login, string memory _password) public{
        userMap[msg.sender] = User(_login, msg.sender, 0, false);
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
        }
        delete whitelist[_index];
    }

    function buyToken(uint256 _amount) public payable isWhite{
        uint256 tokenPrice = 0.001 ether;
        address sale = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;
        if(block.timestamp >= etap4){
            tokenPrice = 0.0075 ether;
            require(msg.sender.balance >= tokenPrice* _amount, "Malo deneg");
            payable(admin).transfer(_amount * tokenPrice);
            require(balanceOf(sale) >= _amount, "Malo tokenov");
            transferFrom(sale, msg.sender, _amount);
        }
        require(msg.sender.balance >= tokenPrice* _amount, "Malo deneg");
        require(balanceOf(sale) >= _amount, "Malo tokenov");
        payable(admin).transfer(_amount * tokenPrice);
        transferFrom(sale, msg.sender, _amount);
    }

    modifier isAdmin(){
        require(msg.sender == admin, "You are not admin");
        _;
    }

    modifier isWhite(){
        require(userWhiteMap[msg.sender] == true || block.timestamp >= etap4, "You are not white");
        _;
    }

}
