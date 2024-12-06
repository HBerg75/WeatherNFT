// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Weather.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";


// Contrat receveur ERC721 fictif pour les tests
contract ERC721ReceiverMock is IERC721Receiver {
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}

contract WeatherNFTTest is Test {
    WeatherNFT weatherNFT;
    ERC721ReceiverMock receiver;

    function setUp() public {
        // Déploie une instance du contrat WeatherNFT et un receveur compatible
        weatherNFT = new WeatherNFT();
        receiver = new ERC721ReceiverMock();
    }

    function testMintWeatherNFT() public {
        // Adresse du receveur fictif
        address recipient = address(receiver);

        // Mint un NFT vers le receveur
        vm.prank(recipient);
        uint256 tokenId = weatherNFT.mintWeatherNFT();

        // Vérifie que le NFT est minté avec succès
        assertEq(tokenId, 0); // Le premier NFT a l'ID 0
        assertEq(weatherNFT.ownerOf(tokenId), recipient);
    }

    function testUpdateWeatherData() public {
        // Adresse du receveur fictif
        address recipient = address(receiver);

        // Mint un NFT vers le receveur
        vm.prank(recipient);
        uint256 tokenId = weatherNFT.mintWeatherNFT();

        // Met à jour les données météorologiques du NFT
        vm.prank(address(this)); // Simule l'appel depuis le propriétaire
        weatherNFT.updateWeatherData(tokenId, 25, 60, 15, "https://example.com/weather.jpg");

        // Récupère les données mises à jour
        WeatherNFT.WeatherData memory data = weatherNFT.getWeatherData(tokenId);

        // Vérifie que les données sont mises à jour correctement
        assertEq(data.temperature, 25);
        assertEq(data.humidity, 60);
        assertEq(data.windSpeed, 15);
        assertEq(data.weatherImage, "https://example.com/weather.jpg");
    }
}
