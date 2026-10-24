# Epurfour — Tests

> Source : `.src/Utils/Epurfour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EPURFOUR-T01 | replay | Effacement | `Laurux01.sql` ; « Appel programme » `Epurfour` | diff `Fiches_Art` : `art_cfour` vide partout | `tests/effacement/` | à faire |
| EPURFOUR-T02 | replay | Table vide | `Fiches_Art` vide | aucun message, aucune erreur | `tests/table_vide/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; comparaison par dump (le nombre de requêtes changera
  avec EPURFOUR-002).
