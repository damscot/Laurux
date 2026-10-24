# ImpDepots — Dépendances

> Source : `.src/Gestion/Depots/ImpDepots.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Depots/ImpDepots.class` — classe, formulaire associé `ImpDepots.form`
- Handlers GUI détectés : 7
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coldep_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1D`, `Level2D`, `Level3D`, `Level4D`, `Lines` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `son` |
| `Utils` | `Coulfd`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Depots`, `Fiches_StkDepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`aff_Depot`, `Cman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée : `Fmenu.class:2170` et `Prgm.class:75` (`If Prog = "Impdep"`).
- Utilise `Cstocks` (`Entete`, `Level1D`, `Level2D`, `Level3D`, `Level4D`, `Lines`, `BasPage`,
  `Output`) et `Visualiseur.Prog`.
- **Phase 2** : pas d'appel à `Utils.Observers` → aucun `ReplayObserver` n'est posé sur cet écran ;
  un scénario de rejeu ne peut pas être capturé tel quel (à traiter dans le harnais ou par une
  anomalie si l'instrumentation est ajoutée).
- `Coldep_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- `Button1` (aide) du `.form` sans handler.
