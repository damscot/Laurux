# Marques — Dépendances

> Source : `.src/Gestion/Tables/Marques.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Marques.class` — classe, formulaire associé `Marques.form`
- Handlers GUI détectés : 14
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `cpoint`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colmarque_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Base`, `Observers`, `SetEditColor`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Marques`

### Membres Public sans usage externe détecté (portée réductible ?)

`cpoint`, `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`, `Cmarque_LostFocus`, `Button1_Click`, `Button3_Click`, `Cpman`, `ChkCp`, `Ref`, `Dbclk`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1764` (`Marques.Show()`).
- Lecteurs de `Fiches_Marques` : `Articles` (`:111` via `marque.champs`, `:3197`), `Materiel`
  (`:440`), `EdMat`, `Stockmvt`, `Histocliart`.
- État partagé `Utils.rs1` (voir [Cpostaux](../Cpostaux.class/dependencies.md)).
- Pseudo-handler `Cmarque_LostFocus` (contrôle groupé `Cpost`) ; `Button1_Click`, `Button3_Click`
  (groupe `Btn`).
- `Colmarque_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- `cpoint` : jamais appelée (`unused`).
- Ordre de rework : avec Cpostaux et Depots.
