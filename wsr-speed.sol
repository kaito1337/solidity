//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract myContract{
    struct User{
        string login;
        string name;
        string adres;
        address wallet;
        uint256 balance;
        uint256 role; // 1 - user, 2 - empl, 3 - admin, 4 - h.admin
        uint256 workAddr;
        bool takeShip;
    }

    struct Ship{
        uint256 id;
        uint256 mail;
        string track;
        address sender;
        address receiver;
        string typ;
        uint256 receiveMail;
        uint256 shipTime;
        uint256 weight;
        uint256 cennost;
        uint256 totalPrice;
        string senderAdres;
        string receiveAdres;
        uint256 date;
    }

    struct Info{
        uint256 id;
        uint256 weight;
        uint256 mail;
        string login;
    }

    struct Mail{
        uint256 id;
        Ship[] ships;
    }

    struct moneyTransfer{
        uint256 id;
        address sender;
        address receiver;
        uint256 total;
        uint256 lifetime;
        bool status;
    }
    uint256 moneyTransferId = 0;
    string[] admins;
    uint256[] indexes = [344000,347900,347901,347902,347903,346770,346771,346772,346773,343760,343761,343762,343763,346780,346781,346782,346783];
    Ship[] ships;


    mapping(string => address) public loginMap;
    mapping(address => string) public passwordMap;
    mapping(address => User) public userMap;
    mapping(uint256 => Ship) public shipMap;
    mapping(uint256 => Info) public infoMap;
    mapping(uint256 => bool) public statusShipMap;
    mapping(uint256 => Ship[]) public mailShipMap;
    mapping(uint256 => uint256) public classShipMap;
    mapping(uint256 => moneyTransfer) public moneyTransferMap;

    constructor(){
        loginMap["ivan"] = 0xe220B3C710d95d3fdFf6FDE7230450BA4edbE2Bb;
        userMap[0xe220B3C710d95d3fdFf6FDE7230450BA4edbE2Bb] = User("ivan", "Ivanov Ivan Ivanovich", "Gatchina", 0xe220B3C710d95d3fdFf6FDE7230450BA4edbE2Bb, 0xe220B3C710d95d3fdFf6FDE7230450BA4edbE2Bb.balance, 4, 0, true);
        passwordMap[0xe220B3C710d95d3fdFf6FDE7230450BA4edbE2Bb] = "123";
        loginMap["semen"] = 0xA17610436443dD2f08c008F4Acf8e29cB65807aa;
        userMap[0xA17610436443dD2f08c008F4Acf8e29cB65807aa] = User("semen", "Semenov Semen Semenovich", "Saint-Petersburg", 0xA17610436443dD2f08c008F4Acf8e29cB65807aa, 0xA17610436443dD2f08c008F4Acf8e29cB65807aa.balance, 3, 0, true);
        passwordMap[0xA17610436443dD2f08c008F4Acf8e29cB65807aa] = "123";
        loginMap["petr"] = 0x632da278f45De08d32874480B59e35E92dd49211;
        userMap[0x632da278f45De08d32874480B59e35E92dd49211] = User("petr", "Petrov Petr Petrovich", "Moscow", 0x632da278f45De08d32874480B59e35E92dd49211, 0x632da278f45De08d32874480B59e35E92dd49211.balance, 2, 344000, true);
        passwordMap[0x632da278f45De08d32874480B59e35E92dd49211] = "123";
        loginMap["anton"] = 0x082b0bc2833FaeEb21478F83ff1803856048d7cf;
        userMap[0x082b0bc2833FaeEb21478F83ff1803856048d7cf] = User("anton", "Antonov Anton Antonovich", "Pskov", 0x082b0bc2833FaeEb21478F83ff1803856048d7cf, 0x082b0bc2833FaeEb21478F83ff1803856048d7cf.balance, 2, 347900, true);
        passwordMap[0x082b0bc2833FaeEb21478F83ff1803856048d7cf] = "123";
        loginMap["yuriy"] = 0x282a8E215C3C91E498bd484c95eDb6345e63C08D;
        userMap[0x282a8E215C3C91E498bd484c95eDb6345e63C08D] = User("yuriy", "Yurev Yuriy Yurevich", "Orel", 0x282a8E215C3C91E498bd484c95eDb6345e63C08D, 0x282a8E215C3C91E498bd484c95eDb6345e63C08D.balance, 1, 0, true);
        passwordMap[0x282a8E215C3C91E498bd484c95eDb6345e63C08D] = "123";
        admins.push("ivan");
        admins.push("semen");
    }

    modifier isHighAdmin(){
        require(userMap[msg.sender].role == 4);
        _;
    }

    modifier isAdmin(){
        require(userMap[msg.sender].role == 3);
        _;
    }

    modifier isEmployer(){
        require(userMap[msg.sender].role == 2);
        _;
    }

    function register(string memory _login, string memory _password, string memory _adres, string memory _name) public {
        require(loginMap[_login] == address(0), "User already exists");
        loginMap[_login] = msg.sender;
        passwordMap[msg.sender] = _password;
        userMap[msg.sender] = User(_login, _name, _adres, msg.sender, msg.sender.balance, 1, 0, true);
    }

    function auth(string memory _login, string memory _password) public returns (User memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)), "Wrong credentials");
        require(keccak256(abi.encode(passwordMap[loginMap[_login]])) == keccak256(abi.encode(_password)), "Wrong credentials");
        userMap[loginMap[_login]].balance = loginMap[_login].balance;
        return userMap[loginMap[_login]];
    }

    function addAdmin(string memory _login) public isHighAdmin {
        uint256 counter = 0;
        userMap[loginMap[_login]].role = 3;
        for(uint256 i = 0; i<admins.length; i++){
            if(keccak256(abi.encode(admins[i])) == keccak256(abi.encode(_login))){
                counter++;
            }
        }
        if(counter == 0){
            admins.push(_login);
        }
    }

    function removeAdmin(string memory _login) public isHighAdmin {
        userMap[loginMap[_login]].role = 1;
        for(uint256 i = 0; i<admins.length; i++){
            if(keccak256(abi.encode(admins[i])) == keccak256(abi.encode(_login))){
                delete admins[i];
            }
        }
    }

    function changeSurname(string memory _name) public {
        userMap[msg.sender].name = _name;
    }

    function changeAdres(string memory _adres) public {
        userMap[msg.sender].adres = _adres;
    }

    function cancelTakingShips() public {
        userMap[msg.sender].takeShip = false;
    }

    function addShip(uint256 _mail, uint256 _receiveMail, address _receiver, string memory _typ, uint256 _clas, uint256 _weight, string memory _receiveAdres) public{
        require(userMap[_receiver].takeShip, "User not accepting ships or not registered");
        require(_weight <= 10, "Weight is much");
        require(_clas <= 3 && _clas >= 0, "Invalid class");
        uint256 counter = 0;
        for(uint256 i = 0; i < indexes.length; i++){
            if(indexes[i] == _mail){
                uint256 shipTime;
                uint256 shipPrice;
                uint256 id = ships.length;
                uint256 id2 = mailShipMap[_mail].length + 1;
                if(_clas == 1){
                    shipTime = 5;
                    shipPrice = _weight / 2;
                }else if(_clas == 2){
                    shipTime = 10;
                    shipPrice = (_weight * 3) / 10;
                }else{
                    _clas = 3;
                    shipTime = 15;
                    shipPrice = _weight / 10;
                }
                counter++;
                shipMap[id] = Ship(id, _mail, "", msg.sender, _receiver, _typ, _receiveMail, shipTime, _weight, 0, 0, userMap[msg.sender].adres, _receiveAdres, block.timestamp);
                mailShipMap[_mail].push(Ship(id2, _mail, "", msg.sender, _receiver, _typ, _receiveMail, shipTime, _weight, 0, 0, userMap[msg.sender].adres, _receiveAdres, block.timestamp));
                ships.push(Ship(id2, _mail, "", msg.sender, _receiver, _typ, _receiveMail, shipTime, _weight, 0, 0, userMap[msg.sender].adres, _receiveAdres, block.timestamp));
                classShipMap[id] = _clas;
                infoMap[id] = Info(id, _weight, _mail, "");
                getTotal(id, _mail, id2, shipPrice);
            }
        }
        if(counter == 0){
            revert("Wrong mail index");
        }
    }

    function payForShip(uint256 _id) public payable{
        require(msg.value >= shipMap[_id].totalPrice * (10**18), "Not enough money");
        statusShipMap[_id] = true;
    }

    function changeShipCenn(uint256 _id, uint256 _cennost) public isEmployer{
        shipMap[_id].cennost = _cennost;
        ships[_id].cennost = _cennost;
        shipMap[_id].totalPrice -= (shipMap[_id].cennost * 1/10);
        ships[_id].totalPrice -= (shipMap[_id].cennost * 1/10);
        shipMap[_id].totalPrice += (_cennost * 1/10);
        ships[_id].totalPrice += (_cennost * 1/10);
        mailShipMap[ships[_id].mail][ships[_id].id].totalPrice -= (mailShipMap[ships[_id].mail][ships[_id].id].cennost * 1/10);
        mailShipMap[ships[_id].mail][ships[_id].id].totalPrice += (_cennost * 1/10);
    }

    function returnClass(uint256 _id) public view returns(uint256){
        return classShipMap[_id];
    }

    function getHistory() public view returns(Ship[] memory){
        return ships;
    }

    function getAdmins() public view returns(string[] memory){
        return admins;
    }

    function sendTransfer(address _receiver, uint256 _lifetime) public payable {
        moneyTransferMap[moneyTransferId++] = moneyTransfer(moneyTransferId, msg.sender, _receiver, msg.value, (_lifetime * 5 seconds + block.timestamp), false);
        userMap[msg.sender].balance = msg.sender.balance;
    }

    function acceptTransfer(uint256 _id, uint256 _value) public {
        require(moneyTransferMap[_id].receiver == msg.sender, "You are not receiver");
        require(!moneyTransferMap[_id].status, "User already taked transfer");
        require(moneyTransferMap[_id].lifetime > block.timestamp, "Time is out");
        payable(msg.sender).transfer(_value*10**18);
        userMap[msg.sender].balance = msg.sender.balance;
    }

    function cancelTransfer(uint256 _id) public {
        require(moneyTransferMap[_id].sender == msg.sender || moneyTransferMap[_id].receiver == msg.sender);
        require(!moneyTransferMap[_id].status, "User already taked transfer");
        payable(msg.sender).transfer(moneyTransferMap[_id].total);
        userMap[msg.sender].balance = msg.sender.balance;
        delete moneyTransferMap[_id];
    }

    function addEmpl(string memory _login, uint256 _mail) public isAdmin{
        uint256 counter = 0;
        for(uint256 i = 0; i < indexes.length; i++){
            if(indexes[i] == _mail){
                userMap[loginMap[_login]].workAddr = _mail;
                counter++;
            }
        }
        if(counter == 0){
            revert("Mail index doesn't exists");
        }
    }

    function removeEmpl(string memory _login, uint256 _mail) public isAdmin{
        uint256 counter = 0;
        for(uint256 i = 0; i < indexes.length; i++){
            if(indexes[i] == _mail){
                userMap[loginMap[_login]].workAddr = 0;
                counter++;
            }
        }
        if(counter == 0){
            revert("Mail index doesn't exists");
        }
    }

    function changeWorkAddr(string memory _login, uint256 _workAddr ) public isAdmin {
        uint256 counter = 0;
        for(uint256 i = 0; i < indexes.length; i++){
            if(indexes[i] == _workAddr){
                userMap[loginMap[_login]].workAddr = _workAddr;
                counter++;
            }
        }
        if(counter == 0){
            revert("Mail index doesn't exists");
        }
    }

    function changeInfo(uint256 _id, uint256 _weight) public isEmployer{
        infoMap[_id] = Info(_id, _weight, userMap[msg.sender].workAddr, userMap[msg.sender].login);
    }

    function refundShip(uint256 _id) public {
        require(block.timestamp > shipMap[_id].shipTime * 5 seconds + shipMap[_id].date, "Vse norm" );
            if(classShipMap[_id] == 1){
                payable(msg.sender).transfer(shipMap[_id].totalPrice * 10**18);
            }else if(classShipMap[_id] == 2 ){
                payable(msg.sender).transfer((shipMap[_id].totalPrice/2 + shipMap[_id].cennost) * 10**18);
            }else{
                payable(msg.sender).transfer(shipMap[_id].cennost * 10**18);
            }
    }

    function returnOutWeight(uint256 _id) public view returns(uint256){
        return infoMap[_id].weight;
    }

    function takeShip(uint256 _id, bool _solut) public {
        require((infoMap[_id].weight - shipMap[_id].weight) / shipMap[_id].weight * 100 > 15 || (infoMap[_id].weight - shipMap[_id].weight) / shipMap[_id].weight * 100 < 15, "Weight normal" );
        if(!_solut){
            payable(msg.sender).transfer(shipMap[_id].totalPrice * 10 **18);
        }
    }


    function getTotal(uint256 _idTotal, uint256 _shipIdxMail, uint256 _idMail, uint256 _shipPrice) private {
        Ship memory _ship = shipMap[_idTotal];
        shipMap[_idTotal].totalPrice = _shipPrice * _ship.weight + (_ship.cennost / 10);
        mailShipMap[_shipIdxMail][_idMail-1].totalPrice = _shipPrice * _ship.weight + (_ship.cennost / 10);
        ships[_idTotal].totalPrice = _shipPrice * _ship.weight + (_ship.cennost / 10);
    }
}
