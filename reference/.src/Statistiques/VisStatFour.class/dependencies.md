# VisStatFour — Dépendances

> Source : `.src/Statistiques/VisStatFour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisStatFour.class` — classe, formulaire associé `VisStatFour.form`
- Handlers GUI détectés : 6
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level0`, `Level1`, `level2`, `Level4`, `Level5`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/StatFour.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1FO`, `Level4FO`, `Level5FO`, `Lines`, `level2FO` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `son` |
| `StatFour` | `<type>` |
| `Utils` | `Coulfd`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_art`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`, `Sens_Aff`, `Level0`, `Level1`, `level2`, `Level4`, `Level5`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `StatFour.Traitement` (`StatFour.class:230`, `New VisStatfour` à 5
  arguments conformes). « Portée réductible » de `Affichage`, `Sens_Aff`, `total`, `Dtn0`,
  `Dtn1`, `Tri`, `sens` confirmée.
- **`unused`** : `Level0`, `Level1`, `level2`, `Level4`, `Level5` — vérifiés par `grep -rn` sur
  `.src` (aucun appel, aucune chaîne), code mort (VISSTATFOUR-002). Les homonymes de
  `Chistoriques` (`Level1FO`…) sont distincts.
- **`replay_missing` : `Liste`** (pas de `Liste_Click`) ; de plus l'écran n'appelle pas
  `Utils.Observers` : aucun scénario rejouable tant que VISSTATFOUR-A03 n'est pas validée.
- `Tab2 = "Fiches_art"` est détecté comme table référencée mais n'est jamais interrogé.
