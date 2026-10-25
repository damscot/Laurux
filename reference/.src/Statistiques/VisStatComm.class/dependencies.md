# VisStatComm — Dépendances

> Source : `.src/Statistiques/VisStatComm.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisStatComm.class` — classe, formulaire associé `VisStatComm.form`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Bnet2_MouseDown`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/StatComm.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1AC`, `Lines`, `level2AC` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `son` |
| `StatComm` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Commerciaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`, `Sens_Aff`, `Bnet2_MouseDown`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `StatComm.Traitement` (`StatComm.class:290`, `New VisStatComm(…)` à 6
  arguments, conforme à `_New` ; `hForm.Show()` ensuite). Aucun membre n'est lu de l'extérieur :
  la « portée réductible » de `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`, `sens` est
  confirmée par `grep`.
- **`Bnet2_MouseDown`** (`unused`) : aucun contrôle `Bnet2` dans `VisStatComm.form` (les
  RadioButton sont `Bcode`, `Bnom`, `Bbrut`, `Brem`, `Bnet`) → code mort (VISSTATCOMM-002).
- **`replay_missing` : `Liste`** : la grille n'a pas de `Liste_Click` ; un clic rejoué sur `Liste`
  échouerait (`Object.Call` d'une méthode absente) : les scénarios ne cliquent pas dans la grille.
- Dépendance de données forte à `StatComm` : structure de `Total` (colonnes `cdclifac` …
  `commercial`). Les deux fichiers sont à reworker dans le même lot.
- `Chistoriques` (`Level0F`, `Level1AC`, `level2AC`, `Lines`, `Footer`, `Entete`) : arités
  vérifiées (`level2AC` à 9 paramètres).
