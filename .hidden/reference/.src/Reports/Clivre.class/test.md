# Clivre — Tests

> Source : `.src/Reports/Clivre.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : aucun comportement observable à figer. Le seul test vérifie que la suppression ne
casse rien.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CLIVRE-T01 | gbtest | Non-régression de la suppression | `gbc3 -agt` puis `./Laurux -T all` après suppression du fichier ; `grep -rni "\bclivre\b" .src .project` | compilation sans erreur, suite verte, aucune occurrence | `tests/suppression/` | à faire |

## Détail des tests

- Pas de valeur attendue à générer dans le clone de référence : la classe n'est jamais chargée.
- Les replays des gabarits voisins (`Cfacture`, `Cticket`, caisse) restent la protection
  principale : ils n'utilisent pas `Clivre`.
- **Couverture** : sans objet (fichier supprimé).
