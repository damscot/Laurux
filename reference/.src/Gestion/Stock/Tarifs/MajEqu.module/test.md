# MajEqu — Tests

> Source : `.src/Gestion/Stock/Tarifs/MajEqu.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module de traitement pur SQL, sans GUI : tests gb.test exécutés sur la base MariaDB Docker
(restaurée avant chaque test), avec comparaison du dump trié de `Fiches_Cequ` et de la colonne
`Fiches_Art.art_cequ`. Les drapeaux `Variables.Sprix/Sexport/SMajArt` sont laissés à faux
(pas d'export serveur), sauf T05.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJEQU-T01 | gbtest | `Maj` sur table vide | `Maj("A", "B")` | dump `Fiches_Cequ` (attendu : `(A,A)`, `(A,B)`, `(B,A)`, `(B,B)`) et `art_cequ` de `A` | `tests/maj_simple/` | à faire |
| MAJEQU-T02 | gbtest | Fermeture transitive | `Maj("A","B")`, `Maj("C","D")`, puis `Maj("B","C")` ; variante `Maj("C","B")` | dump `Fiches_Cequ` de référence (figer : groupe complet ou non) | `tests/maj_chaine/` | à faire |
| MAJEQU-T03 | gbtest | Idempotence | `Maj("A","B")` deux fois | dump identique au premier appel | `tests/maj_idempotent/` | à faire |
| MAJEQU-T04 | gbtest | `Recup` | table contenant seulement `(A,B)`, `(B,C)` ; puis table vide (A01) | dump de référence ; table vide : erreur levée (caractérisation) | `tests/recup/` | à faire |
| MAJEQU-T05 | replay | Export serveur | Articles : saisie d'un code équivalent avec `Sprix`, `Sexport`, `SMajArt` actifs | contenu de `EQ_Serveur.txt` | `tests/export_eq/` | à faire |
| MAJEQU-T06 | replay | Doublons avec backtrace (A02) | `/dbase/backtrace` actif, Articles : code équivalent déjà présent | nombre de boîtes d'erreur (log GUI) ; dump `Fiches_Cequ` | `tests/doublon_backtrace/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (même appels gb.test,
  dump capturé dans `tests/<nom>/expected/`). Le résultat de T02 est figé tel quel, même si la
  fermeture est incomplète.
- **Données** : `Laurux01.sql` + articles `A`, `B`, `C`, `D` créés par `tests/<nom>/data.sql`.
- **SQLite** : T01 à T04 rejoués aussi sur la base SQLite de référence (pas de syntaxe MySQL
  spécifique dans le module).
- **Couverture** : 100 % des lignes de `Maj` et `Recup` avec T01 à T05.
