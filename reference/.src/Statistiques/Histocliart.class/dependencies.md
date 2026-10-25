# Histocliart — Dépendances

> Source : `.src/Statistiques/Histocliart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/Histocliart.class` — classe, formulaire associé `Histocliart.form`
- Handlers GUI détectés : 16
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColumnView1`, `ColumnView2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Editeur` | `Prog_Editeur` |
| `LDate` | `Apres`, `DT`, `Fin_Jour`, `_call` |
| `Start` | `B`, `G`, `LocalSettings`, `Musique`, `R`, `son` |
| `TextReg` | `<form>`, `EstDate`, `Select`, `Text`, `Type`, `dte`, `reg` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `Trifam` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `db`, `fam` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Centrales`, `Fiches_Cli`, `Fiches_Commerciaux`, `Fiches_Fam`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Marques`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Cli_man`, `Cclient`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.class:2411` (`Histocliart.Show()`, auto-instance). Aucun autre usage.
- **`Bsel`/`Bval`** : écrits dynamiquement par `TriCpt` (`Object.SetProperty($obj, "Bsel"…)`,
  `Affichages/TriCpt.class:112-113`) et `TriArticles` (`Affichages/TriArticles.class:30-31`) : ils ne
  doivent pas devenir `Private`. `deps.py` ne les signale pas comme réductibles (noms cités en chaîne).
- **`Cclient`** (signal `scope_reducible`) : vérifié par `grep -rn`, jamais lu ni écrit, même dans le
  fichier → code mort plutôt que réduction de portée.
- **`Cli_man`** (signal `scope_reducible`) : appelée seulement par `Butcli_Click`/`Butcli2_Click`.
- **`replay_missing`** : `ColumnView1` et `ColumnView2` n'ont pas de `_Click` (le choix se fait par
  `_Activate`, double-clic ou Entrée) : un clic rejoué ferait `Object.Call` d'une méthode
  inexistante ; les scénarios utilisent le double-clic (`Activate`).
- **`Utils.fam`** (UTILS-A02) : sans nœud sélectionné dans `TreeView1`, renvoie `" AND champ IN)"` ; ici
  le premier nœud est sélectionné à l'ouverture, l'erreur n'apparaît que si l'utilisateur
  désélectionne tout avec `Checktfam` décochée.
- Tables en dur (aucun `Cbase.Table` sauf `TabCommerciaux`) : `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_BlM`,
  `Fiches_LigblM`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_HistoFacM`, `Fiches_HistoLigfacM`,
  `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_Cli`, `Fiches_Art`, `Fiches_Fam`,
  `Fiches_Typec`, `Fiches_Marques`, `Fiches_Centrales`.
- Composants : `gb.report` (`Report`, `ReportHBox`, `ReportLabel`, `ReportBrush`, `ReportBorder`),
  `Printer`.
- Classes projet : `Chainage`, `TextReg`, `LDate`, `Trifam`, `TriCpt`, `TriArticles`, `Visualiseur`,
  `Editeur`.
- **SQLite** : la requête n'utilise que des fonctions portables (`REPLACE`, `CASE`, `SUM`, `!=`) ;
  l'injection de `COLLATE NOCASE` par `DB_Connection.Exec` dans une requête à sous-requêtes et `UNION
  ALL` reste à vérifier (voir DB_CONNECTION-A01).
- Ordre de rework : après UTILS-A02 si l'anomalie est corrigée côté `Utils`.
