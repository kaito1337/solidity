//SPDX-License-Identifier: MIT;
pragma solidity ^0.8.7;

contract myContract{
    
    struct User{
        string login;
        string name;
        uint256 role; // 1 - b, 2 - s, 3 - a, 4 - p, 5 - b, 6 - sh
        uint256 tempRole;
        address wallet;
        uint256 balance;
        string secret;
        uint256 shopWork;
    }

    struct Shop{
        uint256 id;
        string name;
        string city;
        address wallet;
        uint256 balance;
        string[] employees;
    }

    struct Request{
        uint256 id;
        string login;
        uint256 shopId;
    }

    uint256 shopId = 1;
    uint256 requestId = 1;
    address owner = msg.sender;

    Shop[] shops;
    Request[] requests;
    address[] loans;
    string[] admins;

    mapping(address => User) public userMap;
    mapping(string => address) public loginMap;
    mapping(address => string) public passMap;
    mapping(address => Shop) public shopMap;
    mapping(string => address) public shopLoginMap;
    mapping(uint256 => address) public shopIdMap;

    function register(string memory _login, string memory _name, string memory _password, string memory _secret) public{
        require(loginMap[_login] == address(0), "User already exists");
        userMap[msg.sender] = User(_login, _name, 1, 0, msg.sender, msg.sender.balance, _secret, 0);
        loginMap[_login] = msg.sender;
        passMap[msg.sender] = _password;
    }

    function auth (string memory _login, string memory _password, string memory _secret) public view returns (User memory) {
        require(keccak256(abi.encode(_login)) == keccak256(abi.encode(userMap[loginMap[_login]].login)));
        require(keccak256(abi.encode(_password)) == keccak256(abi.encode(passMap[loginMap[_login]])));
        require(keccak256(abi.encode(_secret)) == keccak256(abi.encode(userMap[loginMap[_login]].secret)));
        return userMap[loginMap[_login]];
    }

    function changeRole(string memory _login, uint256 _role) public isAdmin {
        if(userMap[loginMap[_login]].role == 3){
            userMap[loginMap[_login]].tempRole = _role;
        }
        else{
            userMap[loginMap[_login]].role = _role;
        }
    }

    function setAdmin(string memory _login) public isAdmin {
        userMap[loginMap[_login]].role = 3;
        userMap[loginMap[_login]].tempRole = 3;
        admins.push(_login);
    }

    function addShop(string memory _login, string memory _name, string memory _city) public isAdmin {
        require(shopLoginMap[_login] == address(0), "Shop already created with this login");
        address _user = loginMap[_login];
        string[] memory empty;
        shopMap[_user] = Shop(shopId++, _name, _city, _user, _user.balance, empty);
        shops.push(Shop(shopId, _name, _city, _user, _user.balance, empty));
        userMap[_user].role = 6;
        userMap[_user].shopWork = shopId;
        shopLoginMap[_login] = _user;
    }

    function deleteShop(string memory _login) public isAdmin {
        address _user = loginMap[_login];
        userMap[_user].role = 1;
        userMap[_user].shopWork = 0;
        for(uint256 i = 0; i< shopMap[_user].employees.length; i++){
            userMap[loginMap[shopMap[_user].employees[i]]].shopWork = 0;
        }
        for(uint256 j = 0; j < shops.length; j++){
            if(keccak256(abi.encode(userMap[shops[j].wallet].login)) == keccak256(abi.encode(_login))){
                delete shops[j];
            }
        }
        delete shopLoginMap[_login];
        delete shopMap[_user];
    }

    function getAdmins() public view isAdmin returns (string[] memory){
        return admins;
    }

    function getEmpl() public view isAdmin returns (Shop[] memory){
        return shops;
    }

    function becomeBuyer() public isAdmin {
        userMap[msg.sender].tempRole = 1;
    }

    function becomeAdmin() public isAdmin {
        userMap[msg.sender].tempRole = 3;
    }

    function sellerToBuyer() public isSeller {
        userMap[msg.sender].tempRole = 1;
    }

    function buyerToSeller() public isSeller {
        userMap[msg.sender].tempRole = 2;
    }

    function request(string memory _login, uint256 _shopId) public isSellerOrBuyer {
        requests.push(Request(requestId++, _login, _shopId));
    }

    function takeRequest(uint256 _id, bool _solut) public isAdmin {
        _id -= 1;
        if(_solut){
            if(userMap[loginMap[requests[_id].login]].role == 1){
                userMap[loginMap[requests[_id].login]].role = 2;
                userMap[loginMap[requests[_id].login]].tempRole = 2;
                userMap[loginMap[requests[_id].login]].shopWork = requests[_id].shopId;
                shopMap[shopIdMap[_id]].employees.push(requests[_id].login);
            }else{
                userMap[loginMap[requests[_id].login]].role = 1;
                userMap[loginMap[requests[_id].login]].tempRole = 1;
                userMap[loginMap[requests[_id].login]].shopWork = 0;
                for(uint256 i = 0; i<shopMap[shopIdMap[_id]].employees.length; i++){
                    if(keccak256(abi.encode(shopMap[shopIdMap[_id]].employees[i])) == keccak256(abi.encode(requests[_id].login))){
                        delete shopMap[shopIdMap[_id]].employees[i];
                    }
                }
            }
        }
        delete requests[_id];
    }

    function takeLoan() public isShop {
        loans.push(msg.sender);
    }

    function giveLoan(uint256 _id, bool _solut) public payable isBank {
        _id -= 1;
        if(_solut){
            require(msg.value == 1000 ether, "Invalid value");
            payable(loans[_id]).transfer(msg.value);
            userMap[msg.sender].balance = msg.sender.balance;
            userMap[loans[_id]].balance = loans[_id].balance;
            shopMap[loans[_id]].balance = loans[_id].balance;
        }else{
            require(msg.value == 0, "Invalid value");
        }
        delete loans[_id];
    }

    modifier isAdmin() {
        require(userMap[msg.sender].role == 3 || msg.sender == owner, "You are not admin");
        _;
    }
    
    modifier isShop(){
        require(userMap[msg.sender].role == 6, "You are not a shop");
        _;
    }

    modifier isBank(){
        require(userMap[msg.sender].role == 5, "You are not a bank");
        _;
    }

    modifier isSeller() {
        require(userMap[msg.sender].role == 2, "You are not a seller");
        _;
    }

    modifier isSellerOrBuyer() {
        require(userMap[msg.sender].tempRole == 1 || userMap[msg.sender].tempRole == 2, "You are not a seller or buyer");
        _;
    }

}
