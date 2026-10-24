# EdNlettrees — Dépendances

> Source : `.src/Compta/Impressions/EdNlettrees.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EdNlettrees.class` — classe, formulaire associé `EdNlettrees.form`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level0`, `Level1`, `level2`, `Level3`, `Level4`, `Level5`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level3`, `Level4`, `Level5`, `Lines`, `level2` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Listextcpt` | `<type>`, `resext` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `TypeClient` | `<form>`, `where` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `cpt_GotFocus`, `cpt_LostFocus`, `cpt2_GotFocus`, `cpt2_LostFocus`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Raz`, `E0_Click`, `Button1_Click`, `Level0`, `Level1`, `level2`, `Level3`, `Level4`, `Level5`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** : `Fmenu.Menu103_Click` (`.src/Communs/Fmenu.class:1135`) et
  `Fmenu.Menu106_Click` (`.src/Communs/Fmenu.class:1147`), tous deux `EdNlettrees.Show`.
- **Faux positifs de portée réductible** : `Bsel` et `Bval` sont écrits par
  `TriCpt.ColTri_MajSel` (`.src/Affichages/TriCpt.class:112-113`, `Object.SetProperty($obj,
  "Bsel"|"Bval", …)`), appel dynamique non résolu par `deps.py` : ils doivent rester `Public`.
  Les autres (`Ex1`, `E0_Click`, `Level0`…`Level5`) sont confirmés sans appel externe
  (`grep -rn "EdNlettrees\." .src`).
- **`E0_Click`** n'est pas un handler : aucun contrôle `E0` dans `EdNlettrees.form`.
- **Groupe `Cmpt`** : `DteN0`, `Dten1`, `Cpt`, `Cpt2` y appartiennent ; les fonctions
  `dteN*_GotFocus/LostFocus`, `cpt*_GotFocus/LostFocus` ne sont exécutées que par appel explicite
  depuis `Cmpt_KeyPress` (aucun handler `Cmpt_GotFocus`/`Cmpt_LostFocus`).
- **Tables** : `Fiches_Mvt` à `Fiches_Mvt5` sont lues **indirectement** via `Listextcpt` (non
  listées par l'heuristique) ; `Fiches_Typec` via `TypeClient`. La table `Fiches_Mvt` listée vient
  de la variable morte `Tab`.
- **`Listextcpt`** (`.src/Compta/Utils/Listextcpt.class`) : contrat utilisé = constructeur
  `(cpt, dtei, dtes, "n", " dte asc")` + propriété `resext`. Toute évolution de `Listextcpt`
  (requête, bornes d'exercice) change cette édition : la rejouer (EDNLETTREES-T02 à T05).
- Aucune dépendance circulaire.
