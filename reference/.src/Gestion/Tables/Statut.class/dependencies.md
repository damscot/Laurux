# Statut — Dépendances

> Source : `.src/Gestion/Tables/Statut.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Statut.class` — classe, formulaire associé `Statut.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Mails/EmailingCarte.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Statut`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée : `Fmenu.class:1915` (`Statut.Show()`) et `EmailingCarte.class:649-652`
  (`bstatut_Click` bascule `Statut.Visible`). Le second est **réel** : `EmailingCarte.form` ne
  contient aucun contrôle nommé `Statut`, c'est l'auto-instance du formulaire qui est affichée ou
  masquée (comportement à préserver).
- Lecteurs de `Fiches_Statut` : `FClient` (`:105`, `:767`), `Emailing`, `EdClient`, `Expcontact`.
- Groupe `obs` créé dynamiquement par `SetObservers`.
- `Coltype_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec Centrales, Identite, Typec.
