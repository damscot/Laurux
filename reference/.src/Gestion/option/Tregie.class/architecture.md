# Tregie — Architecture

> Source : `.src/Gestion/option/Tregie.class` · Formulaire : `Tregie.form`

## Vue d'ensemble

`Tregie` est l'**écran de paramétrage des régies** (codes de droits sur les alcools, option
boissons) : une fiche par code de `Fiches_regie` avec type (`A` alcool, `B` bière, `V` vins),
taux de droit `tauxa`, seuil de degré `degres` et taux `tauxss` de la cotisation sécurité sociale,
régime acquitté/suspendu (`suspendu`), assiette volume/alcool pur (`ap`), droits différenciés sur
facture (`drfac`), compte comptable (`cdcompt`) et code TVA (`ttva`). Ouvert par `menuopt`
(`Tregie_click`, auto-instance `.Show`).

Ces paramètres sont ceux qu'appliquent [`calculdroit`](../calculdroit.class/architecture.md) et
[`calculdroit1`](../calculdroit1.class/architecture.md) (voir leurs règles).

L'écran suit le cycle de barre [`barselection`](../barselection.class/architecture.md)
(`"111111110"` : tout sauf recherche) commun à
[`Tconsigne`](../Tconsigne.class/architecture.md), [`Mreglement`](../../Tables/Mreglement.class/architecture.md),
[`Ttourne`](../Ttourne.class/architecture.md), [`Tregion`](../Tregion.class/architecture.md),
[`Tchauffeur`](../Tchauffeur.class/architecture.md) : `Begin` à la création/modification,
`Update` + `Commit` à la validation, `Rollback` à l'annulation.

Règle métier propre à l'écran : **après modification d'une régie** (`bar1_valide` avec `modr`),
`modifart` **recalcule les prix de tous les articles** de cette régie (`art_dra`) :

- droits et sécu unitaires recalculés par `New Calculdroit(code, art_volm, art_deg, 1)` ;
- régime suspendu **ou** droits sur facture : `frais = art_trsp + art_trspr + art_trspa +
  art_tsuc − art_remv + droit + secu` (+ `art_ecof` si option fioul `pp`), prix d'achat brut
  inchangé ;
