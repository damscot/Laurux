# Identite — Dépendances

> Source : `.src/Gestion/Tables/Identite.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Identite.class` — classe, formulaire associé `Identite.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Identite`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1817` (`Identite.ShowModal()`).
- **Table non détectée par `deps.py` comme clé `Cbase`** : le nom `Fiches_Identite` est en dur
  (variable locale `Tab`). Lecteurs de la table : `Fsoc.Init_Civilite` (`Fsoc.class:141`) et
  `Utils.module:1611` (remplissage générique d'un combo par `Object.Call(obj, "Add", …)`).
- Groupe `obs` créé dynamiquement par `SetObservers` : `OBS_GotFocus`/`OBS_LostFocus` sont des handlers.
- `Coltype_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec Centrales, Statut et Typec (socle commun).
