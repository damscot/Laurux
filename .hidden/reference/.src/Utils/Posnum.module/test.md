# Posnum — Tests

> Source : `.src/Utils/Posnum.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| POSNUM-T01 | gbtest | `Pos` (avant suppression) | `"0"` à `"21"`, `""`, `"abc"` | ordinaux de référence | `tests/pos/` | à faire |

## Détail des tests

- Test de caractérisation produit dans le clone **Laurux non modifié** ; il est retiré avec la
  suppression du module (POSNUM-001). Le contrôle de non-régression de la suppression est la
  compilation `gbc3 -agt`.
