# RubImp — Dépendances

> Source : `.src/Compta/Impressions/RubImp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/RubImp.class` — classe, formulaire associé `RubImp.form`
- Handlers GUI détectés : 12
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `E0_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Ex1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cresultat` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level2`, `Level3`, `Level7` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Imp_Bilan` | `Lancement` |
| `Imp_Sig` | `Lancement` |
| `LDate` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_RubCompt`, `Fiches_Rubriques`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Recup_Dtes`, `Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `dteN0_LostFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `E0_Click`, `Raz`, `Button2_Click`, `Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Fmenu.Menu124_Click` (`Fmenu.class:1260`, `RubImp.Show`,
  Comptabilité > Compte de résultat > Impression).
- **Délégation** : `Imp_Bilan.Lancement` (bilan) et `Imp_Sig.Lancement` (SIG) ; le compte de
  résultat est calculé et imprimé dans `Button2_Click` avec `Cresultat` (`.src/Reports/Cresultat.class`,
  `Inherits PdfWriter` : `level0`, `level1`, `level2`, `level3`, `level7`, `Baspage`).
- **Contrôles absents du .form** : `E0` n'existe pas dans `RubImp.form` (`grep -n "E0" RubImp.form` :
  aucun résultat) ; `E0_Click` n'est donc jamais déclenché et `Ex1` n'est appelé que par lui
  (code mort, `deps.py` les signale en portée réductible).
- **Handlers des boutons radio** `E1_Click`, `N1_Click`…`N5_Click`, `Bilan_Click`, `Sig_Click`,
  `Crlt_Click` : contrôles sans groupe, événements nominaux actifs (à garder `Public`).
- **Tables** : `Fiches_Parametres` (`dteclec`…`dteclec5`), `Fiches_Societes`, `Fiches_Rubriques`,
  `Fiches_RubCompt`, `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_Comptes` (via `Cbase.Table("TabComptes")`,
  l.1015). `Tab2` et `Tab4` sont affectées mais inutilisées. Table de travail `centralisation`
  (version compte de résultat : `Col1`…`col4` en `Char(25)`, clé `numrub, compte`), créée même pour
  le bilan et les SIG, puis recréée par `Imp_Bilan`/`Imp_Sig`.
- **Fichiers** : `~/tmp/Resultat.csv` (ouvert à chaque édition, même bilan/SIG), `~/tmp/Resultat.pdf`.
- **Lecture brute des dates de clôture** : 20 lectures `rResult!dteclec*` (l.48-80, 100-230) ;
  voir `LDate.Exercice_Cloture` (`LDate.class:648`) pour la commonalisation.
- Contrainte d'ordre : `Imp_Bilan` et `Imp_Sig` doivent garder la signature de `Lancement` pendant
  le rework de `RubImp` (ou être modifiés dans le même commit) ; la commonalisation des dates
  d'exercice (`Ex1`/`Exo`…`Exo5`) concerne aussi `Balance`, `EcrM`, `EditcompteA`, `Editcompte`,
  `ExportA47`, `Jourcent`, `Journaux`, `JournauxA` (même idiome) et `Verbal`.
