//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myContract{

    address private owner = msg.sender;
    uint256 private userId = 15;
        
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
        string parent;
        string text;
        uint256 likes;
        uint256 dislikes;
        uint256 point;
    }

    struct Answer{
        uint256 id;
        uint256 parent;
        string userLogin;
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
    mapping(address => string) private userPass;
    mapping(string => address) private loginMap;
    mapping(uint256 => Shop) private shopMap;
    mapping(address => uint256) private addressShopMap;
    mapping(uint256 => Answer[]) public answerComsMap;
    mapping(uint256 => Coms[]) private shopCommMap;
    mapping(string => Coms[]) private userCommMap;
    mapping(string => Answer[]) private userAnswerMap;

    constructor() {
        address[] memory empty;

        shopMap[1] = Shop(1, "Dmitrov", 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, empty);
        addressShopMap[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = 1;
        userMap[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = User(1, "shop1", "shop1", 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 6, 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266.balance, 6, 1 );
        userPass[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = "123";
        loginMap["shop1"] = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

        shopMap[2] = Shop(2, "Kaluga", 0x70997970C51812dc3A010C7d01b50e0d17dc79C8, empty);
        addressShopMap[0x70997970C51812dc3A010C7d01b50e0d17dc79C8] = 2;
        userMap[0x70997970C51812dc3A010C7d01b50e0d17dc79C8] = User(2, "shop2", "shop2", 0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 6, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8.balance, 6, 2 );
        userPass[0x70997970C51812dc3A010C7d01b50e0d17dc79C8] = "123";
        loginMap["shop2"] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        shopMap[3] = Shop(3, "Moscow", 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, empty);
        addressShopMap[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = 3;
        userMap[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = User(3, "shop3", "shop3", 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 6, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC.balance, 6, 3 );
        userPass[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = "123";
        loginMap["shop3"] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

        shopMap[4] = Shop(4, "Ryazan", 0x90F79bf6EB2c4f870365E785982E1f101E93b906, empty);
        addressShopMap[0x90F79bf6EB2c4f870365E785982E1f101E93b906] = 4;
        userMap[0x90F79bf6EB2c4f870365E785982E1f101E93b906] = User(4, "shop4", "shop4", 0x90F79bf6EB2c4f870365E785982E1f101E93b906, 6, 0x90F79bf6EB2c4f870365E785982E1f101E93b906.balance, 6, 4 );
        userPass[0x90F79bf6EB2c4f870365E785982E1f101E93b906] = "123";
        loginMap["shop4"] = 0x90F79bf6EB2c4f870365E785982E1f101E93b906;

        shopMap[5] = Shop(5, "Samara", 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65, empty);
        addressShopMap[0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65] = 5;
        userMap[0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65] = User(5, "shop5", "shop5", 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65, 6, 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65.balance, 6, 5 );
        userPass[0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65] = "123";
        loginMap["shop5"] = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65;

        shopMap[6] = Shop(6, "Saint-Petersburg", 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, empty);
        addressShopMap[0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc] = 6;
        userMap[0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc] = User(6, "shop6", "shop6", 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, 6, 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc.balance, 6, 6 );
        userPass[0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc] = "123";
        loginMap["shop6"] = 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc;

        shopMap[7] = Shop(7, "Taganrog", 0x976EA74026E726554dB657fA54763abd0C3a0aa9, empty);
        addressShopMap[0x976EA74026E726554dB657fA54763abd0C3a0aa9] = 7;
        userMap[0x976EA74026E726554dB657fA54763abd0C3a0aa9] = User(7, "shop7", "shop7", 0x976EA74026E726554dB657fA54763abd0C3a0aa9, 6, 0x976EA74026E726554dB657fA54763abd0C3a0aa9.balance, 6, 7 );
        userPass[0x976EA74026E726554dB657fA54763abd0C3a0aa9] = "123";
        loginMap["shop7"] = 0x976EA74026E726554dB657fA54763abd0C3a0aa9;

        shopMap[8] = Shop(8, "Tomsk", 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, empty);
        addressShopMap[0x14dC79964da2C08b23698B3D3cc7Ca32193d9955] = 8;
        userMap[0x14dC79964da2C08b23698B3D3cc7Ca32193d9955] = User(8, "shop8", "shop8", 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 6, 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955.balance, 6, 8 );
        userPass[0x14dC79964da2C08b23698B3D3cc7Ca32193d9955] = "123";
        loginMap["shop8"] = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955;

        shopMap[9] = Shop(9, "Habarovsk", 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, empty);
        addressShopMap[0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f] = 9;
        userMap[0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f] = User(9, "shop9", "shop9", 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 6, 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f.balance, 6, 9 );
        userPass[0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f] = "123";
        loginMap["shop9"] = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f;
        
        userMap[0xa0Ee7A142d267C1f36714E4a8F75612F20a79720] = User(10, "bank", "Bank", 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720, 5, 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720.balance, 5, 0);
        userPass[0xa0Ee7A142d267C1f36714E4a8F75612F20a79720] = "123";
        loginMap["bank"] = 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720;
        userMap[0xBcd4042DE499D14e55001CcbB24a551F3b954096] = User(11, "goldfish", "Gold Fish", 0xBcd4042DE499D14e55001CcbB24a551F3b954096, 4, 0xBcd4042DE499D14e55001CcbB24a551F3b954096.balance, 4, 0);
        userPass[0xBcd4042DE499D14e55001CcbB24a551F3b954096] = "123";
        loginMap["goldfish"] = 0xBcd4042DE499D14e55001CcbB24a551F3b954096;
        userMap[0x71bE63f3384f5fb98995898A86B02Fb2426c5788] = User(12, "ivan", "Ivanov Ivan Ivanovich", 0x71bE63f3384f5fb98995898A86B02Fb2426c5788, 3, 0x71bE63f3384f5fb98995898A86B02Fb2426c5788.balance, 3, 0);
        userPass[0x71bE63f3384f5fb98995898A86B02Fb2426c5788] = "123";
        loginMap["ivan"] = 0x71bE63f3384f5fb98995898A86B02Fb2426c5788;

        userMap[0xFABB0ac9d68B0B445fB7357272Ff202C5651694a] = User(13, "semen", "Semenov Semen Semenovich", 0xFABB0ac9d68B0B445fB7357272Ff202C5651694a, 2, 0xFABB0ac9d68B0B445fB7357272Ff202C5651694a.balance, 2, 1);
        userPass[0xFABB0ac9d68B0B445fB7357272Ff202C5651694a] = "123";
        loginMap["semen"] = 0xFABB0ac9d68B0B445fB7357272Ff202C5651694a;
        userMap[0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec] = User(14, "petr", "Petrov Petr Petrovich", 0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec, 1, 0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec.balance, 1, 0);
        userPass[0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec] = "123";
        loginMap["petr"] = 0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec;
        admins.push("ivan");
        shopMap[1].employees.push(0xFABB0ac9d68B0B445fB7357272Ff202C5651694a);

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
        loginMap[_login] = msg.sender;
    }

    function auth(string memory _login, string memory _password) public view returns(User memory, Coms[] memory, Answer[] memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)), "Wrong pair of login and password");
        require(keccak256(abi.encode(userPass[loginMap[_login]])) == keccak256(abi.encode(_password)), "Wrong pair of login and password");
        return (userMap[loginMap[_login]], userCommMap[_login], userAnswerMap[_login]);
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
        uint256 id = requests.length;
        requests.push(Request(id, _shopId, msg.sender));
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
        uint256 id = shops.length;
        address[] memory empty;
        shopMap[id] = Shop(id, _city, _shopAddress, empty);
        addressShopMap[_shopAddress] = id;
        userMap[_shopAddress].role = 6;
        userMap[_shopAddress].tempRole = 6;
        userMap[_shopAddress].shopId = id;
        shops.push(shopMap[id]); 
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
        uint256 _id = shopCommMap[_shopId].length+1;
        shopCommMap[_shopId].push(Coms(_id,userMap[msg.sender].login, _text, 0, 0, _point));
        userCommMap[userMap[msg.sender].login].push(Coms(_id,userMap[msg.sender].login, _text, 0, 0, _point));
    }

    function addAnswer(uint256 _parent, uint256 _shopId, string memory _text) public {
        require((userMap[msg.sender].shopId == _shopId ) || (userMap[msg.sender].role == 1), "You are not buyer or seller of this shop");
        uint256 _id = answerComsMap[_parent].length+1;
        answerComsMap[_parent].push(Answer(_id,_parent, userMap[msg.sender].login, _text, 0, 0));
        userAnswerMap[userMap[msg.sender].login].push(Answer(_id,_parent, userMap[msg.sender].login, _text, 0, 0));
    }

    function backComm(uint256 _shopId) public view returns(Coms[] memory){
        return shopCommMap[_shopId];
    }

    function backAnswers(uint256 _parent) public view returns(Answer[] memory){
        return answerComsMap[_parent];
    }

    function likeComm(uint256 _shopId, uint256 _commId) public isNotGuest {
        _commId--;
        shopCommMap[_shopId][_commId].likes++;
    }

    function dislikeComm(uint256 _shopId, uint256 _commId) public isNotGuest {
        _commId--;
        shopCommMap[_shopId][_commId].dislikes++;
    }

    function likeAnswer(uint256 _parent, uint256 _answerId) isNotGuest public {
        _answerId--;
        answerComsMap[_parent][_answerId].likes++;
    }

    function dislikeAnswer(uint256 _parent, uint256 _answerId) isNotGuest public {
        _answerId--;
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
