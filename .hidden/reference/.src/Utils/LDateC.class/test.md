# LDateC — Tests

> Source : `.src/Utils/LDateC.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe purement GUI (dialogue modal) : tests de type `replay` uniquement, au travers d'un champ
`TextReg` de type date.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LDATEC-T01 | replay | Sélection validée | écran `Saisecrit`, champ date : F2, choix d'un jour, double-clic | texte du champ = date choisie (`dd.mm.yyyy`) ; écriture saisie ensuite avec cette date dans `Fiches_Mvt` | `tests/replay_selection/` | à faire |
| LDATEC-T02 | replay | Annulation puis nouvelle sélection | même écran : F2, Échap ; F2, choix, double-clic | 1er : champ inchangé ; 2e : champ modifié (vérifie la remise à zéro d'`Escape`) | `tests/replay_annulation/` | à faire |
| LDATEC-T03 | replay | Champ date-heure | écran `LGed` (champ `fdte`, `EstDateTime`) : F2, choix | format `dd.mm.yyyy hh:nn` | `tests/replay_dateheure/` | à faire |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié (`./Laurux -l --logfile …`), rejeu sur
  les deux clones ; comparaison du texte affiché (via le log) et des tables écrites par l'écran.
- **Données** : `Laurux01.sql`.
- **Non testable en gb.test** : toute la classe (fenêtre modale).
