# ValidBR — Architecture

> Source : `.src/Gestion/Stock/ValidBR.class` · Formulaire : `.src/Gestion/Stock/ValidBR.form`

## Vue d'ensemble

`ValidBR` est l'**ancien** écran « Validation des bons de réception de marchandises » (Jacky
Tripoteau, 2014) : liste des fournisseurs ayant des BR non validées jusqu'à une date, détail des
BR, puis clôture (validation) avec ou sans génération de l'écriture d'achat dans `Fiches_Mvt`,
édition des BR par `Edbr.Ed(…, "ValidBR")` et scan GED.

⚠️ **Le couple `ValidBR.class` + `ValidBR.form` est du code mort** : aucun fichier ne
l'instancie ni ne l'ouvre (`grep -rnw ValidBR .src .project` ne trouve que la chaîne
`"ValidBR"` d'`Edbr.module:216`). Le menu `Fmenu.Menu232_Click` ouvrait `ValidBR.ShowModal()`
jusqu'au commit `a06ada7a` (avril 2022, « mise en place des tarifs par date et validation
comptable »), qui l'a remplacé par [ValidBR1](../ValidBR1.class/architecture.md). `deps.py`
confirme : `used_by` vide. Sa suppression est une **anomalie** soumise à validation
(VALIDBR-A01), pas un rework.

