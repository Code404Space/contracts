// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./imports/ERC404.sol";

contract Code404 is ERC404 {
    string public baseTokenURI;
    string public dataURI;

    constructor(
        address _governor
    ) ERC404("Code 404", "CODE404", 18, 10000, _governor) {
        balanceOf[_governor] = totalSupply;
        setWhitelist(_governor, true);
    }

    function setTokenURI(string memory _tokenURI) external onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setDataURI(string memory _dataURI) external onlyOwner {
        dataURI = _dataURI;
    }

    function setNameSymbol(
        string memory _name,
        string memory _symbol
    ) external onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "Code404 #', Strings.toString(id)),
                    '","description":"Revolution is coming! Know what the future holds for you.","external_url":"https://code404.space","image":"'
                ),
                string.concat(dataURI, "box.png")
            );
            string memory jsonPostImage = string.concat(
                '","attributes":[{"trait_type":"Mysterious Box","value":"Surprize"}]}'
            );

            return
                string.concat(
                    "data:application/json;utf8,",
                    string.concat(jsonPreImage, jsonPostImage)
                );
        }
    }
}
