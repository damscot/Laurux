# StatComArt — Dépendances

> Source : `.src/Statistiques/StatComArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatComArt.class` — classe, formulaire associé `StatComArt.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisStatComArt.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `VisStatComArt` | `<type>` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu314_Click` (`Fmenu.class:2390`, `StatComArt.Show()`).
- **`VisStatComArt`** : ouvert par `New VisStatComArt(…)` (5 arguments conformes) ; dépend de la
  structure de `Total` (`cdartfac`, `lbartfac`, `nethtfac`, `qte`, `commercial`) : rework conjoint.
- `Fiches_HistoLigfacM` apparaît dans les tables détectées mais n'est **jamais interrogée**
  (variable `Tab5` morte) ; `Total` (variable `Tab2`) n'est pas détectée.
- Aucun `arity_errors`, `unused`, `handlers_inactifs`, `replay_*`. « Portée réductible » de
  `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` confirmée ; `dateN1` est de plus sans effet utile
  (`dte1`/`dte2` jamais lus), ce que l'heuristique ne voit pas.
