# Recup — Tests

> Source : `.src/Utils/Recup.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECUP-T01 | gbtest | `Utilisateur` | utilisateur courant | `User.Name` | `tests/utilisateur/` | implémenté |
| RECUP-T02 | gbtest | `Group` (avant suppression) | `HOME` de test avec `~/tmp` | nom du groupe de référence | `tests/group/` | implémenté |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** sous le même utilisateur.
- T02 est retiré avec RECUP-002.
- **Phase 2** : `.src/Tests/Utils/RecupTest.test` ; valeurs comparées au système (`id -un`, `id -gn`) pour rester indépendantes de la machine.
