# MisundersToken - deploy con MetaMask

La cartella contiene il token `MisundersToken`, la sua interfaccia e il contratto che la utilizza.

## Avvio della rete locale

1. Avviare il nodo Hardhat:

   ```bash
   npm run node
   ```

2. Aggiungere in MetaMask una rete personalizzata:
   - Network name: `Hardhat Local`
   - RPC URL: `http://127.0.0.1:8545`
   - Chain ID: `31337`
   - Currency symbol: `ETH`

3. Importare in MetaMask il primo account mostrato da `npm run node`, usando la sua chiave privata.

## Deploy da Remix

1. Aprire Remix e usare la cartella dei contratti oppure caricare i file della cartella `MisundersToken`.
2. Selezionare l'ambiente Remix `Injected Provider - MetaMask`.
3. Verificare che MetaMask sia collegato alla rete `Hardhat Local`.
4. Compilare `MisundersToken.sol` con Solidity `0.8.28`.
5. Nel campo constructor inserire il supply iniziale in unità del token, per esempio `1000`.
6. Distribuire `MisundersToken`.

## Importazione del token in MetaMask

In MetaMask:

1. Aprire `Import tokens`.
2. Incollare l'indirizzo del contratto distribuito.
3. Verificare:
   - Name: `MisundersToken`
   - Symbol: `MUND`
   - Decimals: `18`

## Interazione tramite interfaccia

Distribuire `ERC20InterfaceCall.sol` passando come constructor l'indirizzo del contratto `MisundersToken`.
