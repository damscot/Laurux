# SetColors — Dépendances

> Source : `.src/Utils/SetColors.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/SetColors.class` — classe, formulaire associé `SetColors.form`
- Handlers GUI détectés : 11

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CFormat` | `<type>`, `Alignment`, `Background`, `Font`, `Foreground`, `ToString`, `_get` |
| `FSetFormat` | `Run` |
| `Start` | `LocalSettings` |
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif de `deps.py`** : la classe est utilisée par `Communs/Fmenu.class:1527`
  (`SetColors.ShowDialog`, méthode héritée de `Form`, donc non indexée). « Utilisé par » vide est
  inexact.
- **Faux positif** : `Coul_DblClick` signalé « portée réductible » est le handler du groupe
  d'événements `Coul` déclaré dans `.src/Utils/SetColors.form` (`{ Stk TextBox Coul` …).
- Formulaire associé : `.src/Utils/SetColors.form` (6 `ToolButton`, panneaux 1-5, 8, 9, 21
  `TextBox` du groupe `Coul` avec `Tag` = clé de configuration). Pas un `UserControl`.
- `CFormat[...]` (`_Get`) aux lignes 47 et 77 n'est pas compté par `deps.py`.
- Lecture indirecte : les clés écrites (`/Coul/Others`, `/Coul/Coulfonds`) sont lues par
  `Start.Coul` (`Start.module:213-235`) et `Utils.FColr` (zones `/Coul/Znss`, `/Coul/Focus`).
- Ordre de rework : après `CFormat` (CFORMAT-004) et en même temps que `FSetFormat`.
