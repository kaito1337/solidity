//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Contract {
    
    address private owner = msg.sender;
    uint256 shopId = 0;
    
    struct User {
        string login;
        string password;
        address wallet;
        bool notBlackList;
    }

    struct Shop {
        uint256 shopId;
        string title;
        string location;
        uint256 profit;
        uint256 countOfBuyers;
    }

    struct Product { 
        uint id;
        string title;
        uint256 price;
        string date;
    }

    struct Coms {
        string text;
        address[] likes;
        address[] dis;
    }

    mapping(address => User) private userMap;
    mapping(address => Shop) public shopMap;
    mapping(address => Coms) public comsMap;
    mapping(uint256 => Product[]) private productMap;

    modifier notBlack {
        require(userMap[msg.sender].notBlackList == false, "You are in blacklist");
        _;
    }

    modifier isOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    function registerUser(string memory _login, string memory _password) public {
        require(userMap[msg.sender].wallet == address(0), "User is already created");
        userMap[msg.sender] = User(_login,_password, msg.sender, false);
    }

    function authUser(string memory _login, string memory _password) public view notBlack returns(User memory) {
        require(keccak256(abi.encode(userMap[msg.sender].login)) == keccak256(abi.encode(_login)), "Wrong pair of password and login");
        require(keccak256(abi.encode(userMap[msg.sender].password)) == keccak256(abi.encode(_password)), "Wrong pair of password and login");
        return userMap[msg.sender];
    }
    
    function transfer(address payable _buyer) public payable notBlack {
        _buyer.transfer(msg.value);
    }

    function contractTransfer() public payable notBlack {
        
    }
    
    function balanceOf() public view notBlack returns(uint256) {
        return address(this).balance;
    }

    function registerShop(string memory _title, string memory _location, uint256 _profit, uint256 _countOfBuyers) public notBlack {
        shopMap[msg.sender] = Shop(shopId++,_title, _location, _profit, _countOfBuyers);
    }

    function addToBlacklist(address _wallet) public notBlack isOwner {
        userMap[_wallet].notBlackList = true;
    }

    function changeOwner(address newOwner) public isOwner {
        owner = newOwner;
    }

    function checkOwner() public view notBlack returns(address) {
        return owner;
    }

    function addProduct(uint256 _shopId, string memory _title, uint256 _price, string memory _date) public notBlack {
        uint256 _id = productMap[_shopId].length;
        productMap[_shopId].push(Product(_id,_title,_price,_date));
    }

    function getProduct(uint256 _shopId, uint256 _index) public view notBlack returns (Product memory){
        return (productMap[_shopId][_index]);
    }

    function deleteProduct(uint256 _shopId, uint256 _index) public notBlack {
        delete productMap[_shopId][_index];
    }

    function backComm(address poster) public notBlack view returns(Coms memory){
        return comsMap[poster];
    }

    function addComm(string memory _text) public notBlack{
        address[] memory empty;
        comsMap[msg.sender] = Coms(_text, empty, empty );
    }

    function like(address _user) public notBlack {
        for(uint i = 0; i<comsMap[_user].likes.length; i++){
            require(comsMap[_user].likes[i] != msg.sender, "You are already likes this post");
        }
        for(uint i = 0; i<comsMap[_user].dis.length; i++){
            require(comsMap[_user].dis[i] != msg.sender, "You are already dislikes this post");
        }
        comsMap[_user].likes.push(msg.sender);
    }

    function dislike(address _user) public notBlack {
        for(uint i = 0; i<comsMap[_user].dis.length; i++){
            require(comsMap[_user].dis[i] != msg.sender, "You are already dislikes this post");
        }
        for(uint i = 0; i<comsMap[_user].likes.length;i++){
            require(comsMap[_user].likes[i] != msg.sender, "You are already likes this post");
        }
        comsMap[_user].dis.push(msg.sender);
    }
}
