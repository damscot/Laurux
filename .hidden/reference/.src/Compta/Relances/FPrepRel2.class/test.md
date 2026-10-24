# FPrepRel2 — Tests

> Source : `.src/Compta/Relances/FPrepRel2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran inaccessible depuis l'application (code mort) : aucun scénario replay ne peut l'atteindre
sans modifier le code. Le seul test utile vérifie que la suppression proposée ne casse rien.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPREPREL2-T01 | replay | Non-régression après suppression | compilation `gbc3 -agt` ; rejouer les replays de `FEditrel` (T02, T06) | compilation sans erreur ; diffs vides | `tests/suppression/` | à faire |

## Détail des tests

- Le test n'a de sens qu'avec l'anomalie FPREPREL2-A01 validée ; il réutilise les données et les
  valeurs attendues des tests `FEditrel`.
- Les handlers de l'écran ne sont pas testables (aucun point d'entrée).
