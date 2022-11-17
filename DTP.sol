//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DPS{
    struct User{
        string login;
        uint256 role; // 1 - водитель 2 - дпс 3 - страховка 4 - банк
        address wallet;
        uint256 balance;
        string fullname;
        driverLic license;
        uint256 startYear;
        uint256 DTP;
        uint256 tickets;
        uint256 insurance;
        
    }

    struct Auto{
        string category;
        uint256 price;
        uint256 lifetime; 
    }

    struct driverLic{
        string num;
        string lifetime;
        string category;
    }

    address bank = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address insurance = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    uint256 deploy = block.timestamp;

    mapping(string => address) public loginMap;
    mapping(address => User) public userMap;
    mapping(address => string) public passwordMap;
    mapping(address => Auto) public userAutoMap;
    mapping(string => address) public userLicenseMap;

    modifier officerOnly() {
        require(userMap[msg.sender].role == 2, "You are not officer");
        _;
    }

    modifier driverOrOfficer(){
        require(userMap[msg.sender].role == 2 || userMap[msg.sender].role == 1, "You are not officer or driver");
        _;
    }

    function register(string memory _login, string memory _password, string memory _fullname, uint256 _startYear, uint256 _DTP, uint256 _tickets, uint256 _insurance) public {
        require(loginMap[_login] == address(0), "User already exists");
        loginMap[_login] = msg.sender;
        passwordMap[msg.sender] = _password;
        userMap[msg.sender] = User(_login,1, msg.sender, msg.sender.balance, _fullname, driverLic("","",""), _startYear, _DTP, _tickets, _insurance);
    }

    function auth(string memory _login, string memory _password) public view returns(User memory) {
        require(keccak256(abi.encode(userMap[loginMap[_login]].login)) == keccak256(abi.encode(_login)));
        require(keccak256(abi.encode(passwordMap[loginMap[_login]])) == keccak256(abi.encode(_password)));
        return (userMap[loginMap[_login]]);
    }

    function addDriverLic(string memory _num, string memory _lifetime, string memory _category) public driverOrOfficer {
        if(keccak256(abi.encode(_num)) == keccak256(abi.encode("000"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("A")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("11.01.2021")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("111"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("B")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("12.05.2025")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("222"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("C")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("09.09.2020")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("333"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("A")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("13.02.2027")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }
        else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("444"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("B")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("10.09.2020")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }
        else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("555"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("C")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("24.06.2029")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }
        else if(keccak256(abi.encode(_num)) == keccak256(abi.encode("666"))){
            require(keccak256(abi.encode(_category)) == keccak256(abi.encode("A")) && keccak256(abi.encode(_lifetime)) == keccak256(abi.encode("31.03.2030")), "Wrong data");
            userMap[msg.sender].license = driverLic(_num, _lifetime, _category);
        }
    }

    function sendAutoReg(string memory _category, uint256 _price, uint256 _lifetime) public driverOrOfficer {
        require(keccak256(abi.encode(_category)) == keccak256(abi.encode(userMap[msg.sender].license.category)), "Wrong category");
        userAutoMap[msg.sender] = Auto(_category, _price, _lifetime);
    }

    // function extensionLicense() public {
    //     require(userMap[msg.sender].tickets == 0, "Not all tickets has been paid");

    // }

    function payTicket() public payable driverOrOfficer {
        if(block.timestamp < deploy + 25 seconds){
            require(msg.value >= 5*userMap[msg.sender].tickets);
            payable(bank).transfer(msg.value);
        }else{
            require(msg.value >= 10*userMap[msg.sender].tickets);
            payable(bank).transfer(msg.value);
        }
        userMap[msg.sender].balance = msg.sender.balance;
    }

    function giveTicket(string memory _license) public officerOnly {
        userMap[userLicenseMap[_license]].tickets += 1;
    }

    function registerInsurance() public driverOrOfficer {
        User memory _user = userMap[msg.sender];
        uint256 staj = block.timestamp - _user.startYear; // стаж
        uint256 price = (userAutoMap[msg.sender].price * (1 - userAutoMap[msg.sender].lifetime/10) * 1) / 10 + (2 * _user.tickets + _user.DTP)/10 - 2 * staj/10;
        userMap[msg.sender].insurance = price;
    }

    function approveInsurance(bool _solut) public payable driverOrOfficer{
        if(_solut){
            require(msg.value >= userMap[msg.sender].insurance, "Not enough money");
            payable(insurance).transfer(msg.value);
            userMap[msg.sender].balance = msg.sender.balance;
        }else{
            userMap[msg.sender].insurance = 0;
        }
    }

    function registerDTP(string memory _license) public payable officerOnly{
        userMap[userLicenseMap[_license]].DTP += 1;
        if(userMap[userLicenseMap[_license]].insurance != 0){
            payable(userMap[userLicenseMap[_license]].wallet).transfer(userMap[userLicenseMap[_license]].insurance * 10);
            userMap[userLicenseMap[_license]].balance = userMap[userLicenseMap[_license]].wallet.balance;
        }
    }
}
