# RazHistoFac — Tests

> Source : `.src/Archivages/RazHistoFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).**

Comparaison du **dump normalisé** de `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_HistoFacM`,
`Fiches_HistoLigfacM` et des tables liées (`Fiches_HisentMat`, `Fiches_Suivis`, `Fiches_Traites`,
`Docs_Ged`, inchangées) avant/après, jeu dérivé, horloge figée. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZHISTOFAC-T01 | replay | Purge nominale sans option matériel | jeu `factures_archives` : factures avant, le jour même et après la date ; « Oui » | factures strictement antérieures et leurs lignes supprimées ; `HistoFacM` intacte ; tables liées intactes (orphelins figés, A02) | `tests/razhistofac_nominal/` | à faire |
| RAZHISTOFAC-T02 | replay | Option matériel, case cochée | `/Soc01/Materiel = 1`, case cochée | les deux familles purgées ; message = total | `tests/razhistofac_materiel/` | à faire |
| RAZHISTOFAC-T03 | replay | Option matériel, case décochée | `/Soc01/Materiel = 1`, case décochée | seule `HistoFac` purgée | `tests/razhistofac_materiel_non/` | à faire |
| RAZHISTOFAC-T04 | replay | Abandon | « Non » | tables inchangées | `tests/razhistofac_abandon/` | à faire |
| RAZHISTOFAC-T05 | replay | Interruption | arrêt de la 1re `ProgBar`, case cochée | purge partielle des factures, purge complète des factures entretien (comportement figé) | `tests/razhistofac_interruption/` | à faire |
| RAZHISTOFAC-T06 | replay | Sauvegarde et SQLite | T01 sans `mysqldump` ; T01 sur `Laurux01.sqlite` | purge sans sauvegarde (A03) ; SQLite figé (A04) | `tests/razhistofac_sauvegarde_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `factures_archives.sql` (6 factures + lignes, 2 factures
  entretien, une ligne `Fiches_HisentMat`, `Fiches_Suivis`, `Fiches_Traites` et `Docs_Ged` liées à une
  facture purgée). Jeu réutilisable par `ARCHIVES-T*`.
- **Horloge** : figée ; date limite choisie par le scénario.
- **Instrumentation** : écran sans `Utils.Observers` (décision de phase 2).
- **Comparaison** : dump des tables ci-dessus.
- **Non testable automatiquement** : obligations légales (A01, décision utilisateur).
