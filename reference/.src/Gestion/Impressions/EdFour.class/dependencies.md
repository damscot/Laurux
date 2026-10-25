# EdFour — Dépendances

> Source : `.src/Gestion/Impressions/EdFour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdFour.class` — classe, formulaire associé `EdFour.form`
- Handlers GUI détectés : 10
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcli_Click`, `Colcli2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cclients` | `<type>`, `BasPage`, `BasPageP`, `EnteteP`, `Level1F`, `Level2F`, `LinesP` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée : `Fmenu.class:1141` (`Menu104_Click`) et `Fmenu.class:1278` (`Menu108_Click`),
  sous la casse `EDfour` (Gambas insensible à la casse).
- `replay_dynamic` : `Colcli_Click`, `Colcli2_Click` → restent `Public`.
- « Portée réductible » `Button2_Click` confirmée (bouton du groupe `Btn`).
- Utilise `Cclients` (`EnteteP`, `Level1F`, `Level2F`, `LinesP`, `BasPageP`, `BasPage`).
