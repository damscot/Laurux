# Imp_Bilan — Dépendances

> Source : `.src/Compta/Impressions/Imp_Bilan.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Imp_Bilan.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button1_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/RubImp.class` | `Lancement` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cbilan` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level1L`, `Level1S`, `Level3`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe` |
| `Utils` | `Cdate_Dbase`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_RubCompt`, `Fiches_Rubriques`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `RubImp.Button2_Click` (`RubImp.class:588`), quand le bouton radio `Bilan`
  est coché. Les paramètres `dt1`/`dt2` (période N-1 calculée par `RubImp.Recup_Dtes`) sont
  écrasés dès que l'exercice n'est pas `N5` (recalcul « date − 1 an », l.244-247).
- **Classe d'impression** : `Cbilan` (`.src/Reports/Cbilan.class`, `Inherits PdfWriter`). Appels
  `level0`, `level1`, `level1L`, `level1S`, `level3`, `Lines`, `Baspage`, `Open`, `AliasNbPages`,
  `Output`. `Cbilan` n'imprime ni `imp3`/`imp4` ni le libellé `dte2` de `Level3` : toutes les
  valeurs N-1 calculées ici sont perdues (IMP_BILAN-A01).
- **Tables de travail** créées dans la base de la société, hors `Cbase` et hors `db_control.csv` :
  `centralisation` (version bilan : `Col1`…`col4`, `amortissement`, `amortissement2`, `actif`,
  `actif2`, clé `numrub, amortissement, amortissement2`) et `Comptes` (soldes par compte). La table
  `centralisation` est aussi créée, avec d'autres structures, par `RubImp`, `Imp_Sig`, `Jourcent`,
  `EcrM`, `ExportA47`, `Intjdv` et `JournauxM` : deux éditions simultanées sur deux postes se
  détruisent mutuellement. `deps.py` ne voit pas ces tables (noms hors `Fiches_*`).
- **Fichiers produits** : `~/tmp/BilanDetail.csv` (écritures par compte), `~/tmp/BilanRub.csv`
  (comptes retenus par rubrique), `~/tmp/Bilan.pdf` ouvert par `Visualiseur.Prog`.
- **Tables Mvt** : `Fiches_Mvt` à `Fiches_Mvt5`, choisies par le code d'exercice (`E1`, `N1`…`N5`) ;
  même table de correspondance dans `Imp_Sig` et `RubImp`.
- `Button1_Click` (`Doc.Open("Bcrimp")`) : un module n'a pas de formulaire, ce handler n'est jamais
  déclenché ; aucun appel (`grep -rn "Imp_Bilan.Button1" .src` : aucun résultat) → code mort.
- Contrainte d'ordre : traiter en même temps que `Imp_Sig` et `RubImp` (sélection des tables Mvt,
  table `centralisation`, en-tête société) ; tests de non-régression pilotés depuis l'écran `RubImp`.
