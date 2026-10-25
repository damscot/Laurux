# EdFour — Tests

> Source : `.src/Gestion/Impressions/EdFour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Fours.pdf` par `pdftotext -layout`, pied de page masqué : date et
`User.Name` ; lignes `Exec_SQL` ; dump inchangé). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDFOUR-T01 | replay | Tri par code | plage par défaut, Imprimer | texte du PDF | `tests/tri_code/` | à faire |
| EDFOUR-T02 | replay | Tri par nom | `RadioButton2`, Imprimer | ordre alphabétique | `tests/tri_nom/` | à faire |
| EDFOUR-T03 | replay | Sélection par liste et F2 | F2 dans `Cli`, clic dans `Colcli` ; F2 dans `Cli2`, Entrée | bornes remplies | `tests/selection_liste/` | à faire |
| EDFOUR-T04 | replay | Plage vide | `Cli` > `Cli2` | message « Aucun fournisseur » | `tests/plage_vide/` | à faire |
| EDFOUR-T05 | replay | Saut de page | > 27 fournisseurs | 2 pages ; pied de la dernière page décentré (A01 figée, contrôle par `pdftotext -bbox`) | `tests/saut_page/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (fournisseurs `401001…`) et jeu `editions_gestion` (voir
  [Edbr](../Edbr.module/test.md)) pour T05.
- **Rejeu** : `Colcli_Click`/`Colcli2_Click` présents ; `Utils.Observers` dans `_New`.
- **Non testable automatiquement** : aide HTML, son.
