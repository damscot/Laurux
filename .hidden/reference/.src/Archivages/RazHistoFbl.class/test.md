# RazHistoFbl — Tests

> Source : `.src/Archivages/RazHistoFbl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).**

Comparaison du **dump normalisé de `Fiches_Entrecpt` et `Fiches_Ligrecpt`** avant/après, jeu dérivé,
horloge figée. Valeurs attendues produites dans le clone **Laurux non modifié** (A01 figée).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZHISTOFBL-T01 | replay | Purge nominale | jeu `receptions_base` : réceptions validées avant, le jour même et après la date (numéros distincts) ; « Oui » | réceptions strictement antérieures et leurs lignes supprimées | `tests/razhistofbl_nominal/` | à faire |
| RAZHISTOFBL-T02 | replay | Abandon | « Non » | tables inchangées | `tests/razhistofbl_abandon/` | à faire |
| RAZHISTOFBL-T03 | replay | Même numéro, deux fournisseurs | réception `F1/1234` antérieure, `F2/1234` postérieure | comportement figé : **les deux** supprimées avec leurs lignes (A01) | `tests/razhistofbl_meme_numero/` | à faire |
| RAZHISTOFBL-T04 | replay | Réception non validée | réception `validee = 0` antérieure | comportement figé : supprimée (A03) | `tests/razhistofbl_non_validee/` | à faire |
| RAZHISTOFBL-T05 | replay | Effet sur le stock | inventaire `Fiches_HisInvT` antérieur à la date, purge, puis recalcul `Calcstock` | stock recalculé figé (diminué des réceptions purgées, A03) | `tests/razhistofbl_stock/` | à faire |
| RAZHISTOFBL-T06 | replay | Sauvegarde et SQLite | T01 sans `mysqldump` ; T01 sur `Laurux01.sqlite` | purge faite sans sauvegarde (A02) ; SQLite figé (A04) | `tests/razhistofbl_sauvegarde_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `receptions_base.sql` (2 fournisseurs, 6 réceptions,
  lignes, un inventaire `Fiches_HisInvT` pour T05). À rapprocher des jeux du lot Gestion (`Achat`,
  `ValidBR`).
- **Horloge** : figée ; date limite choisie par le scénario.
- **Instrumentation** : écran sans `Utils.Observers` (décision de phase 2).
- **Comparaison** : dump des deux tables ; pour T05, `Fiches_Art.art_stkdep` après recalcul.
