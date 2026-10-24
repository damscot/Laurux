# CalcRem — Dépendances

> Source : `.src/Utils/CalcRem.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CalcRem.class` — classe, formulaire associé `CalcRem.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `PointBase`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_HistoFac`, `Fiches_HistoLigfac`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** (manqué par l'heuristique, appel par nom saisi) : `Prgm.class:61`
  (`If Prog = "CalcRem" Then CalcRem.show`). `Prgm` est ouvert depuis `Fmenu.class:1350` et `:2218`.
- `Music.Play` est appelé sans `Music.Load` dans cette classe : le son joué est celui chargé en
  dernier par un autre écran (état global implicite du composant `gb.sdl2.audio`/`Music`).
- Tables : `Fiches_HistoFac`, `Fiches_HistoLigfac` via `Cbase.Table`.
- Pas de dépendance circulaire ; aucun ordre de rework contraint.
