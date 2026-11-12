# Listextcpt — Tests

> Source : `.src/Compta/Utils/Listextcpt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de traitement sans IHM (hors `Application.Busy`) : tests `gbtest` sur une base MariaDB
Docker importée de `Laurux01.sql` et d'un jeu dérivé `data/mvt_exercices.sql` (écritures dans
`Fiches_Mvt` et au moins `Fiches_Mvt1`/`Fiches_Mvt2`, lots lettrés et non lettrés, écritures
pointées, à-nouveaux du journal `jdr`, une écriture provisoire). Les dates relatives (`Now ± 8 ans`)
sont neutralisées en passant toujours `dtei`/`dtes` explicitement, sauf dans T02.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LISTEXTCPT-T01 | gbtest | Texte de `requete` | comptes 411/401/512 × `ltr` `n`/`o`/`t`/autre × plages (dans N, N-1→N, avant le plus ancien exercice, début d'exercice exact) × `origin` vide/`"relance"` × tri `" dte"`/`" numero"` | texte SQL de référence (octet à octet) ; `Left(requete, -14)` de référence pour le tri par défaut | `tests/listextcpt_requete/` | implémenté |
| LISTEXTCPT-T02 | gbtest | `resext` | mêmes cas que T01 + appel sans dates (défauts) | lignes de référence (toutes colonnes, `bgcolor` compris) ; `Null` si `cpt` vide | `tests/listextcpt_resext/` | implémenté |
| LISTEXTCPT-T03 | gbtest | Ligne « Report a nouveau » | `ltr = "t"`, `dtei` en milieu d'exercice N et N-1 | ligne de report figée (colonnes `numero`/`intitule` inversées, A02) | `tests/listextcpt_report/` | implémenté |
| LISTEXTCPT-T04 | gbtest | Bornes d'exercice | tables `Fiches_Mvt3..5` vides/non vides ; `dtei` antérieure au premier exercice | requêtes de T01 ; effet de l'alias A03 sur `rechechelot` appelé ensuite | `tests/listextcpt_bornes/` | implémenté |
| LISTEXTCPT-T05 | gbtest | `litleres` | numéro présent dans N, dans N-1, absent | `Result` attendu ; `Null` si absent | `tests/listextcpt_litleres/` | implémenté |
| LISTEXTCPT-T06 | gbtest | `letcpt` | `choix` `numlot`, `lettrage`, `tresor` ; `lind` absent | dump `Fiches_Mvt*` (`numlot`, `lettree`) | `tests/listextcpt_letcpt/` | implémenté |
| LISTEXTCPT-T07 | gbtest | `letgroupe` | lot présent dans N et N-1 | dump `Fiches_Mvt*` | `tests/listextcpt_letgroupe/` | implémenté |
| LISTEXTCPT-T08 | gbtest | `Controle` / `Ecart` | lot équilibré, déséquilibré de 0,01, lot inexistant, `numcpt` omis | 1/0 ; `Ecart` attendu | `tests/listextcpt_controle/` | implémenté |
| LISTEXTCPT-T09 | gbtest | `rechechelot` / `rechedoc` | lot multi-exercices ; `numdoc` exact et `egal = " like "` avec `%` | lignes de référence | `tests/listextcpt_recherche/` | implémenté |
| LISTEXTCPT-T10 | gbtest | Pointage | `totalpointe` (liste vide, 1, 3 numéros) ; `enregistrepointage` (`True`/`False`) ; `litpointee` | totaux ; dump `Fiches_Mvt*` (`pointee`, `nrlv`) ; tableau de numéros | `tests/listextcpt_pointage/` | implémenté |
| LISTEXTCPT-T11 | gbtest | `cherche` sur extrait vide | `litleres`/`letcpt` sans lecture préalable de `resext` | erreur d'exécution figée (A05) | `tests/listextcpt_cherche_vide/` | implémenté |
| LISTEXTCPT-T12 | gbtest | SQLite | T01/T02 sur la base `Laurux01.sqlite` | lignes de référence ou erreur figée (`UNION (SELECT …)`, A06) | `tests/listextcpt_sqlite/` | à faire : le framework gb.test n'ouvre que la base MariaDB (pas de base SQLite de test) |
| LISTEXTCPT-T13 | gbtest | Performance | extrait 411 sur 6 exercices, `Laurux01.sql` | durée de référence (`gbx3 -p`) ; nombre de requêtes | `tests/listextcpt_perf/` | à faire : mesure de durée non comparée par le runner (gbx3 -p hors framework) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** sur la même base, puis
  stockées dans `tests/<nom>/expected/` (texte SQL, lignes CSV, dumps normalisés).
- **Couleurs** : `LCoul.Ecr_DB_bgcolor` dépend de `/Coul/*` ; les tests fixent un `Laurux.conf`
  de test (HOME isolé) pour que le texte SQL soit stable.
- **Isolation** : base restaurée avant chaque test qui écrit (T06, T07, T10).
- **Couverture visée** : toutes les branches de `_new` (6 tables, 3 filtres, relance, report),
  `cherche` trouvé/non trouvé, `dtsup` (3 branches).
- **Non testable en gbtest** : l'effet visuel de `Application.Busy` (couvert par le replay de
  `Pointage`).

- **Implémentation (phase 2, vague 3)** : module `.src/Tests/Compta/ListextcptTest.test` (T01 à T11), jeu partagé
  `.hidden/Tests/Compta/assets/listextcpt_shared/listext_base.sql` (écritures 2016 dans `Fiches_Mvt2`, 2017 dans
  `Fiches_Mvt1`, 2018 dans `Fiches_Mvt` ; lot `L1` à cheval sur 2016/2017, à-nouveau `jdr` 90, lot `A` équilibré,
  lot `B` déséquilibré de 0,01, banque pointée relevé 1, écriture provisoire). Le cas « sans dates » de T02 est
  vérifié par différence avec un appel explicite à `Now ± 8 ans`. T04 vide `Fiches_Mvt1`/`Fiches_Mvt2` dans le test.
  Comportements figés : ligne de report avec `numero`/`intitule` inversés (A02) ; `Controle` d'un lot inexistant
  = 1 ; `litleres`/`letcpt` sans lecture de `resext` → « Null object » (A05) ; le report en N-1 ne lit que la
  table de l'exercice du début.
