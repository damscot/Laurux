# FPostes — Dépendances

> Source : `.src/Compta/Tables/FPostes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FPostes.class` — classe, formulaire associé `FPostes.form`
- Handlers GUI détectés : 5
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Postes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `cptman`, `Button1_Click`, `Button2_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.Menu294_Click` (`.src/Communs/Fmenu.class:2278`).
- `Fiches_Postes` est lue par `FComptes` (`:1042`), `Analytique` (`:44`, `:137`, `:153`) et
  `JournauxA` (`:228`, `:635`, `:663`) : leurs replays dépendent du contenu de la table.
- `Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` : appels internes uniquement.
- Aucun appel dynamique.
