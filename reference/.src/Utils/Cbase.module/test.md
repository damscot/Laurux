# Cbase — Tests

> Source : `.src/Utils/Cbase.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CBASE-T01 | gbtest | Table de correspondance complète | les 119 clés extraites du source par `gen_input.py` | 119 noms physiques de référence | `tests/table_complete/` | à faire |
| CBASE-T02 | gbtest | Clés inconnues et casse | `""`, `Null`, `"tabart"`, `"TABART"`, `"TabBanques"`, `"TabCdocs"`, `"TabFdocs"`, `"Inconnue"` | `""` pour chacune | `tests/cles_inconnues/` | à faire |
| CBASE-T03 | gbtest | Cohérence avec `db_control.csv` | cibles de T01 | liste figée des cibles absentes du CSV (`Art_Saisis`, `Ecrs`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_Stat`, `Totalisation`) | `tests/coherence_csv/` | à faire |
| CBASE-T04 | gbtest | Performance | 1 000 000 d'appels sur des clés en début, milieu et fin de liste | durée de référence (`gbx3 -p`) | `tests/perf_table/` | à faire |

## Détail des tests

- Les valeurs attendues de T01/T02 sont produites par l'exécution du module dans le clone **Laurux
  non modifié** ; `gen_input.py` extrait la liste des clés du source de référence (regex
  `Case "(…)"`), ce qui garantit qu'aucune clé n'est oubliée après réécriture.
- T03 n'exécute pas de SQL : il compare des listes (garde-fou documentaire).
- Couverture visée : 100 %.
