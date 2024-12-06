// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Contrat pour des NFTs dynamiques représentant des données météorologiques
contract WeatherNFT is ERC721, Ownable {
    uint256 public tokenCounter; // Compteur pour les identifiants de tokens

    // Structure pour représenter les données météorologiques
    struct WeatherData {
        int256 temperature;       // Température actuelle
        uint256 humidity;         // Humidité en pourcentage
        uint256 windSpeed;        // Vitesse du vent en km/h
        string weatherImage;      // URI de l'image météo
        uint256 timestamp;        // Horodatage de la dernière mise à jour
    }

    // Mapping pour associer chaque tokenId à ses données météorologiques
    mapping(uint256 => WeatherData) private weatherInfo;

    // Événements pour notifier des actions importantes
    event TokenMinted(uint256 indexed tokenId, address indexed owner); // Quand un NFT est créé
    event WeatherDataUpdated(uint256 indexed tokenId, WeatherData updatedData); // Quand les données météo sont mises à jour

    // Constructeur : initialise le contrat avec le propriétaire et configure le nom/symbole des NFTs
    constructor() ERC721("WeatherNFT", "WNFT") Ownable(msg.sender) {
        tokenCounter = 0; // Initialise le compteur de tokens
    }

    /**
     * @dev Mint un nouveau NFT associé à des données météo par défaut.
     * Accessible à tous les utilisateurs.
     */
    function mintWeatherNFT() external returns (uint256) {
        uint256 tokenId = tokenCounter; // Nouvel identifiant unique
        _safeMint(msg.sender, tokenId); // Mint le NFT pour l'utilisateur appelant

        // Initialise les données météorologiques avec des valeurs par défaut
        weatherInfo[tokenId] = WeatherData({
            temperature: 0,
            humidity: 0,
            windSpeed: 0,
            weatherImage: "",
            timestamp: block.timestamp
        });

        tokenCounter++; // Incrémente le compteur de tokens

        emit TokenMinted(tokenId, msg.sender); // Émet un événement indiquant le mint du NFT
        return tokenId;
    }

    /**
     * @dev Met à jour les données météorologiques d'un NFT existant.
     * Seul le propriétaire du contrat peut appeler cette fonction.
     * @param tokenId L'identifiant du NFT à mettre à jour.
     * @param temperature La nouvelle température à associer.
     * @param humidity Le nouveau taux d'humidité à associer.
     * @param windSpeed La nouvelle vitesse du vent à associer.
     * @param weatherImage L'URI de l'image représentant les conditions météorologiques.
     */
    function updateWeatherData(
        uint256 tokenId,
        int256 temperature,
        uint256 humidity,
        uint256 windSpeed,
        string memory weatherImage
    ) external onlyOwner {
        require(tokenExists(tokenId), "Le token n'existe pas"); // Vérifie que le NFT existe

        // Met à jour les données météorologiques associées au NFT
        weatherInfo[tokenId] = WeatherData({
            temperature: temperature,
            humidity: humidity,
            windSpeed: windSpeed,
            weatherImage: weatherImage,
            timestamp: block.timestamp // Enregistre l'horodatage actuel
        });

        emit WeatherDataUpdated(tokenId, weatherInfo[tokenId]); // Émet un événement pour notifier la mise à jour
    }

    /**
     * @dev Récupère les données météorologiques associées à un NFT spécifique.
     * @param tokenId L'identifiant du NFT.
     * @return Les données météorologiques associées au NFT.
     */
    function getWeatherData(uint256 tokenId) external view returns (WeatherData memory) {
        require(tokenExists(tokenId), "Le token n'existe pas"); // Vérifie que le NFT existe
        return weatherInfo[tokenId]; // Retourne les données météorologiques
    }

    /**
     * @dev Vérifie si un NFT avec l'identifiant donné existe.
     * @param tokenId L'identifiant du NFT à vérifier.
     * @return `true` si le NFT existe, sinon `false`.
     */
    function tokenExists(uint256 tokenId) public view returns (bool) {
        return ownerOf(tokenId) != address(0); // Vérifie si un propriétaire existe
    }
}
