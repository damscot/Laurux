# gridv — Tests

> Source : `.src/Utils/gridv.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module mort : aucun comportement observable à figer.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GRIDV-T01 | gbtest | Absence de référence | `gbc3 -agt` après suppression ; `grep -rniE 'gridv\.|ajoustat' .src` | compilation sans erreur, aucune occurrence de code | `tests/suppression/` | à faire |

## Détail des tests

- T01 est un contrôle de build ; il peut être porté par le script de validation de phase 4.
- Les replays de [`gridvi`](../gridvi.class/test.md) servent de non-régression.
