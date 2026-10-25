# Etiqcasier — Tests

> Source : `.src/Gestion/Etiquettes/Etiqcasier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Même principe qu'[Etiqart](../Etiqart.class/test.md) : `replay`, dump de la base (table
`Etiquettes` avant `fin_impression`) et PDF normalisé `~/tmp/EtiqArt.pdf`. Références capturées
dans le clone **Laurux non modifié**, jeu `etiquettes_base` (articles avec et sans casier).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQCASIER-T01 | replay | Plage A4, tri casier | menu Casier ; modèle `Z- Test` ; tri `Radiobutton5` | PDF casier (casier, code, stock, EAN13) | `tests/etiqcasier_plage/` | à faire |
| ETIQCASIER-T02 | replay | Même code, deux pages | `Fiches_Etiquettes` avec `Z` en A4 Portrait et A4 Paysage ; choix Paysage | format de la 1re ligne trouvée figé (A02) | `tests/etiqcasier_page/` | à faire |
| ETIQCASIER-T03 | replay | Position de départ et 3 colonnes | `Posetiq` = 5, `Esplargeur` ≠ 0 | positions V3 figées (A03) | `tests/etiqcasier_position/` | à faire |
| ETIQCASIER-T04 | replay | Mode liste | `Liste` ; article avec casier, sans casier, `art_etiq = 0` ; cumul | table `Etiquettes`, `listBart` (log), PDF | `tests/etiqcasier_liste/` | à faire |
| ETIQCASIER-T05 | replay | Dymo `dymoc` | `Impetiq = "3- Dymo"` | PDF 25 × 25 | `tests/etiqcasier_dymo/` | à faire |
| ETIQCASIER-T06 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A01) | `tests/etiqcasier_zebra/` | à faire |
| ETIQCASIER-T07 | replay | Stock | `EtiqStk` ; stocks 0 / 2,5 / non stocké | nombres figés | `tests/etiqcasier_stock/` | à faire |
| ETIQCASIER-T08 | replay | Import portable | comme ETIQART-T09 | idem (fichier ouvert : PDF) | `tests/etiqcasier_portable/` | à faire |
| ETIQCASIER-T09 | gbtest | Position V3 (après ETIQART-010) | `PlancheEtiquettes` V3 | suites (X, Y, page) de T03 | `tests/planche_v3/` | à faire |

## Détail des tests

- **Rejeu** : deux `Utils.Observers(Me)` dans `Form_Open` (doublons probables) ; `Col*_Click`
  rejoués par `Object.Call` ; dialogues à piloter.
- **Fichier partagé** : Etiqart et Etiqcasier écrivent le même PDF : les scénarios ne doivent pas
  être enchaînés sans relever le fichier.
- **Non testable** : imprimante physique, visionneuse, éditeur, aide, Zebra.
