# MajTarifP — Tests

> Source : `.src/Gestion/Stock/Tarifs/MajTarifP.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests par **replay** de l'écran « Maj tarif en % », dump de `Fiches_Art`, `Fiches_EtiProd`,
`Fiches_EtiGond`. Jeu dérivé de `Laurux01.sql` : un fournisseur F avec ~10 articles variés
(`art_nbd` 0/2/3, taux de conversion, frais, remise, stock nul/positif, `art_etiq`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJTARIFP-T01 | replay | Mode prix de base | fournisseur F, +5 %, `Tbrut`, Entrée sur `Pourcent` puis clic sur `Button2` | dump `Fiches_Art` (masquer `art_ddatefbt`), étiquettes | `tests/brut_hausse/` | à faire |
| MAJTARIFP-T02 | replay | Mode prix de vente | fournisseur F, −3 %, `Tnet` | dump `Fiches_Art`, étiquettes | `tests/net_baisse/` | à faire |
| MAJTARIFP-T03 | replay | Fournisseur inconnu / liste | saisie d'un code absent, puis sélection par la liste (`Button4`, `fourList_Click`) | message d'avertissement ; `fournom` rempli | `tests/fournisseur/` | à faire |
| MAJTARIFP-T04 | replay | Tabulation sur `Button2` (A02) | focus sur `Button2`, touche Tab | figer : la mise à jour est lancée | `tests/tab_bouton/` | à faire |
| MAJTARIFP-T05 | replay | Fournisseur vide | `Four` vide, +5 % | figer : articles sans fournisseur mis à jour, ou message « Aucune mise à jour » | `tests/fournisseur_vide/` | à faire |
| MAJTARIFP-T06 | replay | SQLite | T01 sur base SQLite | dump de référence | `tests/sqlite/` | à faire |
| MAJTARIFP-T07 | gbtest | Chaîne de calcul (après `LTarifCalc`) | articles de T01/T02 | mêmes prix que les dumps T01/T02 | `tests/calcul_tarif/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; `art_ddatefbt` masqué.
- **Rejeu** : `Utils.Observers(Me)` appelé une fois dans `_new` ; `fourList_Click` appelé
  dynamiquement ; les boîtes de message (avertissement, fin, impression des étiquettes : répondre
  « Non ») font partie du scénario.
- **Non testable en gb.test** avant MAJTARIFP-004 : méthodes d'une `Form`.
- **`Prix_achat`** : code mort, non couvert (suppression MAJTARIFP-002).
