# Trifam — Tests

> Source : `.src/Utils/Trifam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Construction d'arbre à partir de la base et de la configuration : tests **gbtest** sur MariaDB
restaurée, avec une configuration de test (`Laurux.conf` fourni par le runner) qui fixe `ipr`.
Sortie : parcours de l'arbre (même algorithme que les appelants) en lignes `niveau;cle;Text;parent`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIFAM-T01 | gbtest | Arbre à 2 niveaux | `ipr = [1, 3]`, 6 familles | parcours ordonné de référence | `tests/deux_niveaux/` | à faire |
| TRIFAM-T02 | gbtest | Arbre à 3 niveaux | `ipr = [1, 3, 5]`, préfixes sans fiche famille | nœuds intermédiaires à libellé vide | `tests/trois_niveaux/` | à faire |
| TRIFAM-T03 | gbtest | Liens | arbre de T01 | `enfant` = dernier fils ; `precedant`/`suivant` cohérents | `tests/liens/` | à faire |
| TRIFAM-T04 | gbtest | Sous-totaux | écritures successives de `soustotpa`/`soustotpmp` sur des feuilles | cumuls propagés à la racine | `tests/sous_totaux/` | à faire |
| TRIFAM-T05 | gbtest | Codes limites | codes contenant `z`, `Z`, espaces, accents | figer l'exclusion éventuelle (A01) | `tests/codes_limites/` | à faire |
| TRIFAM-T06 | replay | Paramétrage absent | `ipr` absent, ouverture de Stockmvt | figer `Message.Error` + arrêt (A02) | `tests/ipr_absent/` | à faire |
| TRIFAM-T07 | replay | Édition d'inventaire | Edinv sur un inventaire du jeu dérivé | flux PDF identique | `tests/replay_edinv/` | à faire |
| TRIFAM-T08 | gbtest | Performance | 2 000 familles, `ipr = [2, 4, 6]` | durée et nombre de requêtes de référence | `tests/perf/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié**.
- **Données** : `Laurux01.sql` + jeu dérivé de familles (`tests/*/data.sql`) ; `ipr` fixé dans le
  `Laurux.conf` de test de chaque répertoire.
- **Non testable en gb.test** : le cas `Quit` (arrête le processus de test) → replay T06.
