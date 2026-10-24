# TypeClient — Dépendances

> Source : `.src/Compta/Utils/TypeClient.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/TypeClient.class` — classe, hérite de `TreeView`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Balance.class` | `<form>`, `where` |
| `.src/Compta/Impressions/BalanceM.module` | `<type>`, `where` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `<form>`, `where` |
| `.src/Compta/Impressions/EdNlettrees.class` | `<form>`, `where` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Typec`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Contrôle posé dans des `.form`** : `Balance.form:173`, `EdNjustifiees.form:85`,
  `EdNlettrees.form:116` (`{ TypeClient1 TypeClient … Mode = Select.Multiple }`) ; propriété
  `where` lue par `Balance.class:646`, `EdNjustifiees.class:266-267`, `EdNlettrees.class:365-382`
  et `BalanceM.module:81-82` (paramètre `typecl As TypeClient` de `BalanceM.Imprime`).
- **Replay** : `ReplayObserver` reconnaît les contrôles par `Object.Class(ctx).Name` (`"TreeView"`,
  `"ColumnView"`…) ; la classe d'un `TypeClient` s'appelle `"TypeClient"`, donc la sélection dans
  ce contrôle n'est probablement **pas rejouée** (à confirmer en phase 2 ; adaptation de
  `ReplayObserver` à prévoir, par exemple via `Object.Is(ctx, "TreeView")`).
- Aucun appel dynamique ; aucune dépendance circulaire.
