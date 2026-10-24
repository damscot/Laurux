# FpromoArt — Architecture

> Source : `.src/Gestion/Tables/FpromoArt.class`

## Vue d'ensemble

Écran de **gestion des articles d'une promotion** (`Fiches_ArtPromo` : `code_promo` char(6) +
`code` varchar(15) en clé primaire, `libelle`, `pmp`, `pht`, `pttc`, `qte`). Ouvert en modal par
`Fmenu.class:1927` (`FpromoArt.ShowModal()`). La promotion elle-même est créée dans
[Fpromo](../Fpromo.class/architecture.md).

Déroulement : choix de la promotion (`Code`, saisie + Entrée ou liste `Colpromo` par `Button5`/F2),
puis pour chaque article : code (`CArt`, saisie, `*` + code-barres, ou sélection `TriArticles` par
`Button6`/F2), prix promo HT (`Pht`) ou TTC (`Pttc`) avec calcul de l'autre selon le taux de TVA
de l'article (`Fiches_Tvaav`), contrôle de marge par rapport au prix de revient (`Pht2`) et au
prix de vente normal (`Pht3`), puis enregistrement (`Button3`). La grille `Colartpromo`
(`Utils.Base`/`Utils.rs1`) liste les articles de la promotion ; un clic charge la ligne, la touche
Suppr la retire (`button2_Click`).

Groupe `Cmpt` : `Code` (1), `CArt` (2), `Desg2` (3), `Pht` (4), `Pttc` (5), et aussi les zones en
lecture seule `Pht2`, `Marge`, `Pht3` (tag 2). Boutons hors groupe.

Nature : **mixte** : calculs de prix (TVA, marge) mêlés aux contrôles, SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 27 |
| `sel` | var | Private |  | String | 28 |
| `PArtTable` | var | Private |  | New String[7] | 29 |
| `Txtva` | var | Private |  | Float | 30 |
| `rResult` | var | Private |  | Result | 31 |
| `son` | var | Private |  | Integer | 32 |
| `CoulZns` | var | Private |  | Integer | 33 |
| `CoulZnaf` | var | Private |  | Integer | 34 |
| `Coulfc` | var | Private |  | Integer | 35 |
| `stva` | var | Private |  | String | 36 |
| `Margem` | var | Private |  | String | 37 |
| `Margep` | var | Private |  | String | 38 |
| `Prvt` | var | Private |  | String | 39 |
| `B` | var | Private |  | Integer | 40 |
| `Bsel` | var | Public |  | Boolean | 41 |
| `Bval` | var | Public |  | String | 42 |
<!-- /AUTO:declarations -->

Remarque : `Tri`, `sel`, `PArtTable`, `Txtva`, `rResult`, `son`, `CoulZns`, `CoulZnaf`, `Coulfc`,
`stva`, `Margem`, `Margep`, `Prvt`, `B` (lignes 27-40, sans mot-clé, donc `Private`) ne figurent
pas dans le tableau généré. Les trois couleurs et `Margem`, `Margep`, `Prvt` ne servent qu'au code
mort.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 44-86 | Public | 1 | 39 | 0 | méthode spéciale |
| `Code_KeyPress` | 91-110 | Public | 4 | 17 | 0 | portée réductible ? |
| `Button5_Click` | 115-144 | Public | 4 | 27 | 0 | handler GUI |
| `Colpromo_Click` | 146-156 | Public | 1 | 9 | 0 | handler GUI |
| `Colpromo_KeyPress` | 158-172 | Public | 9 | 12 | 0 | handler GUI |
| `Cpromo` | 174-195 | Public | 3 | 19 | 0 | portée réductible ? |
| `Cmpt_Keypress` | 197-275 | Public | 22 | 70 | 0 | handler GUI |
| `ChkPrx` | 277-285 | Public | 7 | 7 | 0 | portée réductible ? |
| `Colartpromo_Data` | 287-299 | Public | 7 | 11 | 0 | handler GUI |
| `Deb2` | 301-305 | Public | 1 | 3 | 0 | portée réductible ? |
| `button3_KeyPress` | 307-311 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 313-334 | Public | 6 | 19 | 0 | handler GUI |
| `Button4_Click` | 336-340 | Public | 1 | 3 | 0 | handler GUI |
| `Button6_Click` | 342-351 | Public | 2 | 8 | 0 | handler GUI |
| `CleanChamps` | 353-363 | Public | 1 | 9 | 0 | portée réductible ? |
| `ColArtPromo_Click` | 368-377 | Public | 2 | 8 | 0 | handler GUI |
| `ColArtPromo_KeyPress` | 382-386 | Public | 2 | 3 | 0 | handler GUI |
| `button2_Click` | 388-401 | Public | 3 | 11 | 0 | handler GUI |
| `delArt` | 403-410 | Public | 1 | 6 | 0 | portée réductible ? |
| `SelectionArt` | 413-425 | Public | 2 | 10 | 0 | portée réductible ? |
| `art_man` | 430-470 | Public | 8 | 38 | 0 | portée réductible ? |
| `CalcTTC` | 475-480 | Public | 1 | 4 | 0 | portée réductible ? |
| `CalcHt` | 485-493 | Public | 1 | 7 | 0 | portée réductible ? |
| `Recup_Tva` | 498-506 | Public | 2 | 7 | 0 | portée réductible ? |
| `Calc_Marge` | 511-520 | Public | 3 | 8 | 0 | portée réductible ? |
| `Button1_Click` | 525-529 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Choix de la promotion

