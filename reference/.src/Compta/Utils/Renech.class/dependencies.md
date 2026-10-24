# Renech — Dépendances

> Source : `.src/Compta/Utils/Renech.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Renech.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Mvt`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Lancement** : uniquement `Prgm.class:84` (`If Prog = "Renech" Then Renech.Run()`, casse
  différente de la déclaration `run` : Gambas est insensible à la casse).
- **Fichier d'entrée** : `~/Dtech.txt`, produit (à `~/tmp/Dtech.txt`) par
  [`RecupDech`](../RecupDech.class/dependencies.md) ; dépendance par fichier non vue par `deps.py`.
- Aucun appel dynamique ; aucune dépendance circulaire. À traiter avec `RecupDech` et `Prgm`.
