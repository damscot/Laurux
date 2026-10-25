# ACom — Tests

> Source : `.src/Affichages/ACom.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de consultation (aucune écriture en base) : la comparaison porte sur les lignes `Exec_SQL`
et, une fois l'écran instrumenté, sur le contenu de `Colrcp3`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ACOM-T01 | replay | Détail d'une commande fournisseur | `Articles` : article commandé, liste des commandes fournisseurs, activation d'une commande (lignes article et article supprimé) | en-tête et lignes de référence ; figer la quantité brute (A02) | `tests/detail_commande/` | à faire |
| ACOM-T02 | replay | Fournisseur supprimé | commande d'un fournisseur absent de `Fiches_Four` | figer l'erreur (A01) | `tests/fournisseur_absent/` | à faire |
| ACOM-T03 | replay | Fermeture | Échap et F2 dans `Codecli` ; bouton `Button3` | fenêtre fermée | `tests/fermeture/` | à faire |
| ACOM-T04 | gbtest | `LignesCommande` (après ACOM-004) | commande existante, commande inconnue | nombre de lignes et champs de référence | `tests/lignes_commande/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; A01 et A02 figées.
- **Données** : jeu dérivé `commandes_four` : deux commandes (`Fiches_Entcom`, `Fiches_Ligcom`) d'un
  article, dont une d'un fournisseur ensuite supprimé, et une ligne d'un article supprimé.
- **Instrumentation** : pas de `Utils.Observers(Me)` et `Colrcp3` sans `_Click` (`replay_missing`) :
  les replays ne sont possibles qu'après instrumentation (phase 2) et sans clic dans `Colrcp3`.
