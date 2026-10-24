# Visualiseur — Tests

> Source : `.src/Utils/Visualiseur.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISUALISEUR-T01 | gbtest | `Prog` avec `CmdVis` | `/Soc01/caisse/CmdVis` = script factice qui journalise ses arguments ; fichier simple puis fichier avec espace | ligne de commande journalisée de référence | `tests/cmdvis/` | à faire |
| VISUALISEUR-T02 | gbtest | `Prog` sans `CmdVis` | `xdg-open` factice dans le `PATH` (utilisé par `Desktop.Open`) | appel journalisé | `tests/desktop_open/` | à faire |

## Détail des tests

- Le `Shell` est asynchrone : le test attend la création du journal (délai borné).
- Références capturées dans le clone **Laurux non modifié**. Les éditions qui appellent `Prog` sont
  testées dans leurs propres fichiers (replays) avec la même commande factice, ce qui permet de
  récupérer le PDF produit.
