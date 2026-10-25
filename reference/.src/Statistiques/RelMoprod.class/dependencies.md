# RelMoprod — Dépendances

> Source : `.src/Statistiques/RelMoprod.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/RelMoprod.class` — classe, formulaire associé `RelMoprod.form`
- Handlers GUI détectés : 37
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `compteMan`, `A1_KeyPress`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColCli_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `BasPage`, `EnteteN`, `Level2RL`, `Level4RL`, `Level5RL`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Footer`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base2`, `CDec`, `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `SetEditColor`, `db`, `rs2` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_Parametres`, `Fiches_Stat`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `MajTab`, `Controle`, `Tris`, `compteMan`, `compteTiers`, `Deb3`, `Deb4`, `Dbclk`, `A1_KeyPress`, `ChkInput`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.class:1829` (`RelMoprod.Show()`, auto-instance). Aucun autre usage.
- **Code mort vérifié** (`unused`) : `compteMan` (aucun appel, la zone `Code` n'a pas de saisie
  contrôlée) et `A1_KeyPress` (aucun contrôle `A1` dans `RelMoprod.form`).
- **Rejeu dynamique** : `ColCli_Click` (GridView `Colcli`) est appelé par `ReplayObserver.Replay_Click`
  via `Object.Call` : il reste `Public`. `Rlcli_click` est le handler du `TreeView` `Rlcli` (non
  listé par `deps.py`, qui ne traite que GridView/ColumnView/ListBox).
- **`replay_missing`** : `Colrcp3` (ColumnView du détail de facture) n'a pas de `Colrcp3_Click` : un clic
  rejoué dessus échouerait ; les scénarios n'y cliquent pas.
- Les méthodes `dteN*_GotFocus/LostFocus` ne sont pas levées (zones dans le groupe `Cmpt`).
- `C1_Click`, `N1_Click`, `Cp1_Click`, `V1_Click` : handlers nominaux de `TextBox`, événement `Click`
  inexistant pour cette classe (limite connue de `deps.py`) ; atteints par les `*_GotFocus`.
- **`Utils.rs2`** : résultat global partagé rempli par `Utils.Base2` et lu par `Colcli_Data` ; tout
  autre écran qui appelle `Utils.Base2` pendant que la grille est visible le remplace.
- **Table de travail `Fiches_Stat`** : partagée avec `RelvMo` et `Affichages/TriHistos` (structures
  différentes, RELVMO-A03).
- Tables en dur : `Fiches_Parametres` (`Ex1`) ; toutes les autres via `Cbase.Table`. `Fiches_Cli` est
  aussi lue en concaténation dans `Deb3`/`Deb4` (`Cbase.Table("TabCli")`).
- `Cdocuments` (`.src/Reports`) : `EnteteN`, `Lines`, `Level2RL`, `Level4RL`, `Level5RL`, `Baspage`,
  `Footer`, `Output`.
- Ordre de rework : avec `RelvMo` (table `Fiches_Stat`, `Ex1`, dates).
