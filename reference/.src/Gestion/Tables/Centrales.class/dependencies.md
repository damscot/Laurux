# Centrales — Dépendances

> Source : `.src/Gestion/Tables/Centrales.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Centrales.class` — classe, formulaire associé `Centrales.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Centrales`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2020` (`Centrales.Show()`).
- `Fiches_Centrales` est lue par `Articles` (`:171`), `FFournisseur` (`:101`, `:423`), `TriArticles`,
  `Stockmvt`, `Impart`, `MajFbtarif1` et `Histocliart` : leurs replays dépendent du contenu de la table.
- Groupe d'observateurs `obs` créé dynamiquement par `SetObservers` (`New Observer(hCtrl) As "OBS"`) :
  `OBS_GotFocus`/`OBS_LostFocus` sont des handlers bien que les contrôles du `.form` n'aient pas
  de groupe.
- `Coltype_Click` est rejoué par `ReplayObserver.Replay_Click` (`Object.Call`) : il doit rester `Public`.
- `Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_*` : appels internes uniquement
  (vérifié par `grep`).
- Ordre de rework : à traiter avec Identite, Statut et Typec (socle commun), après la création du
  socle en phase 3.
