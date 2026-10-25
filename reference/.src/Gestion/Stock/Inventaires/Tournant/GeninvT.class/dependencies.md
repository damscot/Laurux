# GeninvT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` — classe, formulaire associé `GeninvT.form`
- Handlers GUI détectés : 20
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1G`, `Level2G`, `Lines` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Cdate_Dbase`, `Coulfd`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_InvT`

### Membres Public sans usage externe détecté (portée réductible ?)

`gen_Inv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu95_Click` (`Fmenu.class:1091`, `GeninvT.Showmodal()`).
- **Appels dynamiques entrants** (`replay_dynamic`) : `Colfam_Click`, `Colfam2_Click`,
  `Colfour_Click`, `Colfour2_Click` sont appelés par `ReplayObserver.Replay_Click` via
  `Object.Call` : ils doivent rester `Public` (sans objet si REPLAYOBSERVER-A06 est validée).
- `gen_Inv` « portée réductible » confirmé par grep.
- Tables par littéral non vues comme `Cbase` : `Fiches_InvT`, `Fiches_Fam`, `Fiches_Four`.
  `Fiches_InvT` est créée ici : source de toute la chaîne tournante (`SaisieInvT`, `EcartsT`,
  `EdnsaisisT`, `Edinv("T")`, `ValidinvT`, `RazInvT`, `EditStkDepart`, `Articles`, `Changefam`).
- Groupe `Cmpt` (6 `TextBox`) → `Cmpt_GotFocus`.
- Signaux `deps.py` : `scope_reducible` = `gen_Inv` ; `replay_dynamic` = 4 handlers ci-dessus ;
  aucun `unused`, `arity_errors`, `handlers_inactifs`, `replay_missing`.
- Ordre de rework : après le module `Inventaire` (GENINV-006).
