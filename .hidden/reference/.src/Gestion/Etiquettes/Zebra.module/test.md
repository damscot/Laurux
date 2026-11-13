# Zebra — Tests

> Source : `.src/Gestion/Etiquettes/Zebra.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La sortie est un flux ZPL : elle se compare **en rejeu** sans imprimante, en remplaçant
l'imprimante par une socket d'écoute locale. Les valeurs attendues sont capturées dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ZEBRA-T01 | gbtest | Flux ZPL nominal | `barcode="3270190207924"`, `Pvttc="12,50 "`, `Intitule="Râteau \"pro\" & co"`, `Code="ART001"`, `ttc="TTC"`, `Casier="A12"`, `Kgl="2,50 Kg/l"`, `Cfourn="REF-9"` | flux reçu identique à `expected/zpl_nominal.bin` | `tests/zebra_flux/` | implémenté |
| ZEBRA-T02 | gbtest | Données limites | chaînes vides, `_`, `^`, `~`, accents, intitulé de 60 caractères | flux reçu figé (défauts ZEBRA-A02 compris) | `tests/zebra_limites/` | implémenté |
| ZEBRA-T03 | gbtest | Socket fermée | socket déconnectée avant l'appel | erreur levée (caractérisation du type d'erreur) | `tests/zebra_socket_fermee/` | implémenté |

## Détail des tests

- **Montage** : le test ouvre un `ServerSocket` gb.net sur `127.0.0.1` (port libre), connecte un
  `Socket` client, appelle `Zebra.Gondole1`, ferme le client et compare les octets reçus.
  Aucun accès base.
- **Non testable sans matériel** : rendu réel (position, lisibilité du code-barres, caractère `3`
  supposé après le code-barres, accents avec `^CI0`, effet de `^JUS` qui réécrit la configuration
  de l'imprimante à chaque étiquette). À valider manuellement sur une Zebra si ZEBRA-A01 est
  tranchée en faveur du branchement.
- Les écrans appelants ne peuvent pas produire de flux Zebra aujourd'hui (ZEBRA-A01) : aucun
  replay d'écran ne couvre ce module.

### Implémentation (phase 2)
- gb.test `.src/Tests/Gestion/ZebraTest.test` ; écouteur TCP local `.hidden/Tests/Gestion/assets/ZebraTest/ecoute.py`
  (python3, port libre) ; flux comparé champ par champ (coupure après `^FS`/`^XZ`) au lieu d'un fichier binaire.
- T02 fige l'injection : un `^FS` dans l'intitulé termine le champ (ZEBRA-A02). T03 : « Stream is closed ».
