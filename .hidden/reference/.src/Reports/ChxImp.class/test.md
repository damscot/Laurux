# ChxImp — Tests

> Source : `.src/Reports/ChxImp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La fenêtre n'est jamais ouverte par l'application : aucun scénario `replay` ne peut l'atteindre
et aucune fonction n'est appelable en gb.test sans GUI. Le seul test prévu dépend de la décision
sur CHXIMP-A01.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHXIMP-T01 | gbtest | (si CHXIMP-A01 est refusée et CHXIMP-A02 réalisée) `ListeImprimantes` | sorties `lpstat -p` enregistrées : 2 imprimantes, ligne « Rendering… », ligne vide, « aucune destination », locale fr et C | liste attendue figée sur le comportement actuel (mots parasites compris), sans « Out of bounds » si A02 le corrige | `tests/chximp_lpstat/` | à faire |

## Détail des tests

- **Non testable automatiquement** : l'écran lui-même (jamais ouvert, pas d'`Utils.Observers`).
- **Si CHXIMP-A01 est validée** (suppression), le test est retiré.
