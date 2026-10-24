# Typec — Tests

> Source : `.src/Gestion/Tables/Typec.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Mêmes scénarios que [Centrales](../Centrales.class/test.md), sur `Fiches_Typec`. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TYPEC-T01 | replay | Création | menu Types clients ; `04`, `Menuisier` ; Enregistrer | ligne insérée | `tests/creation/` | à faire |
| TYPEC-T02 | replay | Modification | clic `01` ; libellé `Maçon2` | UPDATE | `tests/modification/` | à faire |
| TYPEC-T03 | replay | Suppression d'un type utilisé | sélection `01` référencé par une remise par type ; Supprimer | type supprimé, remise orpheline (A02 figée) | `tests/suppression_utilise/` | à faire |
| TYPEC-T04 | replay | Code avec apostrophe | code `0'` ; Enregistrer | erreur SQL (A01 figée) | `tests/apostrophe/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (types `01` à `03`) ; T03 sur un jeu dérivé avec une ligne
  `Fiches_RemTypec` pour le type `01`.
- **Comparaison** : dump normalisé de `Fiches_Typec` et `Fiches_RemTypec`.
- **Non testable automatiquement** : couleurs `OBS_*`, aide (`Doc.Open`).
