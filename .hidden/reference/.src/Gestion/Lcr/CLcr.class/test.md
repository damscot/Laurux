# CLcr — Tests

> Source : `.src/Gestion/Lcr/CLcr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit PDF sans accès à la base : tests `gbtest` qui produisent un PDF dans un répertoire
temporaire, puis comparent `pdftotext -layout` (texte et positions relatives) à la référence. La
date (`Now`, pied de page et `Level4B`), `User.Name` et `/CreationDate` sont figés par `faketime`
et une variable `USER` fixe, ou masqués par `check_output.py`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CLCR-T01 | gbtest | `Entete` + `BasPage` sur 2 pages | titre accentué, 2 appels `Entete` | texte des 2 pages, « Page 1/2 », « Page 2/2 » | `tests/entete_baspage/` | à faire |
| CLCR-T02 | gbtest | `Level1` + `Level2` | 3 lignes : adresse complète, adresse partielle (`sadr2` nul), sans adresse | texte et ordre des lignes | `tests/liste_lcr/` | à faire |
| CLCR-T03 | gbtest | `Level1A` + `Level2A` | adresses `" "` et nulles, banque renseignée ou vide | lignes d'adresse ignorées pour `" "` | `tests/liste_lcr_banque/` | à faire |
| CLCR-T04 | gbtest | Bordereau `Level1B`…`Level4B` | en-tête banque, 2 lignes, total `"1234,5"` | texte du bordereau, total `1234,50` (locale fr) ; date de remise = date figée | `tests/bordereau/` | à faire |
| CLCR-T05 | gbtest | Formatage des montants (caractérisation A01) | `smontant` = `"12,50"`, `"12.50"`, `""` dans `Level2`/`Level2A` | valeur imprimée ou erreur observée, par locale (`fr_FR`, `C`) | `tests/montants/` | à faire |
| CLCR-T06 | gbtest | `Lines` | `PosY` entier | PDF identique avant/après passage du paramètre en `Integer` | `tests/lines/` | à faire |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** (même programme de test lancé
  avec `gbx3 -T`), sortie `pdftotext` stockée dans `expected/`.
- Les tests s'exécutent avec `LANG=fr_FR.UTF-8` (comportement de production) ; T05 est rejoué en
  `LANG=C` pour documenter la dépendance à la locale.
- Les rendus réels sont aussi couverts par les replays des écrans `Lcr`, `Attribution`, `Glcr`,
  `Preparation` et `Bordrx` (PDF comparés de la même façon).
- Non testable automatiquement : rendu graphique fin (couleurs, épaisseurs) ; `pdftotext` ne
  compare que le texte.
