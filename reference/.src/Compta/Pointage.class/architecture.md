# Pointage — Architecture

> Source : `.src/Compta/Pointage.class`

## Vue d'ensemble

`Pointage` est l'écran de **rapprochement bancaire** d'un compte de trésorerie. Il permet de :

- choisir le compte (`Cpt`, saisie ou `TriCpt` filtré sur les comptes de trésorerie) et afficher
  son solde comptable et son solde pointé ;
- créer ou rappeler un **relevé** (`Fiches_Rappro` : `cpt`, `nreleve`, `date_releve`,
  `date_rappro`, `solde`), avec recherche automatique du solde de départ (relevé précédent) et du
  solde final ;
- lister les écritures du compte sur une période (`dtinf`–`dtsup`) dans une grille `TriGen`
  alimentée par la requête multi-exercices de `Listextcpt` (`Fiches_Mvt` … `Fiches_Mvt5` + report à
  nouveau), filtrée par « toutes / pointées / non pointées » et « relevé unique » ;
- sélectionner des écritures (sélection multiple, tout sélectionner / désélectionner le filtre),
  calculer totaux, solde théorique et écart ;
- **pointer** ou **dépointer** la sélection (`Listextcpt.enregistrepointage` sur les 6 tables
  `Mvt`), mettre à jour `Fiches_Comptes.soldep` si le relevé est le dernier ;
- supprimer un relevé (dépointage des écritures du relevé, recalcul du solde) ;
- imprimer l'état de rapprochement (PDF `Ccompta`, `~/tmp/Pointage.pdf`, `Visualiseur`).

Ouverture : `Fmenu.class:719` (`Pointage.Show`, auto-instance, non modale).

Contrôles principaux : `Cpt` (TextReg, groupe Cpt), `Nrel`, `Dte`, `Dterappro`, `dtinf`/`dtsup`
(TextReg, groupe Dte), `Sldepart`/`Sldfinal` (TextReg, groupe Sld), `Toutes`/`Enp`/`Ep`/`RelUniq`
(groupe Modesel), `Panel1` (hôte de la grille `TriGen`), `Colrlv` (liste des relevés), boutons
`Pointage2`, `Depointage`, `SuppressionRlv`, `Imprime`, `SelectAllFil`, `DeSelectAllFil`,
`ToggleButton1` (relevés), `ToggleButton3` (comptes), `Help`, `QuitPoint`.

Nature globale : **écran GUI mixte** ; le SQL de rapprochement est en grande partie délégué à
[`Listextcpt`](../Utils/Listextcpt.class/architecture.md) (requête, totaux, pointage), le reste
(relevés, soldes, impression) est écrit directement dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 28 |
| `Bval` | var | Public |  | Variant | 29 |
| `Col` | var | Private |  | Collection | 31 |
| `tr` | var | Private |  | TriGen | 32 |
| `Selected` | var | Private |  | String[] | 33 |
| `IsLast` | var | Private |  | Boolean | 35 |
| `$lst` | var | Private |  | Listextcpt | 36 |
<!-- /AUTO:declarations -->

- `Bsel`/`Bval` : **doivent rester `Public`** : ils sont positionnés par
  `Object.SetProperty` depuis `TriCpt` (`TriCpt.class:112-113`) et `TriGen`
  (`TriGen.class:138-139`, `228-232`).
- `Col` (colonnes de la grille), `tr` (grille `TriGen`), `Selected` (numéros d'écriture
  sélectionnés, en `String[]`), `IsLast` (le relevé courant est le plus récent : autorise la mise à
  jour de `soldep`), `$lst` (requêteur `Listextcpt` du compte et de la période).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-65 | Public | 1 | 23 | 0 | méthode spéciale |
