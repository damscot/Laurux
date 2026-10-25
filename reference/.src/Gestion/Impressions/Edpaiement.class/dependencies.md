# Edpaiement — Dépendances

> Source : `.src/Gestion/Impressions/Edpaiement.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edpaiement.class` — classe, formulaire associé `Edpaiement.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbordereaux` | `<type>`, `EnteteP`, `Footer`, `Level1`, `Level2`, `Level3`, `Ligne` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`date1_LostFocus`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:1805` (`Menu194_Click`, `Edpaiement.ShowModal()`).
- `date1_LostFocus` : pseudo-handler (`Date1` dans le groupe `Cmpt`), appelé seulement par
  `Cmpt_KeyPress` (grep) → réductible.
- Table de travail `Paiements` non détectée par l'outil (nom en variable `Tab3`), absente de
  `db_control.csv` et de `Laurux01.sql` ; aucune autre référence dans le projet.
- Utilise `Cbordereaux` (`.src/Reports/Cbordereaux.class` : `EnteteP`, `Level1`, `level2`,
  `Level3`, `Ligne` ; `footer`/`Output` de `PdfWriter`) et `Visualiseur.Prog`.
- `Fiches_Bl` et `Fiches_BlM` ont les mêmes colonnes dans le même ordre (types différents) :
  l'`UNION` est valide.
