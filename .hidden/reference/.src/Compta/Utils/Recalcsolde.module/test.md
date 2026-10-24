# Recalcsolde — Tests

> Source : `.src/Compta/Utils/Recalcsolde.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module mort : aucun scénario utilisateur ne l'exécute. Un seul test d'information justifie sa
suppression.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECALCSOLDE-T01 | gbtest | Équivalence avec `Csolde.Recalc_solde` | `Laurux01.sql` ; soldes remis à zéro, appel de `Recalcsolde.Calc`, dump ; restauration, appel de `Csolde.Recalc_solde`, dump | dumps `Fiches_Comptes` identiques | `tests/recalcsolde_equivalence/` | à faire |

## Détail des tests

- Test d'information exécuté dans le clone **Laurux non modifié** avant la suppression
  (RECALCSOLDE-001) ; il disparaît avec le module.
