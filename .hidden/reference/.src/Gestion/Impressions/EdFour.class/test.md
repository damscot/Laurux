# EdFour — Tests

> Source : `.src/Gestion/Impressions/EdFour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Fours.pdf` par `pdftotext -layout`, pied de page masqué : date et
`User.Name` ; lignes `Exec_SQL` ; dump inchangé). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDFOUR-T01 | replay | Tri par code | plage par défaut, Imprimer | texte du PDF | `tests/tri_code/` | implémenté (`Gestion/edfour_tri_code`) |
| EDFOUR-T02 | replay | Tri par nom | `RadioButton2`, Imprimer | ordre alphabétique | `tests/tri_nom/` | implémenté (`Gestion/edfour_tri_nom`) |
| EDFOUR-T03 | replay | Sélection par liste et F2 | F2 dans `Cli`, clic dans `Colcli` ; F2 dans `Cli2`, Entrée | bornes remplies | `tests/selection_liste/` | implémenté (`Gestion/edfour_selection_liste` : boutons et clics ; F2 et Entrée non rejoués) |
| EDFOUR-T04 | replay | Plage vide | `Cli` > `Cli2` | message « Aucun fournisseur » | `tests/plage_vide/` | implémenté (`Gestion/edfour_plage_vide`) |
| EDFOUR-T05 | replay | Saut de page | > 27 fournisseurs | 2 pages ; pied de la dernière page décentré (A01 figée, contrôle par `pdftotext -bbox`) | `tests/saut_page/` | implémenté (`Gestion/edfour_saut_page`) |

## Détail des tests

- **Implémentation (phase 2, vague 5)** : scénarios `.hidden/Tests/Gestion/assets/edfour_*` (fenêtre `EDfour`, nom écrit dans `Fmenu` ; menu Gestion > Impression des tables > Fournisseurs) ; jeu `edfour_shared/fournisseurs.sql` (10 fournisseurs 401901 à 401910) pour T05 ; texte du PDF par `/Soc01/caisse/CmdVis` → `edition.txt`.

- **Données** : `Laurux01.sql` (fournisseurs `401001…`) et jeu `editions_gestion` (voir
  [Edbr](../Edbr.module/test.md)) pour T05.
- **Rejeu** : `Colcli_Click`/`Colcli2_Click` présents ; `Utils.Observers` dans `_New`.
- **Non testable automatiquement** : aide HTML, son.
