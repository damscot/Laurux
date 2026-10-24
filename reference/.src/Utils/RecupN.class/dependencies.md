# RecupN — Dépendances

> Source : `.src/Utils/RecupN.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/RecupN.class` — classe
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

`Fiches_Mvt`, `Fiches_Mvt1`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `.src/Communs/Prgm.class:64` (saisie manuelle « RecupN »).
- Écrit dans `Fiches_Mvt` sans recalcul des sommes SHA1 (`Utils/Sha1Calc.module`) : impact sur le
  contrôle d'inaltérabilité à confirmer avec la documentation de `Sha1Calc`.
- Dernière modification git : 2017 (version 3.63) ; constante 424 propre à une base de production.
