// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleSolidity{

    uint256 public favoriteNumber = 5;
    bool favoriteBool = false;
    string favoriteString = "string";
    int256 favoriteInt = -256;
    address favoriteAddress = 0x8791653aa21c1D9b55ADdadf92bEb7c60E42d72C;
    bytes32 favoriteBytes = "cat";

    enum Gender {Male, Female}

    struct Person{
        uint256 number;
        string name;
        Gender gender;
    }


    Person[] public people;

    function setFavoriteNumber(uint256 _fNum) public {
        favoriteNumber = _fNum;
    }

    function setFavoriteAddress() public payable {
        favoriteAddress = msg.sender;
    }

    function getFavoriteAddress() public view returns (address) {
        return favoriteAddress;
    }

    function getFavoriteNumber() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(uint256 _number, string memory _name, uint8 _gender) public {
        Person memory newPerson = Person({number: _number, name: _name, gender: Gender(_gender)});
        people.push(newPerson);
    }

}