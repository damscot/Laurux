# EdStk — Dépendances

> Source : `.src/Gestion/Impressions/EdStk.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdStk.class` — classe, formulaire associé `EdStk.form`
- Handlers GUI détectés : 20
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Level1`, `Level2`, `Level3`, `Level4`, `Level5` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `CDec`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu102_Click` (`Fmenu.class:1129`, `EdStk.Show`).
- **Écrits entrants** : `TriArticles` écrit `Bsel`/`Bval` (`Object.SetProperty`) : rester `Public`.
- **Tables** : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four` nommées en dur (aucun `Cbase.Table`).
  Lecture seule ; la quantité imprimée est `art_qte`, maintenue par `DB_Connection.Lockstock`,
  `Cstock.Calc_stock`, `Validinv` (voir [Stockmvt/architecture.md](../../Stockmvt.class/architecture.md)).
- **Rendu** : `Carticles.Entete`, `Level1`, `Level2`, `Level3`, `Level4`, `Level5` ; `Footer` non
  appelé.
- **Rejeu** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` dans
  `replay_dynamic` → `Public`. `replay_missing`, `unused`, `unused_transitive`,
  `handlers_inactifs`, `arity_errors` vides.
- **Portée** : `SelectionArt`, `Button2_Click` confirmés sans appelant externe (`Button2` dans le
  groupe `btn`).
- **Ordre de rework** : avec `EdArt1`/`EdArt3` (socle `EdSelection`).
