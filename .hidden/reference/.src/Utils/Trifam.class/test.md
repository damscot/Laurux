# Trifam — Tests

> Source : `.src/Utils/Trifam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Construction d'arbre à partir de la base et de la configuration : tests **gbtest** sur MariaDB
restaurée, avec une configuration de test (`Laurux.conf` fourni par le runner) qui fixe `ipr`.
Sortie : parcours de l'arbre (même algorithme que les appelants) en lignes `niveau;cle;Text;parent`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIFAM-T01 | gbtest | Arbre à 2 niveaux | `ipr = [1, 3]`, 6 familles | parcours ordonné de référence | `tests/deux_niveaux/` | implémenté |
| TRIFAM-T02 | gbtest | Arbre à 3 niveaux | `ipr = [1, 3, 5]`, préfixes sans fiche famille | nœuds intermédiaires à libellé vide | `tests/trois_niveaux/` | implémenté |
| TRIFAM-T03 | gbtest | Liens | arbre de T01 | `enfant` = dernier fils ; `precedant`/`suivant` cohérents | `tests/liens/` | implémenté |
| TRIFAM-T04 | gbtest | Sous-totaux | écritures successives de `soustotpa`/`soustotpmp` sur des feuilles | cumuls propagés à la racine | `tests/sous_totaux/` | implémenté |
| TRIFAM-T05 | gbtest | Codes limites | codes contenant `z`, `Z`, espaces, accents | figer l'exclusion éventuelle (A01) | `tests/codes_limites/` | implémenté |
| TRIFAM-T06 | replay | Paramétrage absent | `ipr` absent, ouverture de Stockmvt | figer `Message.Error` + arrêt (A02) | `tests/ipr_absent/` | à faire : le runner n'offre pas de Laurux.conf par scénario (ipr absent) ; Quit + Message.Error |
| TRIFAM-T07 | replay | Édition d'inventaire | Edinv sur un inventaire du jeu dérivé | flux PDF identique | `tests/replay_edinv/` | à faire : le runner ne compare pas les fichiers produits (flux PDF d'Edinv) |
| TRIFAM-T08 | gbtest | Performance | 2 000 familles, `ipr = [2, 4, 6]` | durée et nombre de requêtes de référence | `tests/perf/` | implémenté (durée relevée par le runner, non comparée ; nombre de requêtes non relevé) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié**.
- **Données** : `Laurux01.sql` + jeu dérivé de familles (`tests/*/data.sql`) ; `ipr` fixé dans le
  `Laurux.conf` de test de chaque répertoire.
- **Non testable en gb.test** : le cas `Quit` (arrête le processus de test) → replay T06.
- **Implémentation (phase 2)** : `.src/Tests/Utils/TrifamTest.test`, jeux `trifam_familles.sql` (T01-T05) et `trifam_perf.sql` (T08) dans `.src/Tests/Framework/datasets/` ; `ipr` fixé en mémoire (`Start.LocalSettings`) par chaque test. Constats figés : la clé de la racine est celle de la première famille ; `AZ`/`Az` fusionnés par le GROUP BY insensible à la casse ; préfixe à espace final exclu (PAD SPACE) ; `soustotpa = "1.5"` lève « Type mismatch » (Val en locale fr).
