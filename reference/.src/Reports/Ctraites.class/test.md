# Ctraites — Tests

> Source : `.src/Reports/Ctraites.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : aucun comportement à figer.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CTRAITES-T01 | gbtest | Non-régression de la suppression | `gbc3 -agt` puis `./Laurux -T all` après suppression ; `grep -rni "\bctraites\b" .src .project` | compilation sans erreur, suite verte, aucune occurrence | `tests/suppression/` | à faire |

## Détail des tests

- Pas de valeur attendue à générer. L'impression réelle des traites est couverte par
  [Ccompta](../Ccompta.class/test.md) (CCOMPTA-T05) et les tests de `Traites`/`Lcr`.
