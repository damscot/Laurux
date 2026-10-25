# EdFam — Tests

> Source : `.src/Gestion/Impressions/EdFam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` avec comparaison du texte de `~/tmp/Famille.pdf` (`pdftotext -layout`) et des
lignes `Exec_SQL` ; la base n'est pas modifiée (dump identique avant/après). Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDFAM-T01 | replay | Plage par défaut | Imprimer | texte du PDF : toutes les familles | `tests/plage_defaut/` | à faire |
| EDFAM-T02 | replay | Sélection par liste | `ToggleButton1`, clic sur une ligne de `Colfam` ; `ToggleButton2`, Entrée dans `Colfam2` ; Imprimer | `Fam`/`Fam2` remplis, PDF limité à la plage | `tests/selection_liste/` | à faire |
| EDFAM-T03 | replay | Plage vide | `Fam` > `Fam2` | message « Aucune Famille » | `tests/plage_vide/` | à faire |
| EDFAM-T04 | replay | Saut de page | jeu > 52 familles | 2 pages | `tests/saut_page/` | à faire |
| EDFAM-T05 | replay | Clavier | Échap/F2 dans la liste, Entrée/Tab dans les champs | focus et visibilité des listes (log des contrôles) | `tests/clavier/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (une famille) puis jeu `editions_gestion` (voir
  [Edbr](../Edbr.module/test.md)) pour T02 et T04.
- **Rejeu** : `Colfam_Click`/`Colfam2_Click` existent (pas de `replay_missing`) ; ils doivent
  rester `Public` (`Object.Call`).
- **Non testable automatiquement** : aide HTML (`Doc.Open`), son.