- sinon (acquitté) : droits incorporés au prix d'achat brut : `pbht = pbht − (ancien montdr +
  ancien montss) + (droit + secu)`, frais inchangés ;
- puis `paht = pbht × (1 − art_tr / 100)`, `prvt = paht + frais`, arrondis à `art_nbd`
  décimales ;
- choix utilisateur : « Modifier le prix de vente » (`pvht = prvt × coef`) ou « Modifier le coeff »
  (`coef = pvht / prvt`, 4 décimales) ; `pvttc = pvht × (1 + TVA)` ;
- un PDF `~/tmp/droit.pdf` liste chaque article deux fois (avant/après) puis est affiché.

Les grilles `GridView1`/`GridView2` (onglets de `TabPanel1`) reçoivent seulement leurs en-têtes
(`affent` : 12 mois depuis le mois de `Fiches_Parametres.dteclec`, 4 exercices × S.I / Entrées /
Sorties / S.F) ; **aucune donnée n'y est jamais chargée** (commentaire « affiche gridv » sans code).

Nature globale : **GUI + SQL + calcul de prix** (`modifart`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `bs` | var | Private |  | Barselection | 3 |
| `resregie` | var | Private |  | Result | 4 |
| `$ind` | var | Private |  | Integer | 5 |
| `Bsel` | var | Public |  | Boolean | 7 |
| `Bval` | var | Public |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 10-40 | Public | 2 | 26 | 0 | handler GUI |
| `affent` | 42-99 | Private | 11 | 49 | 0 |  |
| `affichedonne` | 101-128 | Private | 5 | 25 | 0 |  |
| `affectdonne` | 130-144 | Private | 1 | 13 | 0 |  |
| `mablanc` | 146-159 | Private | 1 | 12 | 0 |  |
| `verifie` | 161-211 | Private | 13 | 48 | 0 |  |
| `erreurvide` | 213-219 | Private | 2 | 5 | 0 |  |
| `erreurnum` | 221-228 | Private | 2 | 6 | 0 |  |
| `cmpt_gotfocus` | 230-235 | Public | 3 | 4 | 0 | handler GUI |
| `cmpt_lostfocus` | 237-242 | Public | 2 | 4 | 0 | handler GUI |
| `Textcode_LostFocus` | 244-257 | Public | 3 | 11 | 0 | handler GUI |
| `Textlib_LostFocus` | 259-265 | Public | 2 | 5 | 0 | handler GUI |
| `textdr_LostFocus` | 267-273 | Public | 2 | 5 | 0 | handler GUI |
| `textss_LostFocus` | 275-294 | Public | 4 | 19 | 0 | handler GUI |
| `Texttxss_LostFocus` | 296-302 | Public | 3 | 5 | 0 | handler GUI |
| `bar1_annule` | 304-313 | Public | 2 | 9 | 0 | handler GUI |
| `bar1_valide` | 315-332 | Public | 6 | 16 | 0 | handler GUI |
| `bar1_suprimer` | 334-339 | Public | 1 | 3 | 0 | handler GUI |
| `bar1_creer` | 341-350 | Public | 1 | 8 | 0 | handler GUI |
| `bar1_modif` | 352-360 | Public | 1 | 6 | 0 | handler GUI |
| `bar1_precedent` | 362-369 | Public | 3 | 6 | 0 | handler GUI |
| `bar1_suivant` | 371-377 | Public | 3 | 6 | 0 | handler GUI |
| `bar1_dernier` | 379-386 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_premier` | 388-395 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_quitter` | 397-401 | Public | 1 | 3 | 0 | handler GUI |
| `form_Close` | 403-410 | Public | 4 | 6 | 0 | handler GUI |
| `Buttccomp_Click` | 412-422 | Public | 2 | 8 | 0 | handler GUI |
| `Buttva_Click` | 424-444 | Public | 4 | 18 | 0 | handler GUI |
| `ListBox1_Activate` | 446-452 | Public | 1 | 5 | 0 | handler GUI |
| `modifart` | 456-529 | Private | 10 | 69 | 0 |  |
| `pdfent` | 531-548 | Private | 1 | 16 | 0 |  |
| `pdfaff` | 550-566 | Private | 1 | 15 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et affichage

- **`form_Open()`** [handler] [nature : mixte]. `Utils.Observers(Me)`, observateurs `cmpt` sur 7
  zones, barre `bar1`, liste des types (« Alcool », « Biére », « Vins » avec espace final),
  `affent` des deux grilles, `SELECT * FROM Fiches_regie ORDER BY code`, première fiche.
- **`affent($grdv)`** (CC 11) [privée] [nature : GUI]. `SELECT * FROM Fiches_Parametres` ;
  découpe `dteclec` sur `/` (`sdte[0]` = mois, `sdte[2]` = année, format à confirmer) ; libellés des
  lignes (`Utils.mois`) et des 16 colonnes. Même construction que `gridvi` (voir
  [gridvi](../../../Utils/gridvi.class/architecture.md)).
- **`affichedonne()`** [privée] [nature : GUI]. Copie la régie courante dans les contrôles
  (taux avec virgule).
- **`affectdonne()`** [privée] [nature : GUI → `Result`]. Copie les contrôles ; `type =
  Left(Combotype.Current.Text)` (`A`, `B`, `V`).
- **`mablanc()`** [privée] [nature : GUI].

### Contrôles de saisie

- **`verifie()`** (CC 13) [privée] [nature : mixte, extractible : les deux requêtes]. Code et
  libellé obligatoires ; `tauxa` numérique ; si `degres` saisi, numérique et `tauxss` obligatoire et
  numérique ; compte `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1` ; TVA `SELECT * FROM
  Fiches_Tvaav WHERE code_tva = &1`. Renvoie `True` en cas d'erreur (ballon + focus).
- **`erreurvide(obj)`**, **`erreurnum(obj)`** [privées] [nature : GUI]. Ballons.
- **`cmpt_gotfocus`/`cmpt_lostfocus`** [handlers] : virgule décimale, couleurs de focus.
- **`Textcode_LostFocus`** [handler] [nature : mixte]. Code existant → ballon « Code déja créer »,
  champ vidé.
- **`Textlib_LostFocus`**, **`textdr_LostFocus`**, **`texttxss_LostFocus`** [handlers] : champ vide →
  ballon. **`textss_LostFocus`** : degré > 0 → focus sur `tauxss`, sinon vide les deux zones.

### Barre d'actions

- **`bar1_creer`** : `$ind = Index`, `Begin`, `Create9("Fiches_regie")`, `mablanc`.
- **`bar1_modif`** : `Begin`, `Utils.db.Edit("Fiches_regie", "code=&1 FOR UPDATE", cd)`. ⚠️ `FOR
  UPDATE` n'existe pas en SQLite (non traduit par `DB_Connection`) : modification impossible en
  base SQLite (à confirmer). Lit `resregie!code` sans test `Available`.
- **`bar1_valide(creer, modr)`** : sort si ni création ni modification ; `verifie()` → `Stop Event` ;
  `Update`, `Commit`, puis `modifart` si modification ; relecture, `$ind`.
- **`bar1_annule`** : `Rollback`, relecture.
- **`bar1_suprimer`** : `Print "action supprimée"` (console) : suppression non implémentée alors que
  le bouton est affiché.
- **`bar1_premier`/`precedent`/`suivant`/`dernier`/`quitter`** : navigation, fermeture.
- **`form_Close`** : même défaut que `Tconsigne` : `bar1_valide` appelé **sans argument** →
  « Not enough arguments » (vérifié `gbs3`) ; transaction laissée ouverte sur « Non ».

### Recherches

- **`Buttccomp_Click`** [handler] [nature : GUI]. `TriCpt(Bilan, Sans_Solde, Me)` ; `Bsel`/`Bval`
  écrits par `TriCpt` (`Object.SetProperty`) ; `Bsel` n'est pas remis à `False` avant l'appel.
- **`Buttva_Click`**, **`ListBox1_Activate`** [handlers]. Liste déroulante des codes TVA
  (`SELECT * FROM Fiches_Tvaav`) ; `Left(…)` sans longueur ne garde que le premier caractère du code
  (codes TVA sur 1 caractère, à confirmer ; colonne `ttva char(2)`).

### Recalcul des articles

- **`modifart()`** (CC 10) [privée] [nature : mixte, extractible : le calcul par article].
  `Start.LocalSettings["/Soc<XX>/pp"]` ; `Message.Question` (2 choix) ; `Begin` ;
  `Utils.db.Edit("Fiches_Art", "art_dra =&1", code)` ; pour chaque article : `SELECT * FROM
  Fiches_Tvaav`, calcul décrit plus haut, `Update` ; `Commit` ; PDF et `Visualiseur.Prog`.
  ⚠️ Le formulaire est relu (`Radiosusp`, `Checkdr`) **après** le `Commit` et la relecture de
  `bar1_valide` : ce sont les valeurs saisies, cohérentes. ⚠️ Division par `art_prvt` nul (choix 2)
  → erreur au milieu de la transaction. ⚠️ Si `Message.Question` renvoie une valeur autre que 1/2,
  `pxv` vaut 0 : prix de vente remis à zéro (à confirmer).
- **`pdfent(pdf)`**, **`pdfaff(pdf, …)`** [privées] [nature : GUI/édition]. En-tête et ligne du PDF
  (`PdfWriter`).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ObsGotf/ObsLstf`, `Utils.mois`, `Start.LocalSettings`,
  `Start.Societe`, `User.Home`, `Visualiseur.Prog`.
