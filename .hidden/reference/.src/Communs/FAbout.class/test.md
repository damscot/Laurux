# FAbout — Tests

> Source : `.src/Communs/FAbout.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FABOUT-T01 | replay | Ouverture | `Fmenu` → « ? > Concernant Laurux » ; `sha1.txt`/`branch.txt` fixés par le test | textes `Version` et `Versionsha1` | `tests/ouverture/` | implémenté (gbtest : fenêtre construite sans affichage) |
| FABOUT-T02 | replay | Remerciements | clic « Remerciements » deux fois | `Lic`, `Grad1`, `Grad2` visibles puis masqués ; `Temps.Delay = 30` | `tests/remerciements/` | implémenté (gbtest, partiel : visibilités ; `Temps.Delay` non lisible, minuteur non public) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; la version vient de `.project`.
- **Non testable automatiquement** : rendu des dégradés et défilement (vérification visuelle) ;
  charge CPU du minuteur (A01).
- **Implémentation (phase 2)** : `.src/Tests/Communs/FAboutTest.test` (valeurs : `assets/FAboutTest/`).
  `Start.version_sha1`/`version_branch` fixés par le test (`Start.Main` non exécuté en gb.test) ;
  `Application.Name` vaut le nom du répertoire du clone sous `gbx3 -T` (`ref`/`rework`) : masqué.
