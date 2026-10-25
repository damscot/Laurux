# RazClientd — Tests

> Source : `.src/Archivages/RazClientd.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).** Si RAZCLIENTD-A01 (suppression de l'écran)
> est validée, ces tests deviennent sans objet.

Comparaison du **dump normalisé de `Fiches_Clid`** avant/après, jeu dérivé, horloge figée. Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZCLIENTD-T01 | replay | Purge nominale | jeu `clid_base` : clients avec `ddate` avant, le jour même et après la date ; « Lancer », « Oui » | seuls les clients strictement antérieurs supprimés ; message « N clients » | `tests/razclientd_nominal/` | à faire |
| RAZCLIENTD-T02 | replay | Abandon | « Lancer », « Non » | table inchangée, pas de sauvegarde | `tests/razclientd_abandon/` | à faire |
| RAZCLIENTD-T03 | replay | Table vide (cas réel) | `Laurux01.sql` seul | « 0 clients » ; fichier `~/Sauve/<Base>EffaceD.sql` créé | `tests/razclientd_vide/` | à faire |
| RAZCLIENTD-T04 | replay | Collision de sauvegarde | T01 puis `RAZDEVIS-T01` | le fichier `EffaceD.sql` ne contient plus que le 2e dump (comportement figé, A02) | `tests/razclientd_sauvegarde/` | à faire |
| RAZCLIENTD-T05 | replay | SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé | comportement figé (A03, à confirmer) | `tests/razclientd_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) + jeu dérivé `clid_base.sql` (5 fiches `Fiches_Clid`,
  `ddate` réparties autour de la date limite).
- **Horloge** : figée ; date limite choisie par le scénario dans le `DateChooser`.
- **Instrumentation** : écran sans `Utils.Observers` (à instrumenter dans les deux clones, décision
  de phase 2) ; dialogues `Message.Question`/`Message.Info` pilotés par le rejeu.
- **Comparaison** : dump de `Fiches_Clid` ; existence du fichier de sauvegarde.
- **Non testable** : mot de passe visible dans `ps` ; lecture vocale.
