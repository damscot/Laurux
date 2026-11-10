# Epurfour — Tests

> Source : `.src/Utils/Epurfour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EPURFOUR-T01 | replay | Effacement | `Laurux01.sql` ; « Appel programme » `Epurfour` | diff `Fiches_Art` : `art_cfour` vide partout | `tests/effacement/` | implémenté (`.hidden/Tests/Utils/assets/epurfour_effacement/`, `art_cfour` mis à NULL) |
| EPURFOUR-T02 | replay | Table vide | `Fiches_Art` vide | aucun message, aucune erreur | `tests/table_vide/` | implémenté |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; comparaison par dump (le nombre de requêtes changera
  avec EPURFOUR-002).
- **Phase 2 (implémentation)** : T01 = scénario `.hidden/Tests/Utils/assets/epurfour_effacement/` (Appel
  programme `Menu282`, saisie « Epurfour », Lancer, message validé ; jeu `datasets/epurfour.sql` qui renseigne
  `art_cfour`) ; T02 vérifié en gb.test (`.src/Tests/Utils/EpurfourTest.test` : table vidée, aucun message).
