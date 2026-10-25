# EdArt3 — Dépendances

> Source : `.src/Gestion/Impressions/EdArt3.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdArt3.class` — classe, formulaire associé `EdArt3.form`
- Handlers GUI détectés : 22
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`, `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level10`, `Level6`, `Level6bis`, `Level7`, `Level7bis`, `Ligne`, `Photo` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_CoeffTypec`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `art_man`, `Quitte_Cdt`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu297_Click` (`Fmenu.class:2304`, `EdArt3.ShowModal`, modal).
- **Écrits entrants** : `TriArticles` écrit `Bsel`/`Bval` par `Object.SetProperty` : rester `Public`.
- **Tables** : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Typec` (dans `Quitte_Cdt`) en dur ;
  `Cbase.Table("TabArt")`, `("TabTypec")` (`ToggleButton7_Click`), `("TabCtcli")` =
  `Fiches_CoeffTypec`. Lecture seule.
- **Rendu** : `Carticles` (`Entete`, `Footer`, `Level6`, `Level6bis`, `Level7`, `Level7bis`,
  `Level10`, `Photo`, `Ligne`) ; même fichier de sortie `~/tmp/Tarif1.pdf` qu'`EdArt1`.
- **Contrôles** : `Fam`/`Fam2` sont des `TextBox` (pas des `textfamille` comme dans `EdArt1`).
- **Rejeu** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`, `Coltype_Click`
  appelés par `ReplayObserver` via `Object.Call` : `Public` obligatoire. `replay_missing`,
  `unused`, `unused_transitive`, `handlers_inactifs`, `arity_errors` : vides.
- **Portée** : `SelectionArt`, `art_man`, `Quitte_Cdt`, `Button2_Click` confirmés sans appelant
  externe (grep `EdArt3\.`).
- **Ordre de rework** : avec `EdArt1` (procédure commune `ImprimeTarif`) ; la décision sur
  EDART3-A01 doit précéder EDART1-008.
