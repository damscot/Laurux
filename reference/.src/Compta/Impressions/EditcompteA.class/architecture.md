# EditcompteA — Architecture

> Source : `.src/Compta/Impressions/EditcompteA.class`

## Vue d'ensemble

`EditcompteA` est l'**écran d'édition des extraits de comptes analytiques** (menu Comptabilité >
Impressions > Analytiques > Comptes, `Fmenu.Menu293_Click` → `EditcompteA.ShowModal()`,
auto-instance). Le suffixe `A` signifie **analytique**, pas « archive ». Créé en janvier 2012 par
copie d'[`Editcompte`](../Editcompte.class/architecture.md) (491 lignes communes en séquence), il en
garde l'essentiel :

- deux natures seulement dans le `.form` : `Bgestion` (`G`, par défaut, plage `60000` → `69999999`
  à l'ouverture) et `Bbilan` (`B`) ;
- la même sélection d'exercice (`E0`, `E1`, `N1`…`N5` → `Tab0` = `Fiches_Mvt`…`Fiches_Mvt5`)… dont
  `Tab0` **n'est pas utilisé** par l'impression, qui lit toujours `Fiches_MvtA` (anomalie
  EDITCOMPTEA-A02) ;
- l'impression **en ligne** dans `Button1_Click` (pas de module `M`), sur `Ccompta`
  (`.src/Reports/Ccompta.class`, `Inherits PdfWriter`) avec les niveaux analytiques `Level1CA` /
  `Level2CA`, PDF `~/tmp/Extrait.pdf` ;
- un export texte `Button2_Click` **inatteignable** : le `.form` n'a pas de bouton « Exporter »
  (aucun contrôle du groupe `Btn` avec `Tag = 1`).

Nature globale : **GUI** + impression **mixte** (SQL, table de travail `Ctrlnc`, PDF).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private |  | Float | 11 |
| `CredHP` | var | Private |  | Float | 12 |
| `TotSldHP` | var | Private |  | Float | 13 |
| `TotDeb` | var | Private |  | Float | 14 |
| `TotCred` | var | Private |  | Float | 15 |
| `TotSld` | var | Private |  | Float | 16 |
| `Slddeb` | var | Private |  | Float | 17 |
| `Sldcred` | var | Private |  | Float | 18 |
| `Sldtot` | var | Private |  | Float | 19 |
| `debit` | var | Private |  | Float | 20 |
| `credit` | var | Private |  | Float | 21 |
| `solde` | var | Private |  | Float | 22 |
| `montantd` | var | Private |  | Float | 23 |
| `montantc` | var | Private |  | Float | 24 |
| `mnt` | var | Private |  | Float | 25 |
| `mnt1` | var | Private |  | Float | 26 |
| `dte` | var | Private |  | String | 27 |
| `dte1` | var | Private |  | String | 28 |
| `dte2` | var | Private |  | String | 29 |
| `dte4` | var | Private |  | String | 30 |
| `Txt` | var | Private |  | String | 31 |
| `Filename` | var | Private |  | String | 32 |
| `Filetxt` | var | Private |  | String | 33 |
| `type` | var | Private |  | String | 34 |
| `hfile` | var | Private |  | File | 35 |
| `Tab0` | var | Private |  | String | 36 |
| `Tab1` | var | Private |  | String | 37 |
| `jour` | var | Private |  | String | 38 |
| `Centr` | var | Private |  | Boolean | 39 |
| `Mois` | var | Private |  | String | 40 |
| `Datj` | var | Private |  | String | 41 |
| `libelle` | var | Private |  | String | 42 |
| `Compt` | var | Private |  | String | 43 |
| `IntituleCpt` | var | Private |  | String | 44 |
| `cResult` | var | Private |  | Result | 45 |
| `rResult` | var | Private |  | Result | 46 |
| `rrResult` | var | Private |  | Result | 47 |
| `Tab2` | var | Private |  | String | 48 |
| `PosY` | var | Private |  | Integer | 49 |
| `Son` | var | Private |  | Integer | 50 |
| `Coulfc` | var | Private |  | Integer | 51 |
| `pdf` | var | Private |  | Ccompta | 52 |
| `Bsel` | var | Public |  | Boolean | 54 |
| `Bval` | var | Public |  | String | 55 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 60-85 | Public | 2 | 23 | 0 | méthode spéciale |
| `Ex1` | 90-109 | Public | 2 | 17 | 0 | portée réductible ? |
| `Exo` | 114-133 | Public | 1 | 17 | 0 | portée réductible ? |
| `Exo1` | 138-153 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo2` | 158-173 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo3` | 178-193 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo4` | 198-213 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo5` | 218-237 | Public | 1 | 17 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 242-294 | Public | 12 | 38 | 0 | handler GUI |
| `Btn_Click` | 299-318 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 323-329 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LostFocus` | 331-354 | Public | 9 | 21 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 356-387 | Public | 12 | 29 | 0 | portée réductible ? |
| `Compdate` | 389-400 | Public | 3 | 10 | 0 | portée réductible ? |
| `compdate2` | 402-413 | Public | 3 | 10 | 0 | portée réductible ? |
| `Raz` | 418-431 | Public | 1 | 12 | 0 | portée réductible ? |
| `Bgestion_Click` | 436-445 | Public | 1 | 8 | 0 | handler GUI |
| `Bbilan_Click` | 450-459 | Public | 1 | 8 | 0 | handler GUI |
| `E0_Click` | 464-469 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 474-479 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 484-489 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 494-499 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 504-509 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 514-519 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 524-529 | Public | 1 | 4 | 0 | handler GUI |
| `Button4_Click` | 534-545 | Public | 2 | 9 | 0 | handler GUI |
| `Button5_Click` | 550-561 | Public | 2 | 9 | 0 | handler GUI |
| `content1` | 566-570 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees` | 572-576 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 578-582 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 587-772 | Public | 19 | 181 | 0 | portée réductible ? |
| `Centralisation` | 777-800 | Public | 2 | 21 | 0 | portée réductible ? |
| `finmois` | 805-816 | Public | 2 | 9 | 0 | portée réductible ? |
| `Button2_Click` | 821-929 | Public | 17 | 104 | 0 | portée réductible ? |
| `Button3_Click` | 934-938 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Fonctions identiques à `Editcompte`

Corps identiques (hors commentaires) à ceux d'`Editcompte`, voir
[Editcompte](../Editcompte.class/architecture.md) pour le détail : `Ex1`, `Exo`, `Exo1`…`Exo4`
[portée : réductible] [nature : mixte] ; `Btn_Click`, `Cmpt_GotFocus`, `Bgestion_Click`,
`Bbilan_Click`, `E0_Click`, `E1_Click`, `N1_Click`…`N5_Click`, `Button4_Click`, `Button5_Click`,
`Button3_Click` [portée : nécessaire, handlers] [nature : GUI/mixte] ; `Compdate`, `compdate2`, `Raz`
[portée : réductible] ; `finmois` [portée : réductible] [nature : calcul] ; `content1`, `donnees`,
`donnees2` [portée : réductible] (**code mort** ici : seul `Button2_Click`, lui-même mort, appelle
`donnees`). `Btn_Click` tag 3 supprime `~/tmp/Extrait.pdf` (ici `Filename` est affecté par
`Button1_Click`) avant de fermer.

### Fonctions modifiées

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Comme `Editcompte._New`, avec la plage
  de gestion `60000` → `69999999`, `type = "G"`, `filetxt = ~/tmp/extrait.txt`, et la lecture d'une
  couleur `/Coul/Focus` dans `Coulfc`, **jamais utilisée**.
- **`Exo5()`** [portée : réductible] [nature : mixte]. Même calcul qu'`Editcompte.Exo5` avec une
  variable locale `iMois` au lieu de la variable de classe `Mois`.
- **`Cmpt_KeyPress()`** [portée : nécessaire, handler du groupe `Cmpt`] [nature : GUI]. Navigation
  seule, **sans** contrôle du préfixe des comptes ; F1/F2 comme `Editcompte`.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [portée : à garder `Public` (nom de handler), appelés
  seulement par `Cmpt_KeyPress` : les champs sont dans le groupe `Cmpt`] [nature : mixte]. Ajoutent
  avant `Utils.Cdate_calc` un prétraitement : longueur 2 ou 3 → `jj` + `.mm.aaaa` du jour ; longueur 5
  ou 6 → 5 premiers caractères + `.aaaa` du jour. ⚠️ Une saisie `jjmmaa` (6 chiffres) perd l'année
  tapée (`121025` → `12102.2026` → 12/10/2026) et une saisie de 3 caractères (`1.2`) donne une date
  fausse (`1..10.2026` → 11/02/2026) : anomalie EDITCOMPTEA-A03. `Cdate_calc` gère déjà seul ces
  formats.
- **`Centralisation()`** [portée : réductible] [nature : calcul + SQL]. Identique à
  `Editcompte.Centralisation` sur la table `Ctrlnc`. `IntituleCpt` n'étant affecté que par
  `Button2_Click` (mort), la colonne `intitule` est insérée vide.

### Impression

- **`Button1_Click()`** (CC 19, 181 LOC) [portée : nécessaire, handler, via `Btn_Click` tag 2]
  [nature : mixte]. Pas de `Catch`.
  1. `Shell "cd ~"` sans effet ; `Ccompta` A4 ; société (`Cbase.Table("TabSoc")`) ; en-tête
     « Extrait de compte analytique », `Level0C`, `Level1CA` ; `Me.Mouse = Wait`.
  2. Comptes `Cbase.Table("TabComptes")` de la plage et du `type`.
  3. Pour chaque compte ayant une ventilation dans `Fiches_Analytiques` (`Cbase.Table("TabAna")`,
     `SELECT * … WHERE compte = &1`) : écritures validées de **`Fiches_MvtA`** (`TabMvtA`) dans la
     période (filtre SQL `dte >= aaaammjj and dte <= aaaammjj`).
  4. Compte mouvementé : `DROP`/`CREATE TABLE Ctrlnc` (dans la boucle), en-tête de compte
     `Level3C`, une ligne `Level2CA` par écriture (libellé, journal, date `jj.mm.aa`, `numero`,
     `numdoc`, débit, crédit, solde cumulé) ; compte centralisé : `Centralisation()` puis lignes
     mensuelles.
  5. Total du compte : **`pdf.level4C(totdeb, totcred, totsld, Posy)`** avec 4 arguments alors que
     `Ccompta.Level4C` en attend 5 (`…, compte, posy`) → erreur d'exécution « Not enough arguments »
     attendue au premier compte mouvementé, non interceptée (anomalie EDITCOMPTEA-A01, à confirmer
     par EDITCOMPTEA-T03). L'édition analytique ne peut alors jamais aboutir.
  6. Fin (si le point 5 passe) : `Level5C` (« Total grand livre »), `BasPage`, `Output`,
     `Visualiseur.Prog` ; sinon « Aucune ecriture pour cette demande ». Curseur remis à
     `Mouse.Pointing` (et non `Default`).
  Sauts de page : 4 copies du même bloc (seuil 273) ; titre « Extrait de compte analytique » sur le
  premier saut, « Extrait de compte » sur les autres.
- **`Button2_Click()`** [portée : réductible] — **code mort** (aucun contrôle ne le déclenche). Copie à
  94 % d'`Editcompte.Button2_Click` ; lit `Tab0` (écritures générales, pas analytiques) et
  `rResult!numdoc`/`numlot` (`numlot` n'existe pas dans `Fiches_MvtA`, mais le code lit `Tab0`).

## État global utilisé

- `Utils.db` ; `Cbase.Table("TabSoc" | "TabComptes" | "TabAna" | "TabMvtA")` ; en dur :
  `Fiches_Parametres`, `Fiches_Mvt`…`Fiches_Mvt5` (dans `Tab0`, inutilisé par l'impression),
  `Fiches_Comptes` (export mort) ; table de travail `Ctrlnc`.
- `Utils.Calc_mois`, `Cdate_*`, `SetEditColor`, `Observers`, `FColr`, `db.Engine()`.
- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/Coul/Focus"]`.
- `Bsel`/`Bval` écrits par `TriCpt` ; `Visualiseur.Prog` ; `Ccompta`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le code mort : `Button2_Click` et la branche `Case 1` de `Btn_Click`, `content1`,
  `donnees`, `donnees2`, `Coulfc`/`Frmt`, `filetxt`, `Tab2`, `Lib`, `Libel`, `Nbpage`, `p`, le
  `Shell "cd"`, les affectations `totdeb = totdeb`.
- Factoriser les 4 blocs de saut de page de `Button1_Click` en un helper privé
  `SautPage(titre As String)` (titres actuels conservés).

### Commonalisation avec d'autres fichiers

- **Trio Editcompte / EditcompteA / EditcompteM** : 29 fonctions identiques à `Editcompte` (voir
  [Editcompte](../Editcompte.class/architecture.md#commonalisation-avec-dautres-fichiers)) ;
  `Button1_Click` partage 126 lignes (ratio 0,62) avec
  [`EditcompteM.Imprime`](../EditcompteM.module/architecture.md) : même parcours comptes → écritures →
  centralisation → totaux, avec des différences de rendu (`Level1CA`/`Level2CA`, colonne `numero`,
  titres, pas de sous-comptes ni de totaux par type). Socle proposé : `EditcompteM.Imprime`
  paramétré (table d'écritures, filtre analytique, jeu de niveaux, titre) **après** décision sur
  EDITCOMPTEA-A01/A02, car la fusion corrige de fait l'appel `level4C`. Avant cette décision, seules
  la centralisation (helper commun, voir EDITCOMPTE-006) et les bornes d'exercice sont mises en
  commun.
- `Centralisation`/`finmois` : voir le helper commun « centralisation » (Editcompte, EditcompteM,
  Extrait).
- [`JournauxA`](../JournauxA.class/architecture.md) (pendant analytique des journaux) lit lui aussi
  toujours `TabMvtA` (l. 616, 618) quel que soit l'exercice choisi dans `Tab0` : même défaut, à
  traiter de façon cohérente avec EDITCOMPTEA-A02.

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Raz`, `Centralisation`, `finmois` → `Private` ;
  `Button2_Click`, `content1`, `donnees`, `donnees2` supprimés (code mort, pas de contrôle associé).
- `Bsel`/`Bval` restent `Public` (`TriCpt`) ; `dteN*_LostFocus` gardent leur nom et leur portée.

### Séparation traitement / GUI

- `Button1_Click` : extraire le parcours (SQL + centralisation) dans une fonction sans contrôle qui
  reçoit `cpt`, `cpt2`, `type`, `d0`, `d1` ; le handler garde souris, messages et visualiseur.
- `dteN0_LostFocus`/`dteN1_LostFocus` : helper pur `PretraiteDate(texte, aujourdhui) As String`
  (comportement actuel conservé, anomalie A03 comprise) partagé par les deux champs.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Ctrlnc` : même remarque que `Ctrln` dans Editcompte (table permanente recréée, multi-poste).
- `Fiches_MvtA`…`MvtA5` : une colonne d'exercice dans une table unique éviterait la sélection de table
  (cause de l'anomalie A02).
