# StatClimo — Dépendances

> Source : `.src/Statistiques/StatClimo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatClimo.class` — classe, formulaire associé `StatClimo.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisStatClimo.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `VisStatClimo` | `<type>` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu117_Click` (`Fmenu.class:1207`) et `Fmenu.Menu201_Click`
  (`Fmenu.class:1200`) ; `Menu201` n'a pas de texte dans `Fmenu.form` (séparateur probable) :
  second point d'entrée vraisemblablement mort (à documenter côté Fmenu).
- **`VisStatClimo`** : `New VisStatClimo(…)` à 5 arguments conformes ; dépendance de données par
  `Total` (`cdclifac`, `nmclifac`, `pnmclifac`, `TotA`, `TotM`, `RemP`, `RemMo`).
- Aucun `arity_errors`, `unused`, `handlers_inactifs`, `replay_*` ; « portée réductible » de
  `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` confirmée ; `dateN1` est en plus sans effet
  utile (non vu par l'heuristique).
- `Total` (variable `Tab2`) non détectée comme table.
