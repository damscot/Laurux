# GedR — Tests

> Source : `.src/Utils/GedR.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : scénarios `replay` sur le jeu GED commun (`Laurux01.sql` + `ged.sql`, voir
[`LGed`](../LGed.class/test.md)). Comparaison du dump de `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` et
des lignes `Exec_SQL` du log.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GEDR-T01 | replay | Filtres | ouverture ; type Clients ; tags `fac, 2024` ; colonne « url » | requêtes `Exec_SQL` identiques | `tests/replay_filtres/` | à faire |
| GEDR-T02 | replay | Sélection multiple | clic sur 2 lignes, tout sélectionner filtré, tout désélectionner | compteur et requêtes identiques | `tests/replay_selection/` | à faire |
| GEDR-T03 | replay | Suppression | 2 documents sélectionnés → Supprimer | lignes supprimées + épuration globale | `tests/replay_suppression/` | à faire |
| GEDR-T04 | replay | Changement d'URL | voir LBOX-T01 (partagé) ; une URL contenant deux fois la base | `url` modifiées (remplacement multiple figé, A03) | `tests/replay_changer_url/` | à faire |
| GEDR-T05 | replay | Suppression de tags | voir LBOX-T03 (partagé) | `Docs_Tag`, `Fiches_Tag` | `tests/replay_supprimer_tags/` | à faire |
| GEDR-T06 | replay | Ajout de tags | voir LBOX-T04 (partagé) ; un des tags déjà porté par un document | lignes ajoutées ; erreur éventuelle figée (LGED-A02) | `tests/replay_ajout_tags/` | à faire |
| GEDR-T07 | replay | Édition | 1 document → Éditer → modifier le code → Enregistrer | `Docs_Ged.code` modifié, liste rafraîchie | `tests/replay_edition/` | à faire |
| GEDR-T08 | replay | Filtre avec guillemet (anomalie A02) | tag saisi `a"b` | erreur SQL figée (message) | `tests/replay_filtre_guillemet/` | à faire |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié puis rejeu sur les deux clones ;
  `lind` masqués dans les dumps.
- **Non testable automatiquement** : ouverture des documents (`Visualiseur`), aide HTML.
- **SQLite** : l'écran ne fonctionne pas (A01) ; pas de replay SQLite tant que l'anomalie n'est pas
  traitée.
