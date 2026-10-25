# Statbase — Dépendances

> Source : `.src/Statistiques/Statbase.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/Statbase.class` — classe, formulaire associé `Statbase.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_EntTicketz`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_Mo`, `Fiches_Mvt`, `Fiches_PrdComp`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `Fmenu.Menu250_Click` (`Fmenu.class:2062`, `Statbase.ShowModal()`).
- **Pas une classe de base** : aucune classe n'hérite de `Statbase` (`grep -rn "Inherits"
  .src/Statistiques` : rien) ; le préfixe ne suit pas la convention `Stat*`/`VisStat*` du lot.
- Tables via `Cbase.Table` : `TabArt`, `TabMo`, `TabCli`, `TabFour`, `TabPrdComp`, `TabHisFac`,
  `TabEntTck` (= `Fiches_EntTicketz`), `TabMvt`, `TabBl`.
- Aucun signal `deps.py` (`arity_errors`, `unused`, `handlers_inactifs`, `replay_*`,
  `scope_reducible` vides).
