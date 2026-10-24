# Agenda — Tests

> Source : `.src/Utils/Agenda.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay`. La comparaison porte sur le dump de `Fiches_Agenda` (colonne `lind`
masquée) et sur les lignes `Exec_SQL` du log.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| AGENDA-T01 | replay | Création d'une action | Menu Agenda ; date fixe ; clic sur 08h15 ; saisie ; Valider | 1 ligne `Fiches_Agenda` (`daction`, `haction = "08h15"`, `nuser`) | `tests/replay_creation/` | à faire |
| AGENDA-T02 | replay | Modification d'une action | base avec une action existante ; clic ; nouveau texte ; Valider | `iaction` modifié | `tests/replay_modification/` | à faire |
| AGENDA-T03 | replay | Affichage multi-utilisateur (anomalies figées) | base avec la même action pour `nuser` = A et B ; ouverture par A ; modification | grille affiche les deux ; `UPDATE` modifie les deux lignes (A01/A02 figées) | `tests/replay_multi_user/` | à faire |
| AGENDA-T04 | replay | Changement de date | sélection d'une autre date dans `DateChooser1` | grille rechargée (log `Exec_SQL`) | `tests/replay_changement_date/` | à faire |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié (`./Laurux -l --logfile …`), rejeu sur
  les deux clones, diff du dump normalisé de `Fiches_Agenda`.
- **Données** : `Laurux01.sql` + insertion de lignes `Fiches_Agenda` pour T02/T03 ; la date
  sélectionnée est fixe (pas la date du jour) pour que le log soit reproductible. `nuser` dépend de
  `User.Name` : le runner masque ou substitue cette valeur.
- **Non testable automatiquement** : horloge, quantième, boutons `xdg-open` (vérification manuelle).
