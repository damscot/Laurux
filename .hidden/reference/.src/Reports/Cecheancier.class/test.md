# Cecheancier — Tests

> Source : `.src/Reports/Cecheancier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : aucun comportement à figer.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CECHEANCIER-T01 | gbtest | Non-régression de la suppression | `gbc3 -agt` puis `./Laurux -T all` après suppression ; `grep -rni "\bcecheancier\b" .src .project` | compilation sans erreur, suite verte, aucune occurrence | `tests/suppression/` | à faire |

## Détail des tests

- Pas de valeur attendue à générer : la classe n'est jamais chargée. L'échéancier réel est couvert
  par les tests de [Ccompta](../Ccompta.class/test.md) (CCOMPTA-T02) et d'`Echeancier`.
