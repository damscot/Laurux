# VisStatComArt — Dépendances

> Source : `.src/Statistiques/VisStatComArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisStatComArt.class` — classe, formulaire associé `VisStatComArt.form`
- Handlers GUI détectés : 7
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/StatComArt.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1A`, `Level5A`, `Lines`, `level2A` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `son` |
| `StatComArt` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Commerciaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`, `Sens_Aff`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `StatComArt.Traitement` (`StatComArt.class:223`, 5 arguments conformes,
  puis `hForm.Show()`). « Portée réductible » de `Affichage`, `Sens_Aff`, `total`, `Dtn0`,
  `Dtn1`, `Tri`, `sens` confirmée par `grep`.
- **`replay_missing` : `Liste`** (pas de `Liste_Click`) : ne pas cliquer dans la grille.
- `Comm_Change` : handler d'une ComboBox (`List = Null` dans le `.form`, remplie dans `_New`).
- Le fichier `~/tmp/Statcli.pdf` est aussi écrit et supprimé par `VisStatComm` (couplage par
  nom de fichier, non détecté par l'heuristique).
- Rework conjoint avec `StatComArt` (structure de `Total`).
