# modCrBcode — Tests

> Source : `.src/Utils/modCrBcode.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MODCRBCODE-T01 | gbtest | Compilation sans le module | suppression du fichier dans le clone de travail | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |

## Détail des tests

- Le module n'a aucun appelant : aucun scénario utilisateur ne l'exerce. Le seul test pertinent est
  la vérification de compilation après suppression (MODCRBCODE-001).
- Un test de rendu (image `Draw` comparée pixel à pixel) n'est pas prévu : coût élevé pour du code mort.
