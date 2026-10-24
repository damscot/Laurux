# Csolde — Tests

> Source : `.src/Utils/Csolde.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CSOLDE-T01 | gbtest | `Solde_caisse` | `Laurux01.sql` + jeu dérivé : compte sans écriture, avec écritures validées et non validées, montants à 2 décimales nombreux (cumul Float), montant `NULL` | `Fiches_Comptes.solde` (dump) de référence | `tests/solde_compte/` | à faire |
| CSOLDE-T02 | gbtest | `Recalc_solde` | `Laurux01.sql` complet | dump `Fiches_Comptes` (colonne `solde`) de référence ; nombre de requêtes (log SQL) | `tests/recalc_tous/` | à faire |
| CSOLDE-T03 | gbtest | Équivalence avec `Calcsolde.Calcul` | mêmes données que T01/T02 | comparaison au centime des soldes des deux implémentations (préparation de la commonalisation) | `tests/equivalence_calcsolde/` | à faire |
| CSOLDE-T04 | gbtest | Performance | `Laurux01.sql` | durée de `Recalc_solde` (`gbx3 -p`) | `tests/perf_recalc/` | à faire |

## Détail des tests

- Base : MariaDB Docker avec `Laurux01.sql`, plus un jeu dérivé `data/mvt_solde.sql` ; variante
  SQLite pour T01. Les dumps attendus sont produits par le clone **Laurux non modifié**.
- T03 est un test d'information : il ne bloque pas la phase 4 mais conditionne la commonalisation.
- Les appels depuis `Moulinage` et `BordereauxC` sont couverts par les replays de ces écrans.
