# Histovmo — Dépendances

> Source : `.src/Statistiques/Histovmo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/Histovmo.class` — classe, formulaire associé `Histovmo.form`
- Handlers GUI détectés : 25
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colmo_Click`, `Colmo2_Click`, `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level1`, `Level2` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Fam`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Mo`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`dteN0_LF`, `dteN1_LF`, `Button2_Click`, `Level1`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.class:1370` (`Histovmo.Show`, auto-instance). Aucun autre usage.
- **Code mort vérifié** : `Level1` et `Level2` (signal `unused`) ne sont appelés nulle part ; les appels
  `pdf.Level1()` (lignes 755, 837) et `pdf.level2(…)` (ligne 829) visent `Chistoriques.Level1` /
  `Chistoriques.Level2` (`.src/Reports/Chistoriques.class:48` et `:78`, 7 paramètres, arité correcte).
- **Rejeu dynamique** : `Colmo_Click`, `Colmo2_Click`, `Colfam_Click`, `Colfam2_Click`,
  `Colfour_Click`, `Colfour2_Click` sont appelés par `ReplayObserver.Replay_Click` via `Object.Call` :
  ils restent `Public`.
- `Button2_Click` n'est pas un handler levé : `Button2` est dans le groupe `btn` du `.form` (la casse
  du groupe n'importe pas en Gambas) ; il est appelé par `Btn_Click` et `Btn_KeyPress`. `Button1` n'est
  dans aucun groupe : `Button1_Click` est son handler, et le `Case 1` de `Btn_Click` est inatteignable.
- Tables citées en dur (aucun `Cbase.Table`) : voir le bloc AUTO.
- Commonalisations dépendantes : `EdSelection.ListeCodes` (EDART1-003, lot Gestion) doit exister
  avant HISTOVMO-003 ; `StatCommun.DateSaisie` (HITCARTE-006).
