# RelvMo — Dépendances

> Source : `.src/Statistiques/RelvMo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/RelvMo.class` — classe, formulaire associé `RelvMo.form`
- Handlers GUI détectés : 9
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 427 `Cdocuments.Entete` (18 donnés, attendus 19)
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `RlCli_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `Entete`, `Entete2`, `Level1R`, `Level2R`, `Level3R`, `Level4R` |
| `DB_Connection` | `Engine`, `Exec` |
| `PdfWriter` | `AliasNbPages`, `Footer`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Cli`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Stat`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `MajTab`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.class:1823` (`RelvMo.Show()`, auto-instance). Aucun autre usage (`grep -rn`).
- **Arité** : `deps.py` signale `RelvMo:427` `Cdocuments.Entete` avec 18 arguments pour 19. Vérifié :
  la signature (`Cdocuments.class:96`) n'a **aucun** paramètre `Optional` ; le dernier, `Libre As
  String`, est omis au saut de page → erreur d'exécution (RELVMO-A01). L'appel de la ligne 411 passe
  bien 19 arguments.
- **Rejeu dynamique** : `RlCli_Click` (ColumnView) est appelé par `ReplayObserver.Replay_Click` via
  `Object.Call` : il doit rester `Public`.
- Les méthodes `dteN0_GotFocus/LostFocus`, `dteN1_GotFocus/LostFocus` portent des noms de handlers
  mais ne sont **pas** levées (zones dans le groupe `Cmpt` du `.form`) : réduction de portée possible.
- **Table de travail `Fiches_Stat`** (`Cbase.Table("TabStat")`) : DROP/CREATE ici, dans `RelMoprod` et
  dans `Affichages/TriHistos` avec trois structures différentes ; absente de `db_control.csv`.
- `Fiches_Parametres` en dur dans `Ex1`. `Fiches_Societes` via `Cbase.Table("TabSoc")`.
- `Cdocuments` (`.src/Reports`) : `Entete`, `Entete2`, `Level1R`, `Level2R`, `Level3R`, `Level4R`,
  `Footer`, `Output` ; toute modification de la signature d'`Entete` touche aussi les autres
  appelants de `Cdocuments`.
- Ordre de rework : après la décision sur la table `Fiches_Stat` (avec `RelMoprod`, `TriHistos`) ;
  la commonalisation des dates avec `HitCarte`/`Histovmo`/`RelMoprod`.
