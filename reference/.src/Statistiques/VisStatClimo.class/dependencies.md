# VisStatClimo — Dépendances

> Source : `.src/Statistiques/VisStatClimo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisStatClimo.class` — classe, formulaire associé `VisStatClimo.form`
- Handlers GUI détectés : 8
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/StatClimo.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1P`, `Level4P`, `Level5P`, `Lines`, `level2P` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `StatClimo` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`, `Sens_Aff`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `StatClimo.Traitement` (`StatClimo.class:302`, 5 arguments conformes).
  « Portée réductible » de `Affichage`, `Sens_Aff`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
  confirmée.
- **`replay_missing` : `Liste`** (pas de `Liste_Click`) : ne pas cliquer dans la grille.
- `Chistoriques.level2P` attend des `String` et reçoit des `Float` (conversion implicite non
  localisée) : non détecté par l'heuristique (arité correcte).
- `Fiches_Societes` (nom en dur) : requête dont le résultat n'est pas utilisé.
