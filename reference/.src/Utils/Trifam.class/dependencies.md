# Trifam — Dépendances

> Source : `.src/Utils/Trifam.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Trifam.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/Edart4.class` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant`, `soustotpa`, `soustotpmp` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant`, `soustotpa`, `soustotpmp` |
| `.src/Gestion/Stockmvt.class` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |
| `.src/Statistiques/Histocliart.class` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Fam`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Résultat de `deps.py` confirmé par grep : 5 appelants (`Edart4`, `Edinv`, `Edinv1`, `Stockmvt`,
  `Histocliart`), tous avec le même idiome `New Trifam("1")` puis `TriArticles($familles.enfant)`
  récursif. `Edinv`/`Edinv1` utilisent les sous-totaux `soustotpa`/`soustotpmp`.
- Le paramètre `ipr` est aussi lu par `textfamille` (même clé de configuration).
- Pas de dépendance circulaire. Rework indépendant, sauf la commonalisation du parcours qui touche
  les 5 appelants.