- **`_New()`** [portée : nécessaire] [nature : GUI] : délai des bulles, couleurs (inutilisées),
  `Utils.Observers`, `Music.Load`, en-têtes et colonnes de `Colpromo` et `Colartpromo`, focus code.
- **`Code_KeyPress()`** [handler inactif] : relecture de la promotion sur Entrée avec bulle
  d'avertissement ; **jamais levé** car `Code` appartient au groupe `Cmpt` (`handlers_inactifs`) ;
  la saisie passe par `Cmpt_Keypress` → `Cpromo`. Code mort (comportement voisin mais différent :
  bulle au lieu de `Message.Error`, dates non converties).
- **`Button5_Click()`** [handler] : bascule la liste `Colpromo` (2 colonnes) remplie par
  `SELECT * FROM <TabPromo>` ; écrit aussi `Item[2]`/`Item[3]` (dates) au-delà des deux colonnes
  (stockage à confirmer, relu par `Colpromo_Click`).
- **`Colpromo_Click()`** [handler] : promotion choisie → zones (dates `/` → `.`), liste masquée,
  `Deb2`. Rejoué par `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Colpromo_KeyPress()`** [handler] (CC 9) : Entrée → choix ; F2/Échap/Suppr → fermeture ou
  réouverture de la liste.
- **`Cpromo()`** [portée : réductible] [nature : mixte] : `SELECT … where code = &1` ; recopie ou
  `Message.Error` et retour au code.

### Saisie des articles

- **`Cmpt_Keypress()`** [handler du groupe `Cmpt`] (CC 22, max du fichier) : filtre numérique
  (`ChkPrx`) sur les prix ; sur validation : code → `Cpromo` ; article → `Art_Man` ;
  libellé → prix HT ; prix HT → marge `Pht − Pht2`, avertissement si ≤ 0 (drapeau `B`), sinon
  formatage et `CalcTTC` ; prix TTC → `CalcHt`, marge, avertissement, et question si le prix promo
  HT dépasse le prix de vente normal (réponse « Non » : prix effacés) ; F2 → listes.
  Le drapeau `B` positionné dans la branche TTC n'est remis à 0 que dans la branche HT
  (anomalie A03).
- **`ChkPrx()`** [portée : réductible] : refuse les caractères hors `0-9,.`.
- **`art_man()`** [portée : réductible] [nature : mixte] : `*` en tête → `Utils.Find_Cbarre` ;
  recherche **article stocké** (`art_stocke = True`) par code, puis code fournisseur, puis code
  équivalent ; recopie désignation, prix de revient, prix de vente HT, code TVA et taux
  (`<TabTvav>`) ; sinon avertissement.
- **`Button6_Click()`** [handler] : `SelectionArt` si une promotion est saisie.
- **`SelectionArt()`** [portée : réductible] : `New TriArticles(…, Me)` en modal ; le résultat
  revient par `Bsel`/`Bval`, écrits par `TriArticles` via `Object.SetProperty` (variables
  `Public` requises).
- **`CalcTTC()`** / **`CalcHt()`** [portée : réductible] [nature : calcul + GUI] : `Recup_Tva`,
  puis TTC = HT × (1 + taux/100) ou HT = TTC / (1 + taux/100), formatés `0.00` ; `CalcHt` modifie
  la variable de module `Txtva`.
