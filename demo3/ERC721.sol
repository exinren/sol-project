// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract demo17BDCNFT is ERC721PresetMinterPauserAutoId {
    using Strings for uint256;
    constructor()
        // 注意 baseURI 最后的 /， 
        ERC721PresetMinterPauserAutoId("BDC NFT EXAMPLE", "BDCoin", "ipfs://Qmc1ZtjR1pRqyzbe8fTpnB9NtXiwFeAmePejdkVpHpgtVS/"){}
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        return string(abi.encodePacked(super._baseURI(), tokenId.toString(), ".json"));
    }
}