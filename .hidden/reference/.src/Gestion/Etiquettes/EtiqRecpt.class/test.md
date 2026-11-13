# EtiqRecpt — Tests

> Source : `.src/Gestion/Etiquettes/EtiqRecpt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` : diff de `Fiches_EtiProd`/`Fiches_EtiGond` (dump) et du PDF normalisé
`~/tmp/EtiqRecpt.pdf`. Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQRECPT-T01 | replay | Compteurs | ouverture avec files de 3 et 2 lignes | `Nbetip`, `Nbetic`, `Nbetig` (log) | `tests/etiqrecpt_compteurs/` | implémenté |
| ETIQRECPT-T02 | replay | Produits A4 | type produit, `EtiqPrix` ; Imprimer ; refuser l'effacement | PDF ; files inchangées | `tests/etiqrecpt_produit/` | implémenté |
| ETIQRECPT-T03 | replay | Gondole A4 + effacement | type gondole ; Imprimer ; accepter | PDF ; `Fiches_EtiGond` vide | `tests/etiqrecpt_gondole/` | implémenté |
| ETIQRECPT-T04 | replay | Casier A4 et Dymo | type casier, A4 puis `Impetiq = "3- Dymo"` | PDF A4 / `dymoc` ; effacement de `Fiches_EtiProd` entier | `tests/etiqrecpt_casier/` | implémenté |
| ETIQRECPT-T05 | replay | Référence fournisseur | ligne de file dont `code` = `art_cfour` | article retrouvé par repli | `tests/etiqrecpt_cfour/` | implémenté |
| ETIQRECPT-T06 | replay | Orphelin | ligne de file sans article ni référence | erreur figée (A02) | `tests/etiqrecpt_orphelin/` | implémenté |
| ETIQRECPT-T07 | replay | Position de départ | `Posetiq` = 2 puis 4 (premier passage) | 2 : aucune position sautée ; 4 : « Null object » figé (A01) | `tests/etiqrecpt_position/` | implémenté |
| ETIQRECPT-T08 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A03) | `tests/etiqrecpt_zebra/` | implémenté |
| ETIQRECPT-T09 | replay | Enchaînement depuis une réception | `GesTar` : mise à jour tarif d'un article → écran ouvert | file alimentée, compteurs | `tests/etiqrecpt_depuis_gestar/` | à faire : enchaînement depuis GesTar (écran de réception, hors liste) ; ouverture par MajTarifP couverte par MAJTARIFP |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu `etiquettes_base` + files `Fiches_EtiProd`/`Fiches_EtiGond`
  préremplies (dont un code `art_cfour` et un orphelin pour T05-T06), un code TVA valide.
- **Rejeu** : écran non modal (auto-instance), un seul `Utils.Observers(Me)` ; dialogue
  d'effacement piloté. Aucune grille (pas de `_Click` dynamique).
- **Non testable** : imprimante physique, visionneuse, aide.

### Implémentation (phase 2)
- T01 : gb.test `.src/Tests/Gestion/EtiqRecptTest.test` (`T01Compteurs`) ; couleurs `/Coul/Znaff|Focus|Znss` posées dans le
  test (absentes de `Laurux-test.conf`, `Utils.Fcolr` renverrait Null).
- Jeu partagé `.hidden/Tests/Gestion/assets/etiqrecpt_shared/etiqrecpt_base.sql` (EtiProd 001×2, 002×1, 003×1 ;
  EtiGond 001×1, 002×2 ; casiers C1/C2 ; art_cfour REF002) ; jeux propres `etiqrecpt_cfour`, `etiqrecpt_orphelin`.
- Scénarios `.hidden/Tests/Gestion/assets/etiqrecpt_{produit,gondole,casier,cfour,orphelin,position,position4,zebra}/`
  (Menu164, texte des PDF par pdftotext dans `edition.txt`). T06, T07 (position 4) et T08 figent le code de sortie 125
  (`Result is not available` ligne 221 ; `Null object` lignes 176 et 205).
