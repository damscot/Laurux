# Typec — Dépendances

> Source : `.src/Gestion/Tables/Typec.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Typec.class` — classe, formulaire associé `Typec.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée réel : `Fmenu.class:1423` (`Typec.show`).
- **Faux positifs** : les usages attribués à `TarTypeCli` (`text`, `setfocus`, `maxlength`, `select`)
  portent sur le contrôle `TypeC` de `TarTypeCli.form` (homonyme à la casse près), pas sur ce
  formulaire.
- **Faux négatif** : la table est nommée en dur (`Fiches_Typec`) ; elle est lue par 21 fichiers
  (`TarTypeCli`, `CoefTypeC`, `Remisec`, `GesTar`, `TarArt`, `Facture`, `Facturefm`, `commande1`,
  `Articles`, `FClient`, `StatTypCli`, `Histocliart`, `Emailing`, `EdClient`, `EdArt3`, `Edart4`,
  `Eticli`, `ImptartypeC`, `TypeClient`, `Prefs`…).
- Groupe `obs` créé dynamiquement par `SetObservers`.
- `Coltype_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec Centrales, Identite, Statut.
