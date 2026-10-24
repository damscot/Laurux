# LDate — Tests

> Source : `.src/Utils/LDate.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Les formats, l'analyse et les comparaisons sont du calcul pur (`gbtest` sans base). Les fonctions
d'exercice lisent `Fiches_Parametres` : `gbtest` avec la base MariaDB Docker chargée depuis
`Laurux01.sql`, plus un jeu dérivé où les clôtures sont décalées (exercice au 30/06).
`Now` intervient dans plusieurs chemins : les tests correspondants comparent à une valeur calculée
au moment du test (jour, mois, année courants), pas à une constante.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LDATE-T01 | gbtest | `_New`/`_call` par type | `Date`, `2024`, `2024,2,29,10,5,3`, `Null`, `""`, `0` | `.DT` de référence ; `Null`/`""`/`0` → maintenant | `tests/constructeur/` | à faire |
| LDATE-T02 | gbtest | `Parse` formats complets | `"12.03.2024"`, `"2024-03-12"`, `"12/03/24"`, `"12.03.4"`, `"20240312101112"`, avec heures `hh:nn[:ss]` | `.DT` de référence | `tests/parse_complet/` | à faire |
| LDATE-T03 | gbtest | `Parse` formats partiels | `"12.03"`, `"03.2024"`, `"2024.03"`, `"12"`, `"2024"`, `".."` | composants attendus relatifs à `Now` | `tests/parse_partiel/` | à faire |
| LDATE-T04 | gbtest | `Parse` cas limites (anomalies figées) | `"12/03/24 10:30"` (14 car.), `"2024.02"` un 30 du mois (simulé par calcul) | `Null` figé | `tests/parse_limites/` | à faire |
| LDATE-T05 | gbtest | Propriétés de format en lecture | 3 dates (dont 29/02 et 31/12 23:59:59) | `L`, `LT`, `D`, `DT`, `F`, `FT`, `G`, `GnT` | `tests/formats/` | à faire |
| LDATE-T06 | gbtest | Propriétés en écriture + événement | `L`, `LT`, `D`, `DT`, `G`, `GnT` affectés ; observateur `change` | valeur relue ; nombre d'événements | `tests/ecriture_evenement/` | à faire |
| LDATE-T07 | gbtest | Composants | 12 dates (un par mois), jours de semaine | `Day`, `Week`, `Month`, `Year`, `Year2`, `WeekDay(3)`, `MonStr(3)` (incohérence de `MonStr` figée) | `tests/composants/` | à faire |
| LDATE-T08 | gbtest | `FinMois`, `FinJour`, `PDeb`, `PFin` | 31/01, 15/02 (bissextile et non), 31/12 | `.DT` + millisecondes | `tests/fin_periode/` | à faire |
| LDATE-T09 | gbtest | `Apres`/`Avant` strict et non strict | paires : égales, ±1 s, ±1 ms, années différentes, 31/12 vs 01/01 | booléens | `tests/comparaison/` | à faire |
| LDATE-T10 | gbtest | `DateFilterDB` | `"12.*.2024"`, `"*.03"`, `"2024"`, `"12"`, `""`, `HasTime` avec `" 10:3*"` | motifs `LIKE` de référence | `tests/filtre_db/` | à faire |
| LDATE-T11 | gbtest (BDD) | `EFin`/`EDeb`/`EInd` | `Laurux01.sql` : une date dans chaque exercice N…N-5, avant N-5, après N | `.DT` et index | `tests/exercice_laurux01/` | à faire |
| LDATE-T12 | gbtest (BDD) | Exercice décalé (anomalies A02/A03 figées) | jeu dérivé : clôtures au 30/06, premier exercice de 18 mois | `.DT` figés | `tests/exercice_decale/` | à faire |
| LDATE-T13 | gbtest (BDD) | `Exercice_Cloture(i)` | i = 0…6 | `.DT` de `dteclec*` en fin de journée | `tests/exercice_cloture/` | à faire |
| LDATE-T14 | gbtest | Performance | 100 000 `LDate("12.03.2024").D` ; 1 000 `EFin` | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : exécution des mêmes appels dans le clone Laurux non
  modifié, sortie `id;valeur` dans `expected/`. Pour les cas dépendant de `Now`, le module écrit la
  différence avec la date courante (en jours/mois) plutôt que la date absolue.
- **Données** : `Laurux01.sql` pour T11/T13 ; T12 utilise un `UPDATE Fiches_Parametres` appliqué
  après l'import (script `tests/exercice_decale/init.sql`).
- **Non testable en gb.test** : les chemins `Message.Error` de `Parse` et `_New` (chaîne non
  reconnue) ; T04 se limite aux cas qui renvoient `Null` sans message (chaîne de 14 caractères avec
  exception rattrapée → un `Message.Error` est quand même affiché : à exécuter en mode replay
  manuel tant que LDATE-005 n'a pas séparé l'analyse des messages).
- **Couverture visée** : 100 % hors branches `Message.Error`.
