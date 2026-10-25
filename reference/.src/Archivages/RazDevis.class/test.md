# RazDevis — Tests

> Source : `.src/Archivages/RazDevis.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).**

Comparaison du **dump normalisé** de `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_BlM`, `Fiches_LigblM`,
`Fiches_AdrlivBL`, `Fiches_EntMat`, `Fiches_Suivis` avant/après, jeu dérivé, horloge figée. Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZDEVIS-T01 | replay | Purge nominale | jeu `devis_base` : devis `D` avant, le jour même et après la date ; BL `B` et factures `F` antérieurs ; « Oui » | seuls les devis strictement antérieurs et leurs lignes supprimés ; BL/F intacts ; `Fiches_AdrlivBL` du devis conservée (A01 figée) | `tests/razdevis_nominal/` | à faire |
| RAZDEVIS-T02 | replay | Option matériel cochée / décochée | `/Soc01/Materiel = 1` ; devis `BlM` antérieurs | purgés seulement si la case est cochée | `tests/razdevis_materiel/` | à faire |
| RAZDEVIS-T03 | replay | Abandon | « Non » | tables inchangées | `tests/razdevis_abandon/` | à faire |
| RAZDEVIS-T04 | replay | Sauvegarde | T01 puis `RAZCLIENTD-T01` ; T01 sans `mysqldump` | `EffaceD.sql` écrasé par le second écran ; purge sans sauvegarde (A02) | `tests/razdevis_sauvegarde/` | à faire |
| RAZDEVIS-T05 | replay | SQLite | T01 sur `Laurux01.sqlite` | comportement figé (A04, à confirmer) | `tests/razdevis_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `devis_base.sql` (devis, BL, factures, adresse de
  livraison, matériel `Fiches_EntMat`, suivi `Fiches_Suivis`).
- **Horloge** : figée ; date limite choisie par le scénario.
- **Instrumentation** : écran sans `Utils.Observers` (décision de phase 2).
- **Comparaison** : dump des tables listées.
