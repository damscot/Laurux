# VisHitCartes — Dépendances

> Source : `.src/Statistiques/VisHitCartes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisHitCartes.class` — classe, formulaire associé `VisHitCartes.form`
- Handlers GUI détectés : 2
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/HitCarte.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1H`, `Lines`, `level2H` |
| `DB_Connection` | `Exec` |
| `HitCarte` | `<type>` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `son` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Draw_Chart`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `HitCarte.class:223` (`New VisHitCartes(Me, Tot, son, tri, dteN0.Text,
  dteN1.Text)`, 6 arguments pour 6 paramètres obligatoires ; le `Parent` de `Form` n'est pas fourni).
  Puis `hForm.Show()` ligne 224.
- **Table lue non détectée** par `deps.py` : `Total` (nom en dur via `Tab3`), écrite par `HitCarte`.
  Le bloc AUTO indique « aucune table » à tort.
- `Chistoriques` (`.src/Reports/Chistoriques.class`) : `Entete`, `Level0F`, `Level1H`, `level2H`,
  `Lines` (+ `Footer`, `Open`, `AliasNbPages`, `Output` hérités de `PdfWriter`).
- La grille `Liste` n'a pas de `Liste_Click` (`replay_missing`) : un clic rejoué sur la liste ferait
  `Object.Call` d'une méthode inexistante ; les scénarios n'y cliquent pas (ou REPLAYOBSERVER-A06).
- Ordre de rework : avec `HitCarte` (contrat sur `Total` et sur la signature de `_New`) et avec
  `TBord` pour l'histogramme commun.
