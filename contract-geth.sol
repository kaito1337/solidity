//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myContract{

    address private owner = msg.sender;
    uint256 private shopId = 9;
    uint256 private userId = 15;
    uint256 private requestId = 0;
    struct User{
        uint256 id;
        string login;
        string name;
        address wallet;
        uint256 role; // 1 - покупатель, 2 - продавец, 3 - админ, 4 - поставщик, 5 - банк, 6 - магаз
        uint256 balance;
        uint256 tempRole;
        uint256 shopId;
    }

    struct Shop{
        uint256 id;
        string city;
        address wallet;
        address[] employees;
    }

    struct Coms{
        uint256 id;
        uint256 parent;
        string text;
        uint256 likes;
        uint256 dislikes;
        uint256 point;
    }

    struct Answer{
        uint256 id;
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

    Request[] requests;
    uint256[] dolgi;
    string[] admins;
    Shop[] shops;

    mapping(address => User) public userMap;
    mapping(uint256 => address) private idUserMap;
    mapping(address => string) private userPass;
    mapping(string => address) private loginMap;
    mapping(uint256 => Shop) private shopMap;
    mapping(address => uint256) private addressShopMap;
    mapping(uint256 => Answer[]) public answerComsMap;
    mapping(uint256 => Coms[]) private shopCommMap;
    mapping(uint256 => Coms[]) private userCommMap;
    mapping(uint256 => Answer[]) private userAnswerMap;

    constructor() {
        address[] memory empty;

        shopMap[1] = Shop(1, "Dmitrov", 0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5, empty);
        addressShopMap[0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5] = 1;
        userMap[0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5] = User(1, "shop1", "shop1", 0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5, 6, 0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5.balance, 6, 1 );
        userPass[0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5] = "123";
        loginMap["shop1"] = 0x6941Cc84FeBa95693f02d9dDD601aF7a87286dc5;

        shopMap[2] = Shop(2, "Kaluga", 0x120633837bF06006906E5446C1D40b3Fa9F69fc9, empty);
        addressShopMap[0x120633837bF06006906E5446C1D40b3Fa9F69fc9] = 2;
        userMap[0x120633837bF06006906E5446C1D40b3Fa9F69fc9] = User(2, "shop2", "shop2", 0x120633837bF06006906E5446C1D40b3Fa9F69fc9, 6, 0x120633837bF06006906E5446C1D40b3Fa9F69fc9.balance, 6, 2 );
        userPass[0x120633837bF06006906E5446C1D40b3Fa9F69fc9] = "123";
        loginMap["shop2"] = 0x120633837bF06006906E5446C1D40b3Fa9F69fc9;

        shopMap[3] = Shop(3, "Moscow", 0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83, empty);
        addressShopMap[0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83] = 3;
        userMap[0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83] = User(3, "shop3", "shop3", 0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83, 6, 0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83.balance, 6, 3 );
        userPass[0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83] = "123";
        loginMap["shop3"] = 0xE347b0bEdaC7C6A169eEDBCC3060002D5A304d83;

        shopMap[4] = Shop(4, "Ryazan", 0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED, empty);
        addressShopMap[0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED] = 4;
        userMap[0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED] = User(4, "shop4", "shop4", 0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED, 6, 0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED.balance, 6, 4 );
        userPass[0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED] = "123";
        loginMap["shop4"] = 0xdb7D80FD92Fc7440E12D01292Cb20934230Cd9ED;

        shopMap[5] = Shop(5, "Samara", 0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477, empty);
        addressShopMap[0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477] = 5;
        userMap[0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477] = User(5, "shop5", "shop5", 0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477, 6, 0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477.balance, 6, 5 );
        userPass[0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477] = "123";
        loginMap["shop5"] = 0x394CAA0Dd589BCe60Ce9d6c20489Be3119a36477;

        shopMap[6] = Shop(6, "Saint-Petersburg", 0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D, empty);
        addressShopMap[0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D] = 6;
        userMap[0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D] = User(6, "shop6", "shop6", 0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D, 6, 0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D.balance, 6, 6 );
        userPass[0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D] = "123";
        loginMap["shop6"] = 0xfFa5165e6BeB49B54c5FdE625168bc46A2D27f3D;

        shopMap[7] = Shop(7, "Taganrog", 0xFf54975884064A7fF8De55305e00609d46B11128, empty);
        addressShopMap[0xFf54975884064A7fF8De55305e00609d46B11128] = 7;
        userMap[0xFf54975884064A7fF8De55305e00609d46B11128] = User(7, "shop7", "shop7", 0xFf54975884064A7fF8De55305e00609d46B11128, 6, 0xFf54975884064A7fF8De55305e00609d46B11128.balance, 6, 7 );
        userPass[0xFf54975884064A7fF8De55305e00609d46B11128] = "123";
        loginMap["shop7"] = 0xFf54975884064A7fF8De55305e00609d46B11128;

        shopMap[8] = Shop(8, "Tomsk", 0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7, empty);
        addressShopMap[0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7] = 8;
        userMap[0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7] = User(8, "shop8", "shop8", 0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7, 6, 0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7.balance, 6, 8 );
        userPass[0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7] = "123";
        loginMap["shop8"] = 0x17525B8B19D6b3068b07a5Cb777423b7D491C7F7;

        shopMap[9] = Shop(9, "Habarovsk", 0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4, empty);
        addressShopMap[0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4] = 9;
        userMap[0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4] = User(9, "shop9", "shop9", 0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4, 6, 0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4.balance, 6, 9 );
        userPass[0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4] = "123";
        loginMap["shop9"] = 0x10837A646FeD756C36f6c47F28649aCEb1Cf6aC4;
        
        userMap[0x75F43Cb032f2D932C1c8bD23062A9b41A03Be7C2] = User(10, "bank", "Bank", 0x75F43Cb032f2D932C1c8bD23062A9b41A03Be7C2, 5, 0x75F43Cb032f2D932C1c8bD23062A9b41A03Be7C2.balance, 5, 0);
        userPass[0x75F43Cb032f2D932C1c8bD23062A9b41A03Be7C2] = "123";
        loginMap["bank"] = 0x75F43Cb032f2D932C1c8bD23062A9b41A03Be7C2;
        userMap[0xe7aE610A9ed8E984E92559C162607b8CCFdC73CA] = User(11, "goldfish", "Gold Fish", 0xe7aE610A9ed8E984E92559C162607b8CCFdC73CA, 4, 0xe7aE610A9ed8E984E92559C162607b8CCFdC73CA.balance, 4, 0);
        userPass[0xe7aE610A9ed8E984E92559C162607b8CCFdC73CA] = "123";
        loginMap["goldfish"] = 0xe7aE610A9ed8E984E92559C162607b8CCFdC73CA;
        userMap[0xe61ebaAa099E80E73976293eB9A66E3DABA20322] = User(12, "ivan", "Ivanov Ivan Ivanovich", 0xe61ebaAa099E80E73976293eB9A66E3DABA20322, 3, 0xe61ebaAa099E80E73976293eB9A66E3DABA20322.balance, 3, 0);
        userPass[0xe61ebaAa099E80E73976293eB9A66E3DABA20322] = "123";
        loginMap["ivan"] = 0xe61ebaAa099E80E73976293eB9A66E3DABA20322;
        userMap[0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15] = User(13, "semen", "Semenov Semen Semenovich", 0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15, 2, 0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15.balance, 2, 1);
        userPass[0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15] = "123";
        loginMap["semen"] = 0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15;
        userMap[0xA4babd4e0ecB7Cb53D7dDA240F7a215CF25f9449] = User(14, "petr", "Petrov Petr Petrovich", 0xA4babd4e0ecB7Cb53D7dDA240F7a215CF25f9449, 1, 0xA4babd4e0ecB7Cb53D7dDA240F7a215CF25f9449.balance, 1, 0);
        userPass[0xA4babd4e0ecB7Cb53D7dDA240F7a215CF25f9449] = "123";
        loginMap["petr"] = 0xA4babd4e0ecB7Cb53D7dDA240F7a215CF25f9449;
        admins.push("ivan");
        shopMap[1].employees.push(0xF1035cf4D5BBB0C81C0C7F4E7291ED35f6bE2A15);

        shops.push(shopMap[1]);
        shops.push(shopMap[2]);
        shops.push(shopMap[3]);
        shops.push(shopMap[4]);
        shops.push(shopMap[5]);
        shops.push(shopMap[6]);
        shops.push(shopMap[7]);
        shops.push(shopMap[8]);
        shops.push(shopMap[9]);
    }
    modifier isNotGuest(){
        require(userMap[msg.sender].role >= 1, "You are guest");
        _;
    }

    modifier isAdmin(){
        require(userMap[msg.sender].role == 3 || owner == msg.sender, "You are not admin");
        _;
    }

    modifier isBank(){
        require(userMap[msg.sender].role == 5, "You are not bank");
        _;
    }

    modifier isSeller(){
        require(userMap[msg.sender].role == 2 || userMap[msg.sender].tempRole == 2, "You are not seller");
        _;
    }

    modifier isBuyer(){
        require(userMap[msg.sender].role == 1 || userMap[msg.sender].tempRole == 1, "You are not buyer");
        _;
    }

    modifier isSellerOrBuyer(){
        require(userMap[msg.sender].role == 2 || userMap[msg.sender].role == 1 || userMap[msg.sender].tempRole == 1, "You are not buyer/seller");
        _;
    }

    modifier isShop(){
        require(userMap[msg.sender].role == 6, "You are not shop");
        _;
    }

    function register(string memory _login, string memory _name, string memory _password) public {
        require(loginMap[_login] == address(0), "User already created" );
        userMap[msg.sender] = User(userId++,_login,_name,msg.sender, 1, address(msg.sender).balance, 1, 0);
        userPass[msg.sender] = _password;
        idUserMap[userId] = msg.sender;
        loginMap[_login] = msg.sender;
    }

    function auth(string memory _login, string memory _password) public view returns(User memory, Coms[] memory, Answer[] memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)), "Wrong pair of login and password");
        require(keccak256(abi.encode(userPass[loginMap[_login]])) == keccak256(abi.encode(_password)), "Wrong pair of login and password");
        return (userMap[loginMap[_login]], userCommMap[userMap[loginMap[_login]].id], userAnswerMap[userMap[loginMap[_login]].id]);
    }

    function setAdmin(address _address) public isAdmin {
        require(userMap[_address].role == 3, "Already exists");
        userMap[_address].role = 3;
        userMap[_address].tempRole = 3;
        admins.push(userMap[_address].login);
    }

    function returnAdmins() public view isAdmin returns(string[] memory){
        return admins;
    }

    function shopreturn() public view isAdmin returns (Shop[] memory){
        return shops;
    }

    function emplreturn(uint256 _id) external view returns (address[] memory){
        return shopMap[_id].employees;
    }

    function changeRole(address _address, uint256 _role) public isAdmin {
        if(userMap[_address].role == 3){
            userMap[_address].tempRole == _role;
        }else{
            if(_role == 3){
                admins.push(userMap[_address].login);
            }
            userMap[_address].role = _role;
            userMap[_address].tempRole = _role;
        }
    }

    function adminToBuyer() public isAdmin{
        userMap[msg.sender].tempRole = 1;
    }

    function buyerToAdmin() public isAdmin{
        userMap[msg.sender].tempRole = 3;
    }

    function sellerToBuyer() public isSeller{
        userMap[msg.sender].tempRole = 1;
    }

    function buyerToSeller() public isSeller{
        userMap[msg.sender].tempRole = 2;
    }

    function sendRequest(uint256 _shopId) public isSellerOrBuyer{
        requestId++;
        requests.push(Request(requestId, _shopId, msg.sender));
    }

    function takeRequest(uint256 _index, bool _solut) public isAdmin{
        _index--;
        User memory _sender = userMap[requests[_index].userAddress];
        uint256 _shopId = requests[_index].shopId;
        if(_solut){
            if(_sender.role == 1){
                userMap[requests[_index].userAddress].role = 2;
                userMap[requests[_index].userAddress].tempRole = 2;
                userMap[requests[_index].userAddress].shopId = _shopId;                
                shopMap[_shopId].employees.push(_sender.wallet);
                shops[_shopId-1].employees.push(_sender.wallet);
            }
            else{
                userMap[requests[_index].userAddress].role = 1;
                userMap[requests[_index].userAddress].tempRole = 1;
                userMap[requests[_index].userAddress].shopId = 0;
                for(uint256 i = 0; i < shopMap[requests[_index].shopId].employees.length; i++){
                    if(shopMap[_shopId].employees[i] == _sender.wallet){
                        delete shopMap[_shopId].employees[i];
                    }
                }
                for(uint256 i = 0; i<shops[_shopId-1].employees.length; i++){
                    if(_sender.wallet == shops[_shopId-1].employees[i]){
                        delete shops[_shopId-1].employees[i];
                    }
                }
            }
        }
        delete requests[_index];
    }

    function returnRequest() public view isAdmin returns(Request[] memory){
        return requests;
    }

    function addShop(address _shopAddress, string memory _city) public isAdmin {
        shopId++;
        address[] memory empty;
        shopMap[shopId] = Shop(shopId, _city, _shopAddress, empty);
        userMap[_shopAddress].role = 6;
        userMap[_shopAddress].tempRole = 6;
        userMap[_shopAddress].shopId = shopId;
        shops.push(shopMap[shopId]); 
    }

    function deleteShop(uint256 _shopId) public isAdmin {
        for(uint256 i = 0; i<shopMap[_shopId].employees.length; i++){
            userMap[shopMap[_shopId].employees[i]].role = 1;
            userMap[shopMap[_shopId].employees[i]].tempRole = 1;
            userMap[shopMap[_shopId].employees[i]].shopId = 0;
        }
        delete shopMap[_shopId];
        userMap[shopMap[_shopId].wallet].role = 1;
        userMap[shopMap[_shopId].wallet].tempRole = 1;
        delete shops[_shopId-1];
    }

    function addComm(string memory _text, uint256 _shopId, uint256 _point) public isBuyer {
        require(_point <= 10 && _point >= 1, "Point must be in range 1-10");
        uint256 _id = shopCommMap[_shopId].length;
        shopCommMap[_shopId].push(Coms(_id,userMap[msg.sender].id, _text, 0, 0, _point));
        userCommMap[userMap[msg.sender].id].push(Coms(_id,userMap[msg.sender].id, _text, 0, 0, _point));
    }

    function addAnswer(uint256 _parent, uint256 _shopId, string memory _text) public {
        require((userMap[msg.sender].shopId == _shopId ) || (userMap[msg.sender].role == 1), "You are not buyer or seller of this shop");
        uint256 _id = answerComsMap[_parent].length;
        answerComsMap[_parent].push(Answer(_id,userMap[msg.sender].id, _text, 0, 0));
        userAnswerMap[userMap[msg.sender].id].push(Answer(_id,userMap[msg.sender].id, _text, 0, 0));
    }

    function backComm(uint256 _shopId) public view returns(Coms[] memory){
        return shopCommMap[_shopId];
    }

    function backAnswers(uint256 _parent) public view returns(Answer[] memory){
        return answerComsMap[_parent];
    }

    function likeComm(uint256 _shopId, uint256 _commId) public isNotGuest {
        shopCommMap[_shopId][_commId].likes++;
    }

    function dislikeComm(uint256 _shopId, uint256 _commId) public isNotGuest {
        shopCommMap[_shopId][_commId].dislikes++;
    }

    function likeAnswer(uint256 _parent, uint256 _answerId) isNotGuest public {
        answerComsMap[_parent][_answerId].likes++;
    }

    function dislikeAnswer(uint256 _parent, uint256 _answerId) isNotGuest public {
        answerComsMap[_parent][_answerId].dislikes++;
    }

    function requestDolg() public isShop {
       dolgi.push(addressShopMap[msg.sender]);
    }

    function giveDolg(uint256 _index, bool _solut) public payable isBank(){
        if(_solut){
        require(msg.value == 1000 ether, "Invalid value");
        _index++;
        payable(shopMap[dolgi[_index]].wallet).transfer(msg.value);
        userMap[msg.sender].balance -= 1000 ether;
        userMap[shopMap[dolgi[_index]].wallet].balance += 1000 ether;
        delete dolgi[_index];
        } else {
            require(msg.value == 0, "Invalid value");
            delete dolgi[_index];
        }
    }
}
