# Portable — Tests

> Source : `.src/Gestion/Lcr/Portables/Portable.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module de traitement testable en `gbtest` avec une base MariaDB de test (`Laurux01.sql` + table de
travail `Etiquettes` créée comme le font les écrans d'étiquettes) et un `HOME` temporaire contenant
`Portable/inventaire.txt` et `tmp/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PORTABLE-T01 | gbtest | Import étiquettes nominal | 3 lignes `codebarre;nombre` connues (code-barres et code article) | 3 lignes dans `Etiquettes`, `cpt2` inchangé, rapport avec seulement l'en-tête | `tests/import_nominal/` | implémenté |
| PORTABLE-T02 | gbtest | Rejets | code-barres inconnu ; ligne `;5` sans code-barres après une ligne valide | rapport `~/tmp/ImpT.txt`, `cpt2`, ligne réinsérée pour l'article précédent (A02 figée) | `tests/rejets/` | implémenté (la ligne ;5 reprend le code-barres rejeté précédent) |
| PORTABLE-T03 | gbtest | Cumul de `cpt2` | deux imports successifs avec un rejet chacun, puis un import sans rejet | `cpt2` = 2 après le 3ᵉ import (A01 figée) | `tests/cumul_cpt2/` | implémenté |
| PORTABLE-T04 | gbtest | Fichiers absents | pas de `inventaire.txt` ; pas de `~/tmp` | aucun effet / erreur (`Message.Error` à intercepter, voir détail) | `tests/fichiers_absents/` | implémenté pour inventaire.txt absent ; à faire : sans ~/tmp (Message.Error du Catch bloque gb.test) |
| PORTABLE-T05 | gbtest | `Org = "Casier"` | fichier présent | `~/tmp/ImpT.txt` vidé, base inchangée | `tests/org_casier/` | implémenté |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** : dump de `Etiquettes`, contenu
  de `~/tmp/ImpT.txt`, valeur de `cpt2`.
- Le `Message.Error` du `Catch` (T04 sans `~/tmp`) bloque un test sans GUI : à exclure ou à tester
  après la séparation traitement/GUI (PORTABLE-003).
- Le comportement de bout en bout (éditeur ouvert si `cpt2 <> 0`) est couvert par les replays des
  écrans d'étiquettes (`Etiqart`, `Etigond`, `Etiqcasier`).

### Implémentation (phase 2, vague 5)
- Module `.src/Tests/Gestion/PortableTest.test` (T01 à T05) : `inventaire.txt` écrit par le test dans le HOME de test,
  table `Etiquettes` recréée comme dans `Etiqart.liste_Click`. Base Laurux01 sans jeu dérivé.
- Observé : T02, la ligne `;5` sans code-barres garde `Codeb`/`Code` de la ligne précédente (rejetée) : deux messages
  pour la même ligne (« pas de code barre » puis « le code barre 9999999999999 n'existe pas ») et `cpt2` = 3 pour
  2 lignes rejetées. T04/T05 : `~/tmp/ImpT.txt` est vidé (contenu nul) quand le fichier est absent ou `Org = "Casier"`.
  T03 : `cpt2` cumule entre imports (A01).
