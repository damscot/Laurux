# CheckProg — Tests

> Source : `.src/Utils/CheckProg.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHECKPROG-T01 | gbtest | `Chk` | `"sh"`, `"programme_inexistant"`, `""` | `True`, `False`, valeur de référence ; `~/temp_prog` absent après l'appel | `tests/chk/` | implémenté |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié**, avec un `HOME` de test isolé.
- **Phase 2 (implémentation)** : `.src/Tests/Utils/CheckProgTest.test` (T01). Attention : `Chk` écrit et
  supprime `User.Home/temp_prog`, c'est-à-dire dans le vrai HOME (le runner n'isole pas `User.Home`).
