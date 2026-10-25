# RazRlvb — Tests

> Source : `.src/Archivages/RazRlvb.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).**

Les tests comparent le **dump normalisé de `Fiches_Rappro`** (et de `Fiches_Mvt*` pour vérifier
qu'il est inchangé) avant et après la purge, sur un jeu dérivé, **horloge figée** (la date proposée
par `DateChooser1` dépend du jour courant). Les valeurs attendues sont produites dans le clone
**Laurux non modifié** : l'anomalie A01 (purge malgré « Non ») est figée telle quelle.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZRLVB-T01 | replay | Purge nominale | jeu `rappro_base` : 2 comptes, relevés avant, **le jour même** et après la date ; date choisie, « Lancer », « Oui » | relevés strictement antérieurs supprimés, relevés du jour et postérieurs conservés ; message « N relevés » | `tests/razrlvb_nominal/` | à faire |
| RAZRLVB-T02 | replay | Abandon (« Non ») | même jeu ; « Lancer », « Non » | comportement actuel figé : **mêmes suppressions que T01**, aucun fichier `EffaceR.sql` créé (A01) | `tests/razrlvb_abandon/` | à faire |
| RAZRLVB-T03 | replay | Rien à purger | date antérieure à tous les relevés | table inchangée ; message « 0 relevés » | `tests/razrlvb_vide/` | à faire |
| RAZRLVB-T04 | replay | Sauvegarde | T01 avec `mysqldump` disponible puis indisponible (`PATH` réduit) | fichier `~/Sauve/<Base>EffaceR.sql` présent dans le 1er cas ; purge faite **dans les deux cas** (A02 figée) | `tests/razrlvb_sauvegarde/` | à faire |
| RAZRLVB-T05 | replay | Effet sur le pointage | après T01, ouverture de `Pointage` sur un compte dont tous les relevés sont purgés | solde de départ proposé (comportement figé, A04) | `tests/razrlvb_pointage/` | à faire |
| RAZRLVB-T06 | replay | SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé (dates écrites par `Subst`) | comportement figé (aujourd'hui : aucune suppression attendue, A03 à confirmer) | `tests/razrlvb_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (aucun relevé) + jeu dérivé `rappro_base.sql` : `Fiches_Rappro`
  (comptes `512000` et `512100`, 3 relevés chacun autour de la date limite, dont un daté du jour
  limite) et quelques `Fiches_Mvt` pointées (`nrlv`) pour T05.
- **Horloge** : figée (faketime ou date du conteneur) ; la date limite est choisie dans le
  `DateChooser` par le scénario.
- **Instrumentation** : l'écran n'appelle pas `Utils.Observers` ; il faut l'instrumenter dans les
  deux clones (décision de phase 2, comme pour `Moulinage`) ou tester `Purge` (RAZRLVB-005) en
  gbtest si elle est rendue accessible. Les dialogues `Message.Question`/`Message.Info` doivent être
  pilotés par le rejeu.
- **Comparaison** : dump normalisé de `Fiches_Rappro` et `Fiches_Mvt*` ; présence et taille non
  nulle du fichier de sauvegarde (contenu non comparé : il dépend de l'horodatage).
- **Non testable automatiquement** : le mot de passe visible dans `ps` (A02) ; la lecture vocale de
  `Syntheses.Message`.
