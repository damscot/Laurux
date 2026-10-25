# EdRup — Dépendances

> Source : `.src/Gestion/Impressions/EdRup.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdRup.class` — classe, formulaire associé `EdRup.form`
- Handlers GUI détectés : 10

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level13`, `Level13R`, `Level13V`, `Level14`, `Level14V`, `Ligne` |
| `Cbase` | `Table` |
| `Crupt` | `Rupture` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `D` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `Utils` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_Four`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_Ligcom`

### Membres Public sans usage externe détecté (portée réductible ?)

`fourman`, `SelectionArt`, `art_man`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu253_Click` (`Fmenu.class:2080`, `EdRup.Show()`).
- **Crupt** : `Crupt.Rupture(…, "EdRup")` (l. 335) est l'**unique** appel de `Crupt` ; la chaîne
  `"EdRup"` pilote ses branches (`Org = "EdRup"`, 10 tests dans `Crupt.module`). Voir
  [Crupt/dependencies.md](../../../Utils/Crupt.module/dependencies.md) : contrat de colonnes
  `Rupture`/`RuptureC`, anomalies CRUPT-A01 à A05. Rework conjoint (même lot en phase 3).
- **Tables non vues par `deps.py`** : `Rupture`, `RuptureC` (noms en variables `Tab2`/`Tab3`), écrites
  aussi par `Changefam.class:541-542` et verrouillées en `Changefam.class:732`. Elles ne sont ni dans
  `db_control.csv` ni dans `Laurux01.sql` : le dump normalisé de phase 2 doit les exclure ou les
  comparer explicitement (décision des notes transverses).
- **Tables lues** : `Fiches_Art`, `Fiches_Four` (`fourman`), `Fiches_HisLigTickets`,
  `Fiches_HisEntTickets` (via `Cbase`), `Fiches_Cli` (en dur). `Fiches_Ligcom` (variable `Tabl`) n'est
  pas lue ici (elle l'est par `Crupt`) : dépendance surestimée par `deps.py`.
- **Écriture** : `UPdate RuptureC` (l. 432) et `Start.LocalSettings.Save` (`Btn_Click`).
- **Rendu** : `Carticles.Level13`, `Level13R`, `Level13V`, `Level14`, `Level14V`, `Ligne`, `Entete`,
  `Footer`.
- **Signaux `deps.py`** : `replay_dynamic`, `replay_missing`, `unused`, `arity_errors`,
  `handlers_inactifs` vides ; `scope_reducible` = `fourman`, `SelectionArt`, `art_man`,
  `Button2_Click` (confirmés).
- **Ordre de rework** : après ou avec `Crupt` ; avant `Changefam` si les constantes de tables sont
  introduites (CRUPT-004).
