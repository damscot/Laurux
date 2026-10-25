# StatComm — Dépendances

> Source : `.src/Statistiques/StatComm.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatComm.class` — classe, formulaire associé `StatComm.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisStatComm.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `VisStatComm` | `<type>` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Commerciaux`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu313_Click` (`Fmenu.class:2384`, « CA clients/commerciaux ») par
  `StatComm.Show()` : auto-instance, non modale ; plusieurs écrans statistiques peuvent donc être
  ouverts en même temps et partager la table `Total`.
- **`VisStatComm`** n'utilise `StatComm` que comme type du 1er paramètre de `_New` (`Hitniv`,
  jamais relu) : pas de dépendance d'exécution en retour ; ordre de rework libre, mais
  `StatComm` + `VisStatComm` partagent la structure de `Total` (colonnes `cdclifac`, `nmclifac`,
  `pnmclifac`, `brutfac`, `rmfac`, `totfac`, `totfacn1`, `commercial`) : toute évolution de
  l'une impose l'autre (même commit).
- **Tables non détectées comme telles** : `Total` (nom en variable `Tab2`), `Fiches_HistoFac` et
  `Fiches_HistoFacM` (variables `Tab`/`Tab3`) ; `Fiches_Bl`/`Fiches_BlM` sont listées par
  l'heuristique mais **jamais interrogées** (variables `Tab4`/`Tab5` mortes).
- `deps.py` ne signale aucun `arity_errors`, `unused`, `handlers_inactifs`, `replay_dynamic` ni
  `replay_missing` pour ce fichier (pas de grille dans le `.form`) ; les 4 « portée réductible »
  (`dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement`) sont confirmées par `grep`.
- Partage de la table `Total` avec `StatComArt`, `StatFour`, `StatTypCli`, `StatClimo`, `TBord`,
  `HitCarte` et `Caisse/Statcai` (structures différentes) : contrainte de rework commune
  (socle `StatCommun.TotalCree`).
