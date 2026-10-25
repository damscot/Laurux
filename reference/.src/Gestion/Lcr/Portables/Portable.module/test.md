# Portable — Tests

> Source : `.src/Gestion/Lcr/Portables/Portable.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module de traitement testable en `gbtest` avec une base MariaDB de test (`Laurux01.sql` + table de
travail `Etiquettes` créée comme le font les écrans d'étiquettes) et un `HOME` temporaire contenant
`Portable/inventaire.txt` et `tmp/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PORTABLE-T01 | gbtest | Import étiquettes nominal | 3 lignes `codebarre;nombre` connues (code-barres et code article) | 3 lignes dans `Etiquettes`, `cpt2` inchangé, rapport avec seulement l'en-tête | `tests/import_nominal/` | à faire |
| PORTABLE-T02 | gbtest | Rejets | code-barres inconnu ; ligne `;5` sans code-barres après une ligne valide | rapport `~/tmp/ImpT.txt`, `cpt2`, ligne réinsérée pour l'article précédent (A02 figée) | `tests/rejets/` | à faire |
| PORTABLE-T03 | gbtest | Cumul de `cpt2` | deux imports successifs avec un rejet chacun, puis un import sans rejet | `cpt2` = 2 après le 3ᵉ import (A01 figée) | `tests/cumul_cpt2/` | à faire |
| PORTABLE-T04 | gbtest | Fichiers absents | pas de `inventaire.txt` ; pas de `~/tmp` | aucun effet / erreur (`Message.Error` à intercepter, voir détail) | `tests/fichiers_absents/` | à faire |
| PORTABLE-T05 | gbtest | `Org = "Casier"` | fichier présent | `~/tmp/ImpT.txt` vidé, base inchangée | `tests/org_casier/` | à faire |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** : dump de `Etiquettes`, contenu
  de `~/tmp/ImpT.txt`, valeur de `cpt2`.
- Le `Message.Error` du `Catch` (T04 sans `~/tmp`) bloque un test sans GUI : à exclure ou à tester
  après la séparation traitement/GUI (PORTABLE-003).
- Le comportement de bout en bout (éditeur ouvert si `cpt2 <> 0`) est couvert par les replays des
  écrans d'étiquettes (`Etiqart`, `Etigond`, `Etiqcasier`).
