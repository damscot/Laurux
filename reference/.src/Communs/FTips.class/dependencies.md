# FTips — Dépendances

> Source : `.src/Communs/FTips.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/FTips.class` — classe, formulaire associé `FTips.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Start.module` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Fcolr`, `Observers` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Appelants** : `Start.module:280, 328-330` (`Dim Tips As FTips`, `New FTips`, `Show`) et
  `Fmenu.Menu125_Click` (auto-instance `FTips.Show`), tous deux détectés.
- **Fichier de données** : `tips/tips.fr` (relatif au projet, 24 sections) — dépendance non visible
  pour `deps.py`.
- Aucune table, aucun appel dynamique, pas de dépendance circulaire.
