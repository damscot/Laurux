# Calcstock — Dépendances

> Source : `.src/Utils/Calcstock.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Calcstock.class` — classe, formulaire associé `Calcstock.form`
- Handlers GUI détectés : 6
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Art_man`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Utils/Cstock.module` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cstock` | `Calc_stock` |
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Caisses`, `Fiches_EntTickets`, `Fiches_EntTicketz`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `Art_man`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants manqués** : `Fmenu.class:1642` (`Calcstock.ShowModal`) ; `Cstock.module:28,31` lit
  `Calcstock.Cbx.Value` et `Calcstock.Cbx2.Value` (contrôles publics du `.form`). Dépendance
  circulaire `Calcstock` ↔ `Cstock`.
- **Effet indirect** : `Validinv.class:190` → `Cstock.Calc_stock` → instance automatique cachée de
  `Calcstock` (exécution de `_New` : `Music.Load`, `Utils.Observers`).
- **Faux positifs « portée réductible »** : `Cbx_Click`, `Cbx2_Click`, `Cbx3_Click` (handlers) ;
  `Bsel`/`Bval` (écrits par `TriArticles` via `Object.SetProperty`). Réellement réductible :
  `SelectionArt` ; `Art_man` est mort.
- **Ordre de rework** : avec `Cstock` (CSTOCK-003) et `Validinv` dans le même commit.
