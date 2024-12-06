// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Weather.sol";

contract DeployWeatherNFT is Script {
    function run() external {
        // Chargez la clé privée
        vm.startBroadcast();

        // Déployez le contrat
        WeatherNFT weatherNFT = new WeatherNFT();

        vm.stopBroadcast();

        console.log(unicode"WeatherNFT deployé à l'adresse :", address(weatherNFT));
    }
}