| `Update_Req` | 67-135 | Public | 3 | 46 | 0 | portée réductible ? |
| `TriGen_MajSel` | 139-162 | Public | 4 | 20 | 0 | handler GUI |
| `TriGen_Raz` | 164-169 | Public | 1 | 4 | 0 | handler GUI |
| `TriGen_Data` | 171-182 | Public | 2 | 7 | 0 | handler GUI |
| `Update_Rappro` | 184-188 | Private | 1 | 3 | 0 |  |
| `Filter_Calc` | 192-213 | Private | 7 | 18 | 0 |  |
| `ToggleButton1_MouseDown` | 219-264 | Public | 5 | 43 | 0 | handler GUI |
| `Colrlv_Click` | 269-275 | Public | 1 | 5 | 0 | handler GUI |
| `Colrlv_KeyPress` | 280-296 | Public | 4 | 14 | 0 | handler GUI |
| `Colrlv_Man` | 301-406 | Public | 11 | 90 | 0 | portée réductible ? |
| `Nrel_LostFocus` | 408-413 | Public | 1 | 4 | 0 | handler GUI |
| `Nrel_KeyPress` | 415-422 | Public | 3 | 6 | 0 | handler GUI |
| `Dte_LostFocus` | 424-430 | Public | 1 | 5 | 0 | handler GUI |
| `Dte_KeyPress` | 432-438 | Public | 3 | 5 | 0 | handler GUI |
| `Dterappro_LostFocus` | 440-445 | Public | 1 | 4 | 0 | handler GUI |
| `Dterappro_KeyPress` | 447-453 | Public | 3 | 5 | 0 | handler GUI |
| `cptman` | 458-488 | Public | 4 | 25 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 490-501 | Public | 2 | 9 | 0 | handler GUI |
| `Cpt_LostFocus` | 503-508 | Public | 1 | 4 | 0 | handler GUI |
| `Cpt_KeyPress` | 510-517 | Public | 3 | 6 | 0 | handler GUI |
| `Modesel_Click` | 519-523 | Public | 1 | 3 | 0 | handler GUI |
| `SelectAllFil_Click` | 525-543 | Public | 4 | 16 | 0 | handler GUI |
| `DeSelectAllFil_Click` | 545-563 | Public | 4 | 16 | 0 | handler GUI |
| `ClearChamps` | 565-571 | Public | 1 | 5 | 0 | portée réductible ? |
| `ClearChampsAll` | 573-587 | Public | 1 | 13 | 0 | portée réductible ? |
| `Calc_Solde` | 589-618 | Public | 3 | 25 | 0 | portée réductible ? |
| `Sld_LostFocus` | 620-626 | Public | 1 | 5 | 0 | handler GUI |
| `Sld_KeyPress` | 628-634 | Public | 3 | 5 | 0 | handler GUI |
| `Pointage2_Click` | 636-669 | Public | 8 | 25 | 0 | handler GUI |
| `Depointage_Click` | 671-704 | Public | 8 | 25 | 0 | handler GUI |
| `SuppressionRlv_Click` | 706-737 | Public | 5 | 24 | 0 | handler GUI |
| `Imprime_Click` | 739-867 | Public | 23 | 125 | 0 | handler GUI |
| `Help_Click` | 872-876 | Public | 1 | 3 | 0 | handler GUI |
| `QuitPoint_Click` | 878-882 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et grille

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Types des `TextReg` (date,
  numérique 2 décimales), dates du jour, période par défaut `début d'exercice → fin du mois`
  (`LDate(Now).EDeb`, `.FinMois`), totaux à `0,00`, puis `Update_Req()` (sans effet tant que `Cpt`
  est vide).
- **`Update_Req()`** [portée : réductible] [nature : mixte]. Construit la collection de colonnes
  (`ObjProp` : numero, P, dte, libelle, montantd, montantc, nrlv, numdoc, numlot) ; exécute
  `SELECT *, CAST(IF(pointee=TRUE, 'O', 'n') As CHAR) AS parse_having_P FROM Fiches_Mvt limit 1`
  (structure seulement ; **syntaxe `IF()` MySQL non traduite pour SQLite**, à confirmer) — si
  `Fiches_Mvt` est vide, la fonction sort et aucune liste n'est affichée, même si des exercices
  antérieurs existent ; crée `$lst = New Listextcpt(cpt, dtinf, dtsup, "t")` et enveloppe sa requête
  `SELECT * FROM (<requête sans " ORDER BY  dte">) AS a` : `Left($lst.requete, -14)` dépend de la
  longueur exacte de la clause de tri de `Listextcpt` (couplage fragile). Crée la grille
  `New TriGen(Panel1, Col, Res, Req, 20, Me) As "TriGen"`, applique le filtre et rafraîchit.
