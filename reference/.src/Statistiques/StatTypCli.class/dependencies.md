# StatTypCli — Dépendances

> Source : `.src/Statistiques/StatTypCli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatTypCli.class` — classe, formulaire associé `StatTypCli.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisStatTypCli.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `VisStatTypCli` | `<type>` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Parametres`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu176_Click` (`Fmenu.class:1703`, `StatTypCli.Show`), auto-instance
  non modale.
- **`VisStatTypCli`** reçoit `Me` comme `Hitniv` (jamais relu) ; dépendance de données par la
  structure de `Total` (`cdtypclifac`, `nmtypclifac`, `brutfac`, `rmfac`, `totfac`, `totfacn1`) :
  rework conjoint.
- Tables en dur via variables (`Tab`, `Tab3`, `Tab4`, `Tab5`) : `deps.py` les détecte comme
  littéraux ; `Total` (variable `Tab2`) n'apparaît pas dans ses tables.
- Aucun `arity_errors`, `unused`, `handlers_inactifs`, `replay_*` ; « portée réductible » de
  `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` confirmée par `grep`.
- Référencé par l'anomalie STATCAI-A04 (`Statcai.class`) pour le partage de `Total`.
