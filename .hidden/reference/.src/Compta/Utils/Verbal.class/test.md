# Verbal — Tests

> Source : `.src/Compta/Utils/Verbal.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de contrôle en lecture seule : le critère est le texte des 21 champs (et la couleur de
`Sgenerale`) relevé dans le log de replay ; le dump de la base doit rester inchangé. `Laurux01.sql`
ne contient aucune écriture : un **jeu dérivé** ajoute des comptes `C`, `F`, `G`, `B` (dont des
collectifs `411`/`401` avec `coll = 1`) et des écritures validées et non validées dans
`Fiches_Mvt` (exercice 2018 : `dteclec = 2018-12-31`, `dteclec1 = 2017-12-31`). La date du jour
influence les dates proposées : l'horloge est fixée (`faketime` ou équivalent) pour T01.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VERBAL-T01 | replay | Dates proposées à l'ouverture | date du jour fixée avant, pendant et après l'exercice 2018 | `DteN0`/`DteN1` figés pour les 3 cas | `tests/dates_ouverture/` | à faire |
| VERBAL-T02 | replay | Balance équilibrée | jeu dérivé équilibré, Traitement | 21 valeurs `0,00`-formatées attendues ; `Sgenerale = 0,00` | `tests/balance_equilibree/` | à faire |
| VERBAL-T03 | replay | Balance déséquilibrée | jeu dérivé avec une écriture non soldée, montants à 3 décimales et écritures non validées | valeurs figées, fond rouge, écritures non validées ignorées | `tests/balance_desequilibree/` | à faire |
| VERBAL-T04 | replay | Contrôle des dates saisies | `DteN0` avant `dte1`, `DteN1` au-delà de `année + 1`, fin < début | avertissements et dates remises figés | `tests/controle_dates/` | à faire |
| VERBAL-T05 | replay | Période dans un exercice antérieur | `01.01.2017`–`31.12.2017` avec écritures dans `Fiches_Mvt1` | valeurs à zéro (seul `Fiches_Mvt` lu, A03 figée) | `tests/exercice_anterieur/` | à faire |
| VERBAL-T06 | gbtest | `CalculeBalances` (après VERBAL-005) | même jeu que T02/T03 | 21 valeurs identiques aux champs de T02/T03 | `tests/calcule_balances/` | à faire |
| VERBAL-T07 | replay | Performance | jeu dérivé de 2 000 comptes et 50 000 écritures | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié avec le même jeu dérivé et la
  même locale (`LANG=fr_FR.UTF-8`, le séparateur décimal entre dans les comparaisons de texte).
- **gen_input.py** : génère le jeu dérivé (comptes, écritures) de T02, T03, T05 et T07.
- **Non testable automatiquement** : la synthèse vocale de `Syntheses.Message` (`/son2`), les sons.