- **`Filter_Calc()`** [Private] [nature : calcul]. Filtre SQL ajouté à la grille (`tr.ExtraSel`) :
  toutes (`lind <> ' '`, exclut la ligne de report), pointées (`pointee IS TRUE`, plus `nrlv = &1`
  si relevé unique), non pointées (`pointee is NULL or pointee is FALSE`).
- **`TriGen_MajSel(val)`** [handler d'événement `TriGen`] : bascule `val` (numéro d'écriture) dans
  `Selected` si `Bsel`, met à jour `Selcnt`, rafraîchit la grille et `Calc_Solde()`. Variable
  locale `Res` inutilisée.
- **`TriGen_Raz()`** [handler] : vide la sélection.
- **`TriGen_Data(id, key, Data)`** [handler] : fond « sélectionné » pour les lignes de `Selected`
  (comparaison `Selected.Find(Val(id))` entre `String[]` et nombre).
- **`Modesel_Click()`** [handler du groupe `Modesel`] → `Filter_Calc()` (le filtre n'est pris en
  compte qu'au prochain rafraîchissement de la grille, à confirmer).
- **`SelectAllFil_Click()` / `DeSelectAllFil_Click()`** [handlers] : ajoutent / retirent de
  `Selected` tous les `numero` du résultat filtré (`tr.GetAllFiltered()`), puis totaux et
  rafraîchissement. Code quasi identique entre eux et avec `GedR` et `TriFacture`.

### Compte et relevés

- **`cptman(compte)`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Comptes where
  compte_cc = &1` ; inconnu → message ; sinon `ClearChampsAll()`, affiche intitulé, `solde`,
  `soldep` (solde de départ) puis le solde pointé :
  `SELECT (sum(montantd)-sum(montantc)) … FROM Fiches_Mvt WHERE compte = &1 and ((cloturee = 1 and
  jour = 90 and libelle = 'Report a nouveau') or pointee = 1)` — **journal d'à-nouveaux `90` en
  dur** (au lieu de `Fiches_Parametres.jdr`) et exercice courant seulement. Puis `Update_Req()` et
  `Calc_Solde()` (déjà exécutés par `ClearChampsAll`) : double travail.
- **`ToggleButton3_Click()`** [handler] : `TriCpt(TriCpt.Tresorerie, TriCpt.Avec_Solde, Me)` en
  modal, puis `cptman(Bval)` si `Bsel`. Variable `rResult` inutilisée.
- **`Cpt_LostFocus()` / `Cpt_KeyPress()`** [handlers du groupe `Cpt`] → `cptman(cpt.Text)`.
- **`ToggleButton1_MouseDown()`** [handler] [nature : mixte]. Affiche / masque `Colrlv` avec les
  relevés du compte (`SELECT * FROM Fiches_Rappro WHERE cpt = &1 order by date_releve desc, nreleve
  desc`). Boucle `Do … Loop Until` (idiome non standard du dépôt) ; branche `Else` vide.
- **`Colrlv_Click()` / `Colrlv_KeyPress()`** [handlers] : choix d'un relevé → `Colrlv_Man`.
- **`Colrlv_Man(releve) As Boolean`** [portée : réductible] (CC 11, 90 lignes) [nature : mixte].
  - Relevé existant (`SELECT … Fiches_Rappro WHERE cpt, nreleve`) : `ClearChampsAll()`, affichage
    des dates, filtre « pointées du relevé », solde de départ = solde du relevé précédent
    (`date_releve < &2 … desc limit 1`, sinon 0 + `Message.Error`), solde final = `soldep` du
    compte si aucun relevé plus récent (`IsLast = True`), sinon solde du relevé.
  - Relevé inexistant : question « Voulez-vous le créer » ; si oui, solde de départ = solde du
    dernier relevé, date = fin du mois suivant la date du dernier relevé (`FinMois.LT`), solde
    final = `soldep`, puis `insert into Fiches_Rappro (...)`.
  - Les deux branches finissent par `Update_Req()` + `Calc_Solde()`.
- **`Nrel_LostFocus()` / `Nrel_KeyPress()`** [handlers] → `Colrlv_Man(Nrel.Text)`.
- **`Update_Rappro()`** [Private] [nature : calcul]. `UPdate Fiches_Rappro SET … where cpt = &1 and
  nreleve = &2` avec dates et solde final saisis.
- **`Dte_LostFocus()` / `Dte_KeyPress()`** [handlers du groupe `Dte`, aussi `dtinf`/`dtsup`] :
  `Update_Rappro()` puis `Update_Req()`. Comme `dtinf`/`dtsup` appartiennent au groupe `Dte`, la
  modification de la période réécrit aussi le relevé courant (sans effet si `Nrel` est vide).
- **`Dterappro_LostFocus()` / `Dterappro_KeyPress()`** [handlers] : `Update_Rappro()`.
- **`Sld_LostFocus()` / `Sld_KeyPress()`** [handlers du groupe `Sld`] : `Update_Rappro()` +
  `Calc_Solde()`.

### Soldes, pointage, suppression

- **`Calc_Solde()`** [portée : réductible] [nature : mixte]. Totaux débit/crédit de la sélection
  (`$lst.totalpointe(Selected, cpt)`), solde théorique = départ + débits - crédits, écart = final -
  théorique. Partie extractible : le calcul (3 Float en entrée).
- **`ClearChamps()`** [portée : réductible] : vide la sélection, `Update_Req()`, `Calc_Solde()`.
- **`ClearChampsAll()`** [portée : réductible] : vide sélection, relevé, dates, soldes, puis
  `Update_Req()`, `Calc_Solde()`.
- **`Pointage2_Click()` / `Depointage_Click()`** [handlers] (identiques au booléen près) : contrôles
  compte/relevé, confirmation si solde final nul, `Update_Rappro()`, mise à jour de
  `Fiches_Comptes.soldep` si `IsLast` (y compris en dépointage), puis
  `$lst.enregistrepointage(Selected, True|False, cpt, nrel)` (UPDATE sur `Fiches_Mvt` … `Mvt5`) et
  `ClearChamps()`.
- **`SuppressionRlv_Click()`** [handler] [nature : mixte]. **`If Message.Question(...) Then`** : la
  fonction renvoie 1 (« Oui ») ou 2 (« Non »), toujours vrai → **le relevé est supprimé même si
  l'utilisateur répond « Non »**. Ensuite `DELETE FROM Fiches_Rappro`, dépointage
  `UPdate Fiches_Mvt SET pointee = 0, nrlv = '' where compte, nrlv` (**exercice courant seulement**,
  et `nrlv` vide au lieu de `NULL` comme `enregistrepointage`), puis `Calcsolde.Calcul(cpt, True)`
  sans le journal d'à-nouveaux (CALCSOLDE-A01 : `soldep` n'est pas recalculé). `Calcsolde` est un
  formulaire appelé sur son auto-instance.
- **`Imprime_Click()`** [handler] (CC 23, max du fichier) [nature : mixte]. Société
  (`Fiches_Societes`, sans test `Available`), puis sélection des lignes selon le mode :
  sans relevé → lignes pointées de `Fiches_Mvt` + solde pointé (`nrlv <= ''`, journal `90` en dur) ;
  avec relevé → lignes du relevé + solde du relevé ; non pointées → `… pointee is null and dte <= &5
  or … pointee = &4` (**le filtre de date ne s'applique qu'à la première branche du `or`**). Mise
  en page `Ccompta` (`Entete`, `Level0R`, `Level1R`, `Level2R`, `Level3R`, `Level6`, `BasPage`) avec
  l'en-tête de page répété 3 fois, totaux en chaînes (`Format$`/`Val`), sortie
  `User.Home/tmp/Pointage.pdf` et `Visualiseur.Prog`. `Shell "cd …"` sans effet, tests
  `= Null` sur des chaînes formatées jamais nulles, `PosX` inutilisé. Impression limitée à
  l'exercice courant (`Fiches_Mvt`).
- **`Help_Click()`** [handler] : `Doc.Open("Pointage_new")`. **`QuitPoint_Click()`** : fermeture.

## État global utilisé

- `Start.Societe` ; `Utils.db`, `Utils.Bip`, `Utils.Cdate_Aff` ; `LDate`, `LPrix` (formats `.L`,
  `.D`, `.G`).
- Classes : `Listextcpt` (requête, totaux, pointage), `TriGen` (grille), `TriCpt` (choix du compte),
  `ObjProp`, `Ccompta` (PDF), `Visualiseur`, `Calcsolde`, `Doc`.
- Tables (via `Cbase.Table`) : `Fiches_Mvt` (`TabMvt`), `Fiches_Rappro` (`TabRappro`),
  `Fiches_Comptes` (`TabComptes`), `Fiches_Societes` (`TabSoc`) ; plus `Fiches_Mvt1-5` via
  `Listextcpt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner `Pointage2_Click`/`Depointage_Click` dans `Private Sub Enregistre_Pointage(point As
  Boolean)` (mêmes messages, même SQL).
- `Imprime_Click` : helper privé `Entete_Page(pdf, …) As Integer` (3 copies), fonction privée
  `Lignes_Impression() As Result` pour la sélection SQL, cumul des totaux en `Float` puis
  formatage final (sortie identique à vérifier par le PDF texte).
- Supprimer les doubles appels `Update_Req()`/`Calc_Solde()` après `ClearChampsAll()` dans
  `cptman` et `Colrlv_Man` (SQL modifié : moins de `SELECT`, dump identique).
- Code mort : variables inutilisées (`f`, `Res`, `rResult`, `PosX`), `Shell "cd …"`, tests
  `= Null` sur chaînes formatées, en-têtes de colonnes commentés, branche `Else` vide.

### Commonalisation avec d'autres fichiers

- **Sélection multiple sur `TriGen`** (`TriGen_MajSel`, `TriGen_Raz`, `TriGen_Data`,
  `SelectAllFil_Click`, `DeSelectAllFil_Click`) dupliquée dans
  [`GedR`](../../Utils/GedR.class/architecture.md) (l. 59-90, 273-310) et
  [`TriFacture`](../../Affichages/TriFacture.class/architecture.md) (l. 186-275) : une classe
  utilitaire `TriSelection` (liste + bascule + tout/rien sur `GetAllFiltered(champ)` + couleur) ou
  des méthodes de `TriGen` lui-même. Les handlers restent dans chaque écran et délèguent.
- `Left($lst.requete, -14)` : exposer dans [`Listextcpt`](../Utils/Listextcpt.class/architecture.md)
  une propriété « requête sans tri » (même SQL émis).
- Solde pointé avec report à nouveau (`cptman`, `Imprime_Click`) : même requête que
  [`Calcsolde.Calcul`](../../Utils/Calcsolde.class/architecture.md) (avec `jan`) → helper commun
  `SoldePointe(cpt, jan)`.

### Réduction de portée

- `Update_Req`, `Colrlv_Man`, `cptman`, `ClearChamps`, `ClearChampsAll`, `Calc_Solde` : aucun
  appelant externe (vérifié par `grep -rn`) → `Private`, couverture par replay.
- `Bsel`/`Bval` : **non réductibles** (positionnés par `Object.SetProperty`, faux positif de
  `deps.py`).

### Séparation traitement / GUI

- `Colrlv_Man` : extraire `Releve_Precedent(cpt, date)`, `Releve_Suivant_Existe(cpt, date)`,
  `Cree_Releve(...)` (SQL pur) ; le handler garde messages et champs.
- `Calc_Solde` : `Private Function Ecart(depart, deb, cred, final)` pur.
- `SuppressionRlv_Click` : `Private Sub Supprime_Releve(cpt, nrel)` regroupant les 3 écritures SQL.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `pointee` et `nrlv` sont dupliqués dans `Fiches_Mvt` … `Mvt5` : une table de liaison
  `Fiches_Pointage(compte, numero, nreleve)` éviterait les 6 `UPDATE` et le dépointage incomplet.
- `Fiches_Comptes.soldep` (solde pointé dénormalisé) pourrait être calculé à la volée depuis
  `Fiches_Rappro`.
- Clé `(cpt, nreleve)` de `Fiches_Rappro` : vérifier l'index unique dans `db_control.csv`.