- Tables : `Fiches_regie` (créée par `modfichier`, absente de `db_control.csv`), `Fiches_Art`
  (colonnes d'option `art_dra`, `art_volm`, `art_deg`, `art_montdr`, `art_montss`, `art_trsp*`,
  `art_tsuc`, `art_remv`, `art_ecof` ajoutées par `modfichier`), `Fiches_Tvaav`, `Fiches_Comptes`,
  `Fiches_Parametres`. Noms en dur.

## Propositions d'amélioration

### Réécriture / refactorisation

- `modifart` : extraire `RecalculPrixArticle(res, dr, tva, choix, pp, suspendu_ou_drfac)` (calcul
  pur sur les valeurs, sans contrôle), le PDF et la boucle restant dans `modifart`.
- `Cbase.Table("TabArt")`, `"TabTvav"`, `"TabComptes"`, `"TabParam"` (SQL identique).
- Relecture `SELECT * FROM Fiches_regie ORDER BY code` répétée 3 fois → `Relire()`.

### Commonalisation avec d'autres fichiers

- Cycle de barre commun (MREGLEMENT-006, TCONSIGNE-004).
- En-têtes de grille mensuelle sur 4 exercices : `gridvi` (`affent`), voir notes transverses.
- Recalcul prix de revient / coefficient / prix de vente : proche de
  [`GesTar`](../../Entrées/GesTar.class/architecture.md) et `VarMajTar` (fabrique de prix
  proposée en phase 3) ; équivalence à prouver.

### Réduction de portée

Aucune : les `Public` sont des handlers ou `Bsel`/`Bval` (écrits par `TriCpt`).

### Séparation traitement / GUI

`verifie` (requêtes compte/TVA) et `modifart` (calcul) : voir rework.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_regie` et les colonnes d'option de `Fiches_Art` dans `db_control.csv`.
- `cdcompt integer` → type des comptes (`varchar`) ; clé étrangère vers `Fiches_Comptes`.
- Historiser les taux (date d'effet) au lieu de recalculer en masse les articles.
