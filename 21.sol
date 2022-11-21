//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract myContract{

    struct User{
        string login;
        string fio;
        uint256 balance;
        address wallet;
        uint256 role; // 1 - покупатель, 2 - продавец, 3 - админ, 4 - поставщик, 5 - банк, 6 - магазин
        uint256 tempRole;
        // ответы и коммы
        uint256 shopId;
    }

    struct Shop{
        uint256 id;
        string city;
        address wallet;
        address[] employees;
    }

    struct Request{
        uint256 id;
        address wallet;
        uint256 shopId;
    }

    address owner = msg.sender;

    Shop[] shops;
    Request[] requests;
    string[] admins;

    mapping(address => User) public userMap;
    mapping(string => address) public loginMap;
    mapping(address => string) public passwordMap;
    mapping(uint256 => Shop) public shopMap;
    mapping(uint256 => Request) public reqMap;
    
    modifier isAdmin(){
        require(userMap[msg.sender].role == 3 || userMap[msg.sender].tempRole == 3 || owner == msg.sender, "You are not admin");
        _;
    }

    modifier isSeller(){
        require(userMap[msg.sender].role == 2 || userMap[msg.sender].tempRole == 2, "You are not seller");
        _;
    }

    modifier isSellerOrBuyer(){
        require(userMap[msg.sender].role < 3 || userMap[msg.sender].tempRole < 3, "You are not seller or buyer");
        _;
    }

    function register(string memory _login, string memory _fio, string memory _password) public {
        require(loginMap[_login] == address(0), "User already exists");
        userMap[msg.sender] = User(_login, _fio, msg.sender.balance, msg.sender, 1, 1, 0);
        loginMap[_login] = msg.sender;
        passwordMap[msg.sender] = _password;
    }

    function auth(string memory _login, string memory _password) public view returns (User memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)) && keccak256(abi.encode(passwordMap[loginMap[_login]])) == keccak256(abi.encode(_password)), "Wrong data");
        return userMap[loginMap[_login]];
    }

    function changeRole(address _address, uint256 _role) public isAdmin{
        if(userMap[_address].role == 3){
            userMap[_address].tempRole = _role;
        }
        else{
            userMap[_address].role = _role;
            userMap[_address].tempRole = _role;
        }
    }

    function addAdmin(address _wallet) public isAdmin{
        userMap[_wallet].role = 3;
        userMap[_wallet].tempRole = 3;
        admins.push(userMap[_wallet].login);
    }

    function returnAdmins() public view isAdmin returns(string[] memory){
        return admins;
    }

    function sellerToBuyer() public isSeller{
        userMap[msg.sender].tempRole = 1;
    }

    function sellerBack() public isSeller{
        userMap[msg.sender].tempRole = 2;
    }

    function adminToBuyer() public isAdmin{
        userMap[msg.sender].tempRole = 1;
    }

    function adminBack() public isAdmin{
        userMap[msg.sender].tempRole = 3;
    }

    function addShop(address _address, string memory _city) public isAdmin{
        address[] memory empty;
        userMap[_address].role = 6;
        userMap[_address].tempRole = 6;
        shopMap[shops.length+1] = Shop(shops.length+1, _city, _address, empty);
        shops.push(Shop(shops.length+1, _city, _address, empty));
    }

    function deleteShop(uint256 _id) public isAdmin{
        Shop memory _shop = shopMap[_id];
        for(uint256 i = 0; i<_shop.employees.length; i++){
            userMap[_shop.employees[i]].role = 1;
            userMap[_shop.employees[i]].tempRole = 1;
            userMap[_shop.employees[i]].shopId = 0;
        }
        userMap[shopMap[_id].wallet].role = 1;
        userMap[shopMap[_id].wallet].tempRole = 1;
        delete shops[_id-1];
        delete shopMap[_id];
    }

    function returnShops() public view returns(Shop[] memory){
        return shops;
    }

    function returnEmpl(uint256 _id) public view returns(address[] memory) {
        return shopMap[_id].employees;
    }
    
    function sendRequest(uint256 _shopId) public isSellerOrBuyer {
        for(uint256 i = 0; i<requests.length; i++){
            require(keccak256(abi.encode(requests[i].wallet)) != keccak256(abi.encode(msg.sender)), "Request already exists");
        }
        requests.push(Request(requests.length+1, msg.sender, _shopId));
        reqMap[requests.length] = Request(requests.length, msg.sender, _shopId);
    }

    function takeRequest(uint256 _id, bool _solut) public isAdmin {
        _id--;
        address _wallet = requests[_id].wallet;
        uint256 _shopId = requests[_id].shopId;
        if(_solut){
            if(userMap[_wallet].role == 1){
                userMap[_wallet].role = 2;
                userMap[_wallet].tempRole = 2;
                userMap[_wallet].shopId = _shopId;
                shopMap[_shopId].employees.push(_wallet);
                shops[_shopId-1].employees.push(_wallet);
            }else{
                userMap[_wallet].role = 1;
                userMap[_wallet].tempRole = 1;
                userMap[_wallet].shopId = 0;
                for(uint256 i = 0; i < shopMap[_shopId].employees.length; i++){
                    if(keccak256(abi.encode(shopMap[_shopId].employees[i])) == keccak256(abi.encode(_wallet))){
                        delete shopMap[_shopId].employees[i];
                    }
                }
                for(uint256 j = 0; j < shops[_shopId-1].employees.length; j++){
                    if(keccak256(abi.encode(shops[_shopId-1].employees[j])) == keccak256(abi.encode(_wallet))){
                        delete shops[_shopId-1].employees[j];
                    }
                }
            }
        }
        delete requests[_id];
    }

    function returnRequest() public view isAdmin returns(Request[] memory){
        return requests;
    }
}
