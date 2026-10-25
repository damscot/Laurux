# StatFour — Dépendances

> Source : `.src/Statistiques/StatFour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatFour.class` — classe, formulaire associé `StatFour.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisStatFour.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `VisStatFour` | `<type>` |

### Tables SQL référencées

`Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`DateN1`, `DteN0_LF`, `DteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu169_Click` (`Fmenu.class:1648`, `StatFour.show`).
- **`VisStatFour`** : `New VisStatfour(…)` (casse différente, même classe) à 5 arguments
  conformes ; dépendance de données par `Total` (`cdfour`, `nmfour`, `montant`, `montant1`).
- **`VisStatFour` n'appelle pas `Utils.Observers`** : la partie visualisation de ce couple n'est
  pas rejouable (VISSTATFOUR-A03).
- Aucun `arity_errors`, `unused`, `handlers_inactifs`, `replay_*` ; « portée réductible » de
  `DateN1`, `DteN0_LF`, `DteN1_LF`, `Traitement` confirmée. L'heuristique ne détecte pas l'`INSERT`
  à 2 marqueurs pour 3 colonnes (l. 210) : `sql_params` vide car le nombre d'arguments (3) n'est
  pas comparé au nombre de colonnes.
