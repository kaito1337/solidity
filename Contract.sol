//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myContract{

    address private owner = msg.sender;
    uint256 private shopId = 9;
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
    }

    struct Answer{
        uint256 parent;
        string text;
        uint256 likes;
        uint256 dislikes;
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
    mapping(address => uint256) private adressShopMap;
    mapping(uint256 => Coms[]) private shopCommMap;
    mapping(string => address) private loginMap;

    constructor() {
        address[] memory empty;
        shopMap[1] = Shop(1, "Dmitrov", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 1000, empty);
        adressShopMap[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 1;
        shopMap[2] = Shop(2, "Kaluga", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 900, empty);
        shopMap[3] = Shop(3, "Moscow", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 1050, empty);
        shopMap[4] = Shop(4, "Ryazan", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 700, empty);
        shopMap[5] = Shop(5, "Samara", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 2000, empty);
        shopMap[6] = Shop(6, "Saint-Petersburg", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 2300, empty);
        shopMap[7] = Shop(7, "Taganrog", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0, empty);
        shopMap[8] = Shop(8, "Tomsk", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 780, empty);
        shopMap[9] = Shop(9, "Habarovsk", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 1500, empty);
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

    function returnRequest() public view returns(Request[] memory){
        return requests;
    }

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

    function addAnswer(uint256 _parent, string memory text) public {

    }

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
