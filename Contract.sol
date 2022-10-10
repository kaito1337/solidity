//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myContract{

    address private owner = msg.sender;
    uint256 private shopId = 0;
    uint256 private userId = 0;
    uint256 private requestId = 0;

    struct User{
        uint256 id;
        string login;
        string name;
        address wallet;
        uint256 role; // 1 - покупатель, 2 - продавец, 3 - админ, 4 - поставщик, 5 - банк
        uint256 balance;
        uint256 tempRole;
    }

    struct Shop{
        uint256 id;
        string city;
        address wallet;
        uint256 balance;
        address[] employees;
    }

    struct Coms{
        uint256 id;
        string text;
        uint256 likes;
        uint256 dislikes;
        uint256 point;
        // uint256 parent; сделать ответы, у обычного кома это shopId у ответа это id 
    }

    struct Request{
        uint256 id;
        uint256 shopId;
        address userAddress;
    }

    mapping(address => User) private userMap;
    mapping(uint256 => address) private idUserMap;
    mapping(address => string) private userPass;
    mapping(uint256 => Shop) private shopMap;
    mapping(uint256 => Coms[]) private shopCommMap;
    mapping(string => address) private loginMap;

    constructor() {  
    }

    Request[] requests;

    modifier isOwner(){
        require(owner == msg.sender, "You are not owner");
        _;
    }

    modifier isNotGuest(){
        require(userMap[msg.sender].role >= 1, "You are guest");
        _;
    }

    modifier isAdmin(){
        require(userMap[msg.sender].role == 3 || owner == msg.sender, "You are not admin");
        _;
    }

    modifier isSeller(){
        require(userMap[msg.sender].role == 2);
        _;
    }

    modifier isSellerOrBuyer(){
        require(userMap[msg.sender].role == 2 || userMap[msg.sender].role == 1 || userMap[msg.sender].tempRole == 1);
        _;
    }

    function register(string memory _login, string memory _name, string memory _password) public {
        userMap[msg.sender] = User(userId++,_login,_name,msg.sender, 1, address(msg.sender).balance, 0);
        userPass[msg.sender] = _password;
        idUserMap[userId] = msg.sender;
        loginMap[_login] = msg.sender;
    }

    function auth(string memory _login, string memory _password) public view returns(User memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)), "Wrong pair of login and password");
        require(keccak256(abi.encode(userPass[loginMap[_login]])) == keccak256(abi.encode(_password)), "Wrong pair of login and password");
        return userMap[msg.sender];
    }

    function setAdmin(address _address) public isAdmin {
        userMap[_address].role = 3;
    }

    function changeRole(address _address, uint256 _role) public isAdmin {
        userMap[_address].role = _role;
    }

    function adminToBuyer() public isAdmin{
        userMap[msg.sender].tempRole = 1;
    }

    function sendRequest(uint256 _shopId) public isSellerOrBuyer{
        requestId++;
        if(userMap[msg.sender].id == 1){
            requests.push(Request(requestId, _shopId, msg.sender));
        }
        else{
            requests.push(Request(requestId, _shopId, msg.sender));
        }
    }

    function takeRequest(uint256 _index, bool _solut) public isAdmin{
        User memory _sender = userMap[requests[_index].userAddress];
        if(_solut){
            if(_sender.role == 1){
                userMap[requests[_index].userAddress].role = 2;
                shopMap[requests[_index].shopId].employees.push(_sender.wallet);
            }
            else{
                _sender.role = 1;
                for(uint256 i = 0; i < shopMap[requests[_index].shopId].employees.length; i++){
                    if(shopMap[requests[_index].shopId].employees[i] == _sender.wallet){
                        delete shopMap[requests[_index].shopId].employees[i];
                    }
                }
            }
        }
            delete requests[_index];
    }

    function returRequest() public view returns(Request[] memory){
        return requests;
    }

    // function registerShop(string memory _city) public isAdmin {
    //     shopId++;
    //     address[] memory empty;
    //     shopMap[shopId] = Shop(shopId, _city, msg.sender, address(msg.sender).balance,empty);
    // } 
    // юзелесс 

    function addShop(address _shopAddress, string memory _city) public isAdmin {
        shopId++;
        address[] memory empty;
        shopMap[shopId] = Shop(shopId, _city, _shopAddress, _shopAddress.balance, empty);
    }

    function emplreturn(uint256 _shopId) public view returns (Shop memory){
        return shopMap[_shopId];
    }

    function deleteShop(uint256 _shopId) public isAdmin {
        for(uint256 i = 0; i<shopMap[_shopId].employees.length; i++){
            userMap[shopMap[_shopId].employees[i]].role = 1;
        }
        delete shopMap[_shopId];
    }

    function addComm(string memory _text, uint256 _shopId, uint256 _point) public {
        require(_point <= 10 && _point >= 1, "Point must be in range 1-10");
        uint256 _id = shopCommMap[_shopId].length;
        shopCommMap[_shopId].push(Coms(_id, _text, 0, 0, _point));
    }

    function an

    function backComm(uint256 _shopId) public view returns(Coms[] memory){
        return shopCommMap[_shopId];
    }

    function like(uint256 _shopId, uint256 _commId) public isNotGuest {
        shopCommMap[_shopId][_commId].likes++;
    }
    function dislike(uint256 _shopId, uint256 _commId) public isNotGuest {
        shopCommMap[_shopId][_commId].dislikes++;
    }
}