- **`Recup_Tva()`** [portée : réductible] [nature : calcul] : taux de TVA de `stva` (`<TabTvav>`).
- **`Calc_Marge()`** [portée : réductible] : marge en valeur et en pourcentage sur `Prvt`, qui n'est
  jamais renseigné ; **jamais appelée** (`unused`, code mort).

### Enregistrement, liste et suppression

- **`Deb2()`** [portée : réductible] [nature : mixte] : `Utils.Base(Colartpromo, "select * from
  <TabArtPromo> where code_promo = '<code>' order by '<Tri>'")` : code **concaténé** et tri sur la
  **chaîne littérale** `'code'` (aucun tri effectif) (anomalie A01).
- **`Colartpromo_Data(Row, Column)`** [handler] : affichage depuis `Utils.rs1`, prix au format `0.00`.
- **`button3_KeyPress()`** [handler] : toute touche sur le bouton Enregistrer enregistre.
- **`Button3_Click()`** [handler] [nature : mixte] : si promotion, article et prix HT saisis,
  `SELECT` ; si l'article est déjà dans la promotion, question puis
  `UPdate … SET libelle, pht, pttc`, sinon `INSERT (code_promo, code, libelle, pmp, pht, pttc)`
  (`pmp` = prix de revient affiché), montants convertis par `Val` ; puis `Deb2`, `CleanChamps`.
- **`ColArtPromo_Click()`** [handler] : ligne → zones, `art_man`, marge. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`ColArtPromo_KeyPress()`** [handler] : Suppr → `button2_Click`.
- **`button2_Click()`** [handler] [nature : mixte] : si l'article figure dans des lignes de BL
  (`<TabLigbl>`, `code_ligbl`), confirmation ; puis `delArt`.
- **`delArt()`** [portée : réductible] : `DELETE … WHERE code_promo = &1 and code = &2`, `Deb2`,
  `CleanChamps`.
- **`CleanChamps()`** [portée : réductible] : vide les zones article.
- **`Button4_Click()`** [handler] : ferme. **`Button1_Click()`** [handler] : `Doc.Open("Promo")`.

## État global utilisé

- `Utils.db`, `Utils.Base`, **`Utils.rs1`**, `Utils.cpoint`, `Utils.Find_Cbarre`,
  `Utils.Cdate_Aff`, `Utils.FColr`, `Utils.Observers` ; `Cbase.Table` (`TabPromo`, `TabArtPromo`,
  `TabArt`, `TabTvav`, `TabLigbl`) ; `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Coul/*"]`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Code_KeyPress`, `Calc_Marge`, `Prvt`, `Margem`, `Margep` et les couleurs inutilisées.
- Découper `Cmpt_Keypress` (CC 22) en `ValidePrixHT()` et `ValidePrixTTC()` privés (comportement
  identique, drapeau `B` compris).

### Commonalisation avec d'autres fichiers

- Calcul HT/TTC/TVA : [LPrix](../../../Utils/LPrix.class/architecture.md) et
  [LTaxe](../../../Utils/LTaxe.class/architecture.md) fournissent ces conversions ; `CalcTTC`,
  `CalcHt`, `Recup_Tva` sont aussi dupliqués dans `Facture` (homonymes).
- Recherche d'article par code / code fournisseur / code équivalent / code-barres : même cascade
  dans [MvtDepots](../../Depots/MvtDepots.class/architecture.md) (`art_man`, en version
  défectueuse) et `Facture.Art_man` → fonction commune `Utils.ChercheArticle(sCode, bStocke)`.
- Module `Promo` partagé avec [Fpromo](../Fpromo.class/architecture.md).

### Réduction de portée

`Cpromo`, `ChkPrx`, `Deb2`, `CleanChamps`, `delArt`, `SelectionArt`, `art_man`, `CalcTTC`, `CalcHt`,
`Recup_Tva` → `Private` ; `Code_KeyPress` et `Calc_Marge` supprimées. `Bsel`/`Bval` restent `Public`.

### Séparation traitement / GUI

`PrixTTC(fHT, sCodeTva) As Float`, `PrixHT(fTTC, sCodeTva) As Float`, `EnregistreArtPromo(...)`,
`SupprimeArtPromo(sPromo, sArt)` sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aligner `code_promo` char(6) sur `Fiches_Promo.code` varchar(15) ; clé étrangère vers
  `Fiches_Promo` et `Fiches_Art`.
