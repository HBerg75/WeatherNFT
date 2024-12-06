# WeatherNFT

## Description

**WeatherNFT** est un projet de contrat intelligent écrit en Solidity permettant de gérer des NFTs dynamiques associés à des données météorologiques. Ce projet utilise Foundry pour le développement, les tests et le déploiement sur le réseau testnet Avalanche (Fuji).

## Prérequis

Assurez-vous d'avoir les éléments suivants installés sur votre machine :

1. **Foundry** : Suite d'outils pour Solidity. [Guide d'installation](https://book.getfoundry.sh/getting-started/installation).
2. **Node.js et npm** : Pour gérer les dépendances comme OpenZeppelin.
3. **MetaMask** : Pour gérer un portefeuille compatible avec Avalanche Fuji.
4. **Clé API Avalanche** : Une URL RPC pour le testnet Fuji.
5. **Un terminal compatible Unix** : Git Bash ou WSL sur Windows.

## Installation

Clonez le dépôt sur votre machine :

```bash
git clone [<url_du_repository>](https://github.com/HBerg75/WeatherNFT.git)
cd WeatherNFT
```

Installez les dépendances OpenZeppelin :

```bash
npm install @openzeppelin/contracts ou npm i
```

## Configuration

1. **Fichier `.env`** : Créez un fichier `.env` à la racine du projet avec le contenu suivant :

   ```env
   PRIVATE_KEY=0xVotreCléPrivée
   AVALANCHE_RPC=https://api.avax-test.network/ext/bc/C/rpc
   ```

   - **PRIVATE_KEY** : La clé privée de votre portefeuille MetaMask.
   - **AVALANCHE_RPC** : L'URL RPC pour le testnet Avalanche Fuji.

2. **Assurez-vous que `.env` est dans le `.gitignore` pour protéger vos informations sensibles.**

## Compilation

Compilez le projet avec Foundry :

```bash
forge build
```

## Tests

Exécutez les tests pour vérifier le fonctionnement du contrat :

```bash
forge test
```

## Déploiement

Pour déployer le contrat sur le testnet Avalanche Fuji, exécutez la commande suivante :

```bash
forge script script/DeployWeather.s.sol:DeployWeatherNFT --rpc-url "$AVALANCHE_RPC" --private-key "$PRIVATE_KEY" --broadcast
```

Notez l'adresse du contrat déployé, qui sera affichée dans la console.

## Interaction avec le contrat

### Utilisation avec Remix

1. Ouvrez [Remix](https://remix.ethereum.org/).
2. Importez le fichier ABI du contrat (`out/WeatherNFT.sol/WeatherNFT.json`).
3. Configurez le réseau Avalanche Fuji dans MetaMask et connectez-vous.
4. Entrez l'adresse du contrat déployé et interagissez avec les fonctions comme `mintWeatherNFT` ou `updateWeatherData`.

### Utilisation avec Foundry

1. Pour exécuter des fonctions comme `mintWeatherNFT` :

   ```bash
   cast send <adresse_du_contrat> "mintWeatherNFT()" --rpc-url "$AVALANCHE_RPC" --private-key "$PRIVATE_KEY"
   ```

2. Pour lire les données du contrat comme `getWeatherData` :

   ```bash
   cast call <adresse_du_contrat> "getWeatherData(uint256)(int256,uint256,uint256,string,uint256)" 0
   ```

## Structure du projet

- **src/** : Contient les fichiers source Solidity.
  - `Weather.sol` : Le contrat principal.

- **test/** : Contient les fichiers de tests pour Foundry.
  - `WeatherNFT.t.sol` : Tests unitaires pour le contrat WeatherNFT.

- **script/** : Scripts pour le déploiement.
  - `DeployWeather.s.sol` : Script de déploiement du contrat.

- **cache/** et **out/** : Dossiers générés automatiquement par Foundry.



## Licence

Ce projet est sous licence MIT. Consultez le fichier `LICENSE` pour plus de détails.