**Module complexe** (génération d'écritures comptables) : avant toute phase 2, l'utilisateur doit
décider entre suppression (A01) et maintien ; la liste de scénarios de `test.md` est à valider.

Fonctionnement (pour mémoire) :
- `Button1_Click` (« Traitement ») → `recup_bl` : recrée deux **tables de travail** `BRfm`
  (totaux par fournisseur) et `Br` (BR) par `DROP`/`CREATE TABLE`, les remplit depuis
  `Fiches_Entrecpt` (`validee <> True`, `ddate <= date`, montant non nul) ; un fournisseur ou
  tous ;
- `Btn_Click` (groupe `Btn` : `Button2` « Visualiser » tag 0, `Button3` « Cloture Seule » tag 1,
  `Button9` « Cloture + Compta » tag 2) → `Gen_ecr(mode)` : `LOCK TABLES` sur ~25 tables,
  table de travail `Totalisation` (ventilation par compte d'achat et de TVA), `validee = 1` pour
  les BR (mode > 0), édition `Edbr`, puis `Verif_solde`, `Maj_Compta` (écritures `Fiches_Mvt`,
  soldes `Fiches_Comptes`, `Sha1Calc`) et `Majnum` (mode 2), GED.

Nature globale : **mixte** (SQL, tables de travail et contrôles entremêlés ; nombreuses variables
membres non typées partagées entre fonctions).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `b` | var | Private |  | Integer | 28 |
| `Tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `Tab3` | var | Private |  | String | 31 |
| `Tab4` | var | Private |  | String | 32 |
| `rResult` | var | Private |  | Result | 33 |
| `CblRslt` | var | Private |  | Result | 34 |
| `numbl` | var | Private |  | Result | 35 |
| `Jnl` | var | Private |  | String | 36 |
| `cpt` | var | Private |  | String | 37 |
| `Intit` | var | Private |  | String | 38 |
| `numecr` | var | Private |  | String | 39 |
| `numr` | var | Private |  | Integer | 40 |
| `numr2` | var | Private |  | Integer | 41 |
| `cptRem` | var | Private |  | String | 42 |
| `Ctva` | var | Private |  | String | 43 |
| `cpttva` | var | Private |  | String | 44 |
| `IntitTva` | var | Private |  | String | 45 |
| `Remmo` | var | Private |  | String | 46 |
| `Remart` | var | Private |  | String | 47 |
| `Ttva` | var | Private |  | Float | 48 |
| `Filename` | var | Private |  | String | 49 |
| `Totalrem` | var | Private |  | String | 50 |
| `totalht` | var | Private |  | String | 51 |
| `Totht` | var | Private |  | String | 52 |
| `Totalttc` | var | Private |  | String | 53 |
| `Txconv` | var | Private |  | Float | 54 |
| `typeL` | var | Private |  | String | 55 |
| `Fam` | var | Private |  | String | 56 |
| `Ardi` | var | Private |  | String | 57 |
| `nbdec` | var | Private |  | String | 58 |
| `Totttc` | var | Private |  | String | 59 |
| `Brutht` | var | Private |  | String | 60 |
| `TotEuros` | var | Private |  | String | 61 |
| `nom` | var | Private |  | String | 62 |
| `Mttc` | var | Private |  | String | 63 |
| `Bonl` | var | Private |  | Result | 64 |
| `dtex` | var | Private |  | String | 65 |
| `dte` | var | Private |  | String | 66 |
| `Devises` | var | Private |  | String | 67 |
| `Coulfond` | var | Private |  | New String[] | 68 |
| `sclient` | var | Private |  | String | 69 |
| `sclient2` | var | Private |  | String | 70 |
| `Exo` | var | Public |  | Boolean | 71 |
| `Ccli` | var | Private |  | String | 72 |
| `libel` | var | Private |  | String | 73 |
| `dateech2` | var | Private |  | String | 74 |
| `chkfam` | var | Private |  | Boolean | 75 |
| `bchktva` | var | Private |  | Boolean | 76 |
| `Famachat` | var | Private |  | String | 77 |
| `NmFic` | var | Private |  | String | 78 |
| `skey` | var | Private |  | String | 79 |
| `$soption` | var | Private |  | String | 80 |
| `$bvign` | var | Private |  | Boolean | 81 |
| `Bsel` | var | Public |  | Boolean | 83 |
| `Bval` | var | Public |  | String | 84 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 89-145 | Public | 4 | 52 | 0 | méthode spéciale |
| `recup_bl` | 150-268 | Public | 29 | 116 | 0 | portée réductible ? |
| `Colbl_Click` | 270-293 | Public | 6 | 21 | 0 | handler GUI |
| `Colbl_Keypress` | 295-322 | Public | 8 | 25 | 0 | handler GUI |
| `Coldetail_Activate` | 324-331 | Public | 1 | 5 | 0 | handler GUI |
| `Coldetail_MouseUp` | 334-355 | Public | 6 | 17 | 0 | handler GUI |
| `Coldetail_Keypress` | 357-396 | Public | 12 | 37 | 0 | handler GUI |
| `Quittedate` | 401-452 | Public | 9 | 49 | 0 | portée réductible ? |
| `Button1_KeyPress` | 454-458 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 460-492 | Public | 4 | 28 | 0 | handler GUI |
| `Button5_Click` | 494-499 | Public | 3 | 4 | 0 | handler GUI |
| `Radiobutton1_Click` | 501-508 | Public | 1 | 6 | 0 | handler GUI |
| `Radiobutton2_Click` | 510-521 | Public | 2 | 9 | 0 | handler GUI |
| `CodeFour_KeyPress` | 523-536 | Public | 5 | 12 | 0 | handler GUI |
| `Togglebutton1_Click` | 538-551 | Public | 3 | 11 | 0 | handler GUI |
| `Gen_ecr` | 553-763 | Public | 40 | 199 | 0 | portée réductible ? |
| `FileFilter` | 765-772 | Private | 1 | 5 | 0 |  |
| `Parametres` | 777-785 | Public | 2 | 7 | 0 | portée réductible ? |
| `Ventilation` | 790-805 | Public | 1 | 12 | 0 | portée réductible ? |
| `Raz_Ventilation` | 807-814 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Totalisation` | 820-913 | Public | 18 | 79 | 0 | portée réductible ? |
| `Verif_solde` | 915-954 | Public | 9 | 37 | 0 | portée réductible ? |
| `Maj_Compta` | 959-1099 | Public | 24 | 138 | 0 | portée réductible ? |
| `Ecritures` | 1104-1121 | Public | 3 | 15 | 0 | portée réductible ? |
| `Majnum` | 1126-1133 | Public | 1 | 5 | 0 | portée réductible ? |
| `Bl_Sup` | 1138-1148 | Public | 1 | 8 | 0 | portée réductible ? |
| `Btn_Click` | 1150-1171 | Public | 4 | 19 | 0 | handler GUI |
| `ard` | 1176-1213 | Public | 14 | 33 | 0 | portée réductible ? |
| `Button16_Click` | 1215-1219 | Public | 1 | 3 | 0 | portée réductible ? |
| `Datej_DblClick` | 1221-1229 | Public | 2 | 7 | 0 | handler GUI |
| `Datej_KeyPress` | 1231-1248 | Public | 8 | 16 | 0 | handler GUI |
| `DateChooser1_Activate` | 1250-1255 | Public | 1 | 4 | 0 | handler GUI |
| `totalconsigne` | 1257-1290 | Private | 5 | 32 | 0 |  |
| `Button7_Click` | 1295-1299 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et listes

- **`_New()`** [portée : nécessaire (constructeur)] [mixte]. Devise (`Fiches_Parametres`),
  couleurs (`Utils.Coulfd`), `Utils.Observers`, option, musique, colonnes de `Colbl`/`Coldetail`,
  date du jour, et détection d'une famille sans compte d'achat
  (`WHERE isnull(compt3_fam)` : fonction MySQL `ISNULL()`, traduite pour SQLite par
  `DB_Connection`) qui bloque ensuite le traitement.
- **`recup_bl()`** [portée : réductible, appelée par `Button1_Click`] [mixte]. Tables de travail
  `BRfm` et `Br` recréées à chaque appel (non partagées entre postes : collision possible en
  multi-poste) ; cumuls en chaînes (`Utils.cpoint`/`Val`) ; remplit `Colbl` et sélectionne le
  premier fournisseur (ou `skey`, jamais affecté).
- **`Colbl_Click()`** [handler, `replay_dynamic` : doit rester `Public`] [mixte]. Détail des BR
  du fournisseur (`Br`), arguments surnuméraires `"B"`, `"F"`, `0` passés à `Exec`.
- **`Colbl_Keypress()`** [handler] [mixte]. Suppr : retire le fournisseur de `BRfm` (exclusion du
  traitement).
- **`Coldetail_Activate()`** [handler] [GUI]. Ouvre la réception dans `commande1`
  (`New Commande1(Null, num, four, date)`).
- **`Coldetail_MouseUp()`** [handler] [mixte]. Clic droit : affiche le commentaire de la BR ;
  mémorise la BR courante (`sclient2`).
- **`Coldetail_Keypress()`** [handler] [mixte]. Suppr : retire la BR de `Br` et recalcule les
  totaux affichés ; Entrée : `Coldetail_Activate`.
- **`Button1_KeyPress()` / `Button1_Click()`** [handlers] [mixte]. Traitement : refus si une
  famille n'a pas de compte d'achat, normalisation de la date, `recup_bl`, libellé `LVar` du
  fournisseur sélectionné (SQL avec `LIKE '" & CodeFour.Text & "%'` concaténé).
- **`Radiobutton1_Click` / `Radiobutton2_Click` / `CodeFour_KeyPress` / `Togglebutton1_Click`**
  [handlers] [GUI/mixte]. Choix tous fournisseurs / un fournisseur, contrôle du code,
  sélection par `TriCpt` (`Bsel`/`Bval`).
- **`Datej_DblClick` / `Datej_KeyPress` / `DateChooser1_Activate`** [handlers] [GUI]. Calendrier
  et normalisation de la date.
- **`Button5_Click`** [handler] : supprime `Filename` puis ferme. **`Button7_Click`** :
  `Doc.Open("Br")`.

### Génération

- **`Btn_Click()`** [handler du groupe `Btn`] [mixte]. Contrôle de `jrnal5` et du mode « un
  fournisseur », puis `Gen_ecr(Last.Tag)`.
- **`Gen_ecr(Mode)`** (CC max du fichier) [portée : réductible] [mixte]. Voir la vue d'ensemble ;
  `LOCK TABLES` explicites (y compris tables de travail), parcours de `Coldetail`, cumul par
  `Maj_Totalisation`, mise à jour `validee`, `Edbr.Init`/`Edbr.Ed(…, "ValidBR")`, insertion de
  la ligne fournisseur dans `Totalisation`, `Verif_solde`, `Maj_Compta` (mode 2), `Majnum`,
  `UNLOCK`, GED (`LGed`, tags par `"… WHERE fo_code = " & CCli` concaténé).
- **`Parametres()`** [portée : réductible] [calcul]. `Jnl = jrnal5`.
- **`Ventilation()` / `Raz_Ventilation()`** [portée : réductible] [calcul]. `DROP`/`CREATE` puis
  `TRUNCATE` de la table de travail `Totalisation`.
- **`Maj_Totalisation()`** [portée : réductible] [calcul]. Cumule HT et TVA par compte de
  famille et de TVA dans `Totalisation` (montants texte, `TotTva = "O.OO"` avec des lettres O).
- **`Verif_solde()`** [portée : réductible] [calcul]. Ajuste le dernier compte de charge pour
  équilibrer débit/crédit (écart d'arrondi).
- **`Maj_Compta()`** [portée : réductible] [calcul]. Insère les lignes de `Fiches_Mvt` (journal
  `Jnl`, numéros `numecriture`/`numecriture2`), met à jour les soldes de `Fiches_Comptes`,
  `Sha1Calc.CalcSha1("Fiches_Mvt", …)` (nom de table en dur, voir notes transverses).
- **`Ecritures(numecr)`** [portée : réductible] [calcul]. Lit la colonne `numecr` de
  `Fiches_Parametres` (nom de colonne concaténé).
- **`Majnum()`** [portée : réductible] [calcul]. Écrit `numecriture`/`numecriture2`.
- **`totalconsigne(dte, numbl, numfr)`** [Private] [calcul]. Option boissons : ajoute les
  consignes (`Fiches_ligcons`) au compte `consfou` de `Totalisation` (dans une transaction).

### Code mort interne (`unused`, vérifié)

- **`Quittedate()`** : contrôle de la date par rapport à la période (jamais appelé, l'appel est
  commenté dans `Button1_Click`).
- **`FileFilter()`** : renvoie `["*.*"]`, jamais appelé.
- **`Bl_Sup()`** : `DELETE` sur des colonnes inexistantes (`numbl`, `numrecptl`) avec `Bonl`
  jamais affecté.
- **`ard(Puttc)`** : arrondi de prix, **identique ligne pour ligne** à
  [`Facturergbl.ard`](../../Facturation/Facturergbl.class/architecture.md) (vérifié par `diff`).
- **`Button16_Click()`** : aucun contrôle `Button16` dans le `.form`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings` (`/Soc<XX>/Ged`, `/Coul/Znss`,
  `/Soc<XX>/Coul_fen`), `Start.Societe`, `Variables.inumr` (écrit).
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_*`, `Utils.Calcech`, `Utils.totobs`, `Utils.Coulfd`,
  `Utils.FColr`, `Utils.convBool`, `Cbase.Table`, `Edbr`, `Sha1Calc`, `LGed`, `LVar`,
  `Calculdroit`, `TriCpt`, `commande1`, `Doc`, `Music`.
- ~45 variables membres sans mot-clé (donc `Private`), non typées pour la plupart, utilisées comme
  canaux implicites entre fonctions (`Totalht`, `Fam`, `Txconv`, `exo`, `cpt`, `numr`…).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune tant que le sort du fichier n'est pas décidé (A01). Si l'utilisateur garde l'écran :
  remplacer les tables de travail par des collections en mémoire, typer les membres, aligner sur
  `ValidBR1` (qui fait le même travail par `EcrAuto`).

### Commonalisation avec d'autres fichiers

- `ard` = `Facturergbl.ard` (notes transverses) et arrondi au 0,05 par chaîne (`Utils.arrondi`,
  `LPrix.Arrondi_Calc`…) : à supprimer avec le fichier, sinon commonaliser.
- Génération d'écriture d'achat : remplacée par [ValidBR1](../ValidBR1.class/architecture.md) +
  [EcrAuto](../../../Compta/Utils/EcrAuto.class/architecture.md).
- `Quittedate` : même contrôle que `Facturergbl`/`FacturefmA` (commonalisation « Quittedate » des
  notes transverses).

### Réduction de portée

- `recup_bl`, `Gen_ecr`, `Parametres`, `Ventilation`, `Raz_Ventilation`, `Maj_Totalisation`,
  `Verif_solde`, `Maj_Compta`, `Ecritures`, `Majnum`, `Exo` → `Private` si le fichier est
  conservé ; `Quittedate`, `Bl_Sup`, `ard`, `Button16_Click`, `FileFilter` relèvent du code mort.
  `Colbl_Click` et les autres handlers restent `Public`.

### Séparation traitement / GUI

- Sans objet tant que A01 n'est pas tranchée.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de travail `BRfm`, `Br`, `Totalisation` (créées à l'exécution, absentes de
  `db_control.csv`) disparaîtraient avec le fichier.
