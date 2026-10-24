# Serveur — Tests

> Source : `.src/Serveur.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans GUI : tests `gbtest` avec une base MariaDB jetable (`Laurux01.sql` ou jeu dérivé) et un
répertoire d'échange temporaire affecté à `Variables.Schmprix` (variable `Public` du module
`Variables`). Le résultat comparé est le **contenu octet par octet** des fichiers
`*_Serveur.txt`, qui constitue un contrat avec le programme externe.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SERVEUR-T01 | gbtest | `Pass("Art", …)` | article existant de `Laurux01.sql` (champs `Null`, décimaux, désignation avec accents) en `C` et `M` ; `S` avec `code2`/`code3` | `Art_Serveur.txt` : deux lignes de 67 champs (doublon `art_ect`) puis `S;code;code2;code3;` | `tests/pass_article/` | à faire |
| SERVEUR-T02 | gbtest | `Pass("Fam", …)` | famille existante en `M` puis `S` | ligne sans `;` final ; `S;code;` | `tests/pass_famille/` | à faire |
| SERVEUR-T03 | gbtest | `Pass("Four"/"Cli", …)` | fournisseur et client existants (avec et sans ligne `Fiches_Comptes`) | lignes de référence (doublon `cli_typec`, `lettrable` vide sans compte) | `tests/pass_tiers/` | à faire |
| SERVEUR-T04 | gbtest | `Pass("ContactF"/"ContactC", …)` | contact existant (`code`, `num`) en `M`, puis `S` | lignes de référence | `tests/pass_contacts/` | à faire |
| SERVEUR-T05 | gbtest | Origines sans SQL | `EQ`, `CB`, `Rpl1`, `Rpl2`, `Etiq` (`P`, `G`), `Stock` | une ligne par appel au format du tableau d'architecture.md | `tests/pass_simples/` | à faire |
| SERVEUR-T06 | gbtest | Ajout en fin de fichier | fichier préexistant de 3 lignes ; fichier sans saut de ligne final ; fichier absent | lignes ajoutées sans écraser l'existant ; cas sans saut de ligne figé | `tests/pass_ajout/` | à faire |
| SERVEUR-T07 | gbtest | Cas d'erreur | code article inexistant ; `Variables.Schmprix` vers un répertoire absent ; champ contenant `;` et un retour à la ligne | erreur levée (message figé) ; ligne cassée figée (SERVEUR-A01/A02) | `tests/pass_erreurs/` | à faire |
| SERVEUR-T08 | replay | Intégration écran | `Articles` : création, modification, suppression d'un article, d'un code-barres et d'une référence liée avec `/Soc01/Sprix`, `Sexport`, `SMajArt` actifs | contenu des fichiers `Art_`, `CB_`, `Rpl1_`, `Rpl2_Serveur.txt` ; aucun fichier si une préférence est inactive | `tests/integration_articles/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites en exécutant les mêmes appels dans le clone **Laurux non
  modifié** (fichiers copiés dans `tests/<nom>/expected/`). Les champs `Float`/`Date` dépendent de
  la locale : les tests fixent `LANG=fr_FR.UTF-8`.
- **Comparaison** : `check_output.py` compare les fichiers octet par octet (y compris saut de ligne
  final et encodage).
- **Code mort** (`Docs`, `ReplaceFam`, `convBStr`) : non testé ; sa suppression (SERVEUR-002) est
  vérifiée par `gbc3` et par un grep sans appelant.
- **Non testable** : la lecture par le programme externe (hors dépôt).
