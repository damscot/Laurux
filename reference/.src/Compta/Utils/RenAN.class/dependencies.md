# RenAN — Dépendances

> Source : `.src/Compta/Utils/RenAN.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/RenAN.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Mvtoc`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Lancement** : uniquement `Prgm.class:74` (`If Prog = "RenAN" Then RenAN.run()`).
- `Fiches_Mvtoc` : absente de `db_control.csv` (0 occurrence), de `Cbase.module` et de
  `LauruxMaj.module` (grep) ; reliquat d'une ancienne structure.
- Aucun appel dynamique ; aucune dépendance circulaire. Retrait à faire avec `Prgm` (PRGM-A06).
