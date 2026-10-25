# EdClient — Dépendances

> Source : `.src/Gestion/Impressions/EdClient.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdClient.class` — classe, formulaire associé `EdClient.form`
- Handlers GUI détectés : 12
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcli_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cclients` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Statut`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_Clients`, `Aff_Statuts`, `Aff_Types`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:1272` (`Menu101_Click`).
- `replay_dynamic` : `Colcli_Click` → reste `Public`.
- « Portée réductible » confirmée par grep : `Aff_Clients`, `Aff_Statuts`, `Aff_Types` (appelés
  seulement par les `ToggleButton*_Click` du fichier) ; `Button2_Click` (bouton du groupe `Btn`).
- Utilise `Cclients` (`Entete`, `Level1`, `Level2`, `Lines`, `Baspage`).
- Tables : `Fiches_Cli` et `Fiches_Typec` en dur, `Fiches_Statut` via `Cbase`.
- Le `.form` porte la liste des modes de règlement (`Mreg`) : elle doit rester cohérente avec les
  valeurs de `cli_reg`.
