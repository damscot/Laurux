# Changefam — Architecture

> Source : `.src/Utils/Changefam.class`

## Vue d'ensemble

`Changefam` est l'**écran de changement de famille** (et, en option, de code) des articles. Il est
ouvert depuis le menu Gestion (`Fmenu.class:1376`, `Changefam.ShowModal`) et propose quatre modes :

1. **Un article** (cadre haut) : code article (`Code`), nouvelle famille (`Nfam`), nouveau code
   optionnel (`NvCode`) puis bouton « Lancer » (`Button3`, `Tag 3`) → `Change` → `Modifart`.
2. **Liste d'articles** (case `Liste`) : les articles saisis sont stockés dans une table temporaire
   `CFamille` (`Liste_Click`, `AjoutArt`), puis traités en lot par `Change3` → `Modifart`.
3. **Famille entière** (cadre bas) : toutes les lignes dont la famille vaut `Afam2` passent en
   `Nfam2` (`Change2`), dans 8 tables.
4. **Fichier CSV** (case `Fichier`) : un formulaire construit dynamiquement (`Fichier_Click`) lit un
   fichier `code;famille;nouveau_code` et appelle `Modifart` pour chaque ligne (`Bouton2_Click`).

`Modifart` est le cœur métier : selon que le code change ou non, il émet 8 ou 37 `UPDATE` sur
~29 tables (articles, historiques de factures/BL/tickets, GED, codes-barres, inventaires, tarifs,
tables de travail `Rupture`/`RuptureC`). Les traitements sont encadrés par `verrou()` (`LOCK TABLES`
sur 29 tables) et `UNLOCK TABLES`, **sans transaction ni `Catch`**.

Aucun nom de table ne passe par `Cbase.Table` ; tout le SQL est paramétré (`&1`…), sauf les noms
de table concaténés. Les champs famille sont des contrôles utilisateur
[`textfamille`](../textfamille.class/architecture.md) (`Afam`, `Nfam`, `Afam2`, `Nfam2`).

Nature globale : **mixte**, très couplée à la GUI (lecture directe des `TextBox`, `Message.*`,
`Balloon`, `Music`) ; la logique de mise à jour (`Modifart`, `Change2`) est extractible.

Le fichier est un clone élargi de [`Changefour`](../Changefour.class/architecture.md) (voir la
section commonalisation : 247 lignes de code identiques sur 548/411).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 28 |
| `Bval` | var | Public |  | String | 29 |
| `Tab` | var | Private |  | String | 31 |
| `$Org` | var | Private |  | String | 32 |
| `$hform` | var | Private |  | Form | 33 |
| `hText` | var | Private |  | TextBox | 34 |
| `hbutton1` | var | Private |  | Button | 35 |
| `hbutton2` | var | Private |  | Button | 36 |
| `hbutton3` | var | Private |  | Button | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-50 | Public | 1 | 7 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 52-112 | Public | 14 | 52 | 0 | handler GUI |
| `cmpt_lostfocus` | 114-122 | Public | 2 | 6 | 0 | handler GUI |
| `art_man` | 130-147 | Public | 2 | 14 | 0 | portée réductible ? |
| `Button9_Click` | 149-156 | Public | 2 | 6 | 0 | handler GUI |
| `Button9_KeyPress` | 158-162 | Public | 4 | 3 | 0 | handler GUI |
| `AjoutArt` | 164-184 | Public | 5 | 17 | 0 | portée réductible ? |
| `SelectionArt` | 187-199 | Public | 2 | 10 | 0 | portée réductible ? |
| `Btn_Click` | 201-238 | Public | 9 | 30 | 0 | handler GUI |
| `SelectionFam` | 243-277 | Public | 4 | 31 | 0 | portée réductible ? |
| `FamList_Click` | 282-301 | Public | 3 | 17 | 0 | handler GUI |
| `FamList_KeyPress` | 306-320 | Public | 5 | 11 | 0 | handler GUI |
| `fam_Man` | 325-339 | Public | 3 | 12 | 0 | portée réductible ? |
| `fam_Man2` | 345-363 | Public | 4 | 16 | 0 | portée réductible ? |
| `fam_Man3` | 365-384 | Public | 3 | 17 | 0 | portée réductible ? |
| `fam_Man4` | 386-405 | Public | 3 | 17 | 0 | portée réductible ? |
| `Change` | 410-425 | Public | 3 | 14 | 0 | portée réductible ? |
| `Change2` | 430-460 | Public | 3 | 25 | 0 | portée réductible ? |
| `Change3` | 465-498 | Public | 6 | 31 | 0 | portée réductible ? |
| `Modifart` | 500-555 | Public | 5 | 47 | 0 | portée réductible ? |
| `Liste_Click` | 557-580 | Public | 2 | 20 | 0 | handler GUI |
| `Fichier_Click` | 582-626 | Public | 3 | 42 | 0 | handler GUI |
| `Bouton1_Click` | 628-644 | Public | 2 | 15 | 0 | handler GUI |
| `Bouton2_Click` | 646-691 | Public | 9 | 43 | 0 | handler GUI |
| `verifam` | 693-705 | Public | 2 | 11 | 0 | portée réductible ? |
| `verifart` | 707-728 | Public | 3 | 18 | 0 | portée réductible ? |
| `verrou` | 730-734 | Public | 1 | 3 | 0 | portée réductible ? |
| `Bouton3_Click` | 736-741 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et navigation clavier

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Charge le son (`Music.Load(Start.Musique)`),
  centre, `Utils.Observers(Me)`, masque `Listbart` et `Button9`.
- **`Cmpt_KeyPress()`** (CC 14) [portée : nécessaire, handler du groupe `Cmpt` du `.form`] [nature : GUI].
  Sur Entrée/Retour/Tab, aiguille selon `Last.Tag` : 1 (`Code`, `NvCode`) → lecture de l'article
  (`art_man`) et focus ; préfixe `*` = code-barres (`Utils.Find_cbarre`) ; 2 (`Nfam`) → `fam_Man2` ;
  4 (`Afam2`) → `fam_Man3` ; 5 (`Nfam2`) → `fam_Man4`.
  ⚠️ La variable locale `b` n'est jamais mise à 1 : les branches `If b = 1` sont mortes.
  ⚠️ Cas 1 : après le traitement, `fam_Man()` est **toujours** appelé (le `Stop Event` ne sort pas
  de la procédure), avec la famille lue sur l'article.
  ⚠️ `Case 3` : aucun contrôle du groupe `Cmpt` n'a le `Tag 3` (branche morte).
- **`cmpt_lostfocus()`** [portée : nécessaire, handler `Cmpt_LostFocus`] [nature : GUI]. `Tag 1` → `art_man`
  (relit l'article à chaque perte de focus de `Code` **et** de `NvCode`).
- **`Btn_Click()`** (CC 9) [portée : nécessaire, handler du groupe `Btn`] [nature : GUI]. `Tag` 1 →
  `SelectionArt` ; 2 → `SelectionFam(1)` ; 3 → `Change("Btn")` ou `Change3` si `Liste` ; 4 →
  `SelectionFam(2)` (déplace `Famlist.X` à 96) ; 5 → `SelectionFam(3)` ; 6 → `Change2` ; 8 → fermeture.

### Lecture article / famille

- **`art_man()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Art WHERE art_code = &1`
  (en dur, sans `Cbase`) ; remplit `Code`, `Desg`, `Afam` ; sinon « Inconnu ». `With utils` inutile.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. Ouvre `TriArticles(…, "Famille", …, Me)` ;
  le retour arrive par `Object.SetProperty(Me, "Bsel"/"Bval")` (d'où `Bsel`/`Bval` `Public`).
- **`SelectionFam(sOrg)`** [portée : réductible] [nature : mixte]. Bascule la visibilité de la liste
  `FamList` et la remplit depuis `Fiches_Fam` (`ORDER BY code_fam`). Parcours en `Do … Loop Until`
  (idiome non standard du dépôt). Les colonnes 2 à 4 (`coef_fam`, `cdtva_fam`, `txtva_fam`) sont
  écrites alors que la liste n'a que 2 colonnes (à confirmer : ignorées silencieusement).
  `$Org` (String) mémorise la zone cible, comparé ensuite à des entiers.
- **`FamList_Click()` / `FamList_KeyPress()`** [portée : nécessaire, handlers] [nature : GUI]. Recopie
  la famille choisie dans `Nfam`/`Afam2`/`Nfam2` selon `$Org`, ferme la liste. Échap/F2 ferme.
- **`fam_Man()`** [portée : réductible] [nature : mixte]. Lit le libellé de `Afam` **sans tester
  `Available`** : une famille inconnue passe par le `Catch`, qui affiche **deux** messages
  (`Message.Error` technique puis `Message.Warning`).
- **`fam_Man2()` / `fam_Man3()` / `fam_Man4()`** [portée : réductible] [nature : mixte]. Trois copies
  quasi identiques : `SELECT * FROM Fiches_Fam WHERE code_fam = &1` sur `Nfam`/`Afam2`/`Nfam2`,
  libellé dans `LibelFam2/3/4`, focus suivant ; sinon son + avertissement.
- **`verifam(textfm)`** [portée : réductible] [nature : mixte]. Vérifie qu'une famille existe ;
  sinon `Balloon.Warning` et `False`.
- **`verifart()`** [portée : réductible] [nature : mixte] — **code mort** (aucun appel, vérifié par
  `grep`). Il contrôlait l'existence de l'ancien code et l'absence du nouveau : ce contrôle n'est
  donc fait nulle part (voir anomalies).

### Saisie de la liste d'articles

- **`Liste_Click()`** [portée : nécessaire, handler] [nature : mixte]. Affiche/masque `Listbart` et
  `Button9` ; à l'affichage, `DROP TABLE IF EXISTS CFamille` puis `CREATE TEMPORARY TABLE CFamille`
  (`codeart` PK, `nvcodeart`, `afam`, `nfam`) + `Utils.db.Engine()`.
- **`Button9_Click()` / `Button9_KeyPress()`** [portée : nécessaire, handlers] [nature : GUI]. Ajoute
  l'article courant via `AjoutArt`. `If … Or If …` : syntaxe Gambas valide (court-circuit).
- **`AjoutArt()`** [portée : réductible] [nature : mixte]. `INSERT INTO CFamille` ; en cas d'erreur
  (doublon), un `SELECT` dont le résultat n'est pas utilisé (code mort) puis « déjà saisi ».

### Traitements (écritures en base)

- **`Change($hOrg)`** [portée : réductible] [nature : mixte]. `verifam(Nfam)`, `verrou()`,
  `Modifart(Code, Nfam, NvCode)`, `UNLOCK TABLES`, message. Le paramètre `$hOrg` est inutilisé.
  Aucun appel à `verifart` : un nouveau code déjà existant provoque une erreur de clé primaire
  **alors que les tables sont verrouillées**.
- **`Change2()`** [portée : réductible] [nature : mixte, la partie SQL est extractible].
  `UPDATE … SET famille = Nfam2 WHERE famille = Afam2` sur `Fiches_Art`, `Fiches_HistoLigfac`,
  `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_HistoLigfacM`, `Fiches_Materiels`,
  `Fiches_HisLigTickets`, `Fiches_LigTicketz`. Variables locales `Tab1..3`, `r2Result` inutilisées.
- **`Change3()`** [portée : réductible] [nature : mixte]. Parcourt `CFamille` et appelle `Modifart`
  pour chaque ligne, sous `verrou()`. Si `CFamille` est vide alors que `listBart` contient du texte,
  rien ne se passe (pas de message).
- **`Modifart(oldcode, newfam, newcode)`** (LOC 47) [portée : réductible] [nature : calcul].
  Ne fait rien si `oldcode` ou `newfam` est vide.
  - Si `newcode` est renseigné et différent : met à jour famille **et** code dans 8 tables
    (`Fiches_Art`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_HistoLigfacM`,
    `Fiches_Materiels`, `Fiches_HisLigTickets`, `Fiches_LigTicketz`), puis le code seul dans 21
    colonnes de 19 tables (`Docs_Ged` filtré par `type = LGed.Articles`, `Fiches_ArtPromo`,
    `Fiches_CdBarre`, `Fiches_CdFour`, `Fiches_Cequ` ×2, `Fiches_EtiGond`, `Fiches_EtiProd`,
    `Fiches_HisInvT`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_Ligcom`, `Fiches_Ligrecpt`,
    `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_PrdComp` ×2, `Fiches_Rpl1` ×2, `Fiches_Rpl2` ×2,
    `Fiches_Tarcli`, `Fiches_TarTypcli`, `Rupture`, `RuptureC`).
  - Sinon : famille seule dans les 8 premières tables.
  Non mis à jour malgré une colonne code article : à confirmer au cas par cas (`Fiches_Sdepots`,
  `Fiches_StkDepots`, `Fiches_HistoLigfac*` de rétrocession…). Liste à valider avec l'utilisateur.
- **`verrou()`** [portée : réductible] [nature : calcul]. `LOCK TABLES … WRITE` sur les 29 tables
  touchées par `Modifart`, **dont `Rupture` et `RuptureC`**, tables de travail créées seulement par
  `Crupt.Rupture` (édition des ruptures) et absentes de `Laurux01.sql`/`db_control.csv`.
  Neutralisé sous SQLite par `DB_Connection.Exec`.

### Import par fichier (formulaire dynamique)

- **`Fichier_Click()`** [portée : nécessaire, handler] [nature : GUI]. Construit une `Form`
  (`As "Form"`) avec un libellé, une `TextBox` et trois boutons `Bouton1/2/3` ; `Bouton2` n'est
  configuré qu'après le choix du fichier (à confirmer : visible vide en haut à gauche avant).
  Décoché → `Try $hform.Close`.
- **`Bouton1_Click()`** [portée : nécessaire, handler dynamique] [nature : GUI]. `Dialog.OpenFile`
  (`*.csv`, `*.txt`), puis affiche `Bouton2` « Traitement ».
- **`Bouton2_Click()`** (CC 9) [portée : nécessaire, handler dynamique] [nature : mixte]. Confirmation,
  `verrou()`, lecture ligne à ligne, `Split(";")`, recopie dans `Code`/`NFam`/`NvCode`, contrôle de la
  famille puis de l'article, `Modifart`. Voir anomalies A01 à A03.
- **`Bouton3_Click()`** [portée : nécessaire, handler dynamique] [nature : GUI]. Ferme la fenêtre et
  décoche `Fichier`.

## État global utilisé

- `Utils.db` (`Exec`, `Engine`), `Utils.Observers`, `Utils.Find_cbarre`.
- `Start.Musique`, `Start.son` (son sur avertissement).
- `LGed.Articles` (type de document GED).
- Table temporaire de session `CFamille` (créée/détruite par `Liste_Click`).
- Verrous MySQL de session (`LOCK TABLES`) : tout `Exec` en erreur entre `verrou()` et `UNLOCK`
  laisse les tables verrouillées pour la connexion `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Modifart` : remplacer les 37 `Exec` par deux tableaux constants (table, colonne famille, colonne
  code) parcourus en boucle ; même SQL émis, dans le même ordre.
- `fam_Man2/3/4` (et `fam_Man`) : un seul helper `LireFamille(hSaisie, hLibelle, hSuivant)`.
- `Cmpt_KeyPress` : supprimer la variable `b` et les branches mortes (`Case 3`, `If b = 1`).
- Messages de fin (son + `Message.Warning` + focus `code`) répétés 6 fois : helper `FinTraitement()`.
- Utiliser `Cbase.Table("TabArt")`, `Cbase.Table("TabFam")`… pour les tables mappées.

### Commonalisation avec d'autres fichiers

- [`Changefour`](../Changefour.class/architecture.md) : 247 lignes de code identiques (ratio de
  similarité difflib 0,52 sur les lignes hors commentaires). Fonctions identiques au caractère près
  ou à un nom de contrôle près : `Fichier_Click`, `Bouton1_Click`, `Bouton3_Click`,
  `Button9_KeyPress`, `Button9_Click`, `SelectionArt`, `Btn_Click`, `Liste_Click`, `AjoutArt`,
  branche `Case 1` de `Cmpt_KeyPress`. Proposition : une classe commune (ex. `LChangeCode`) qui porte
  le formulaire d'import CSV dynamique (`Fichier_Click`/`Bouton1..3`) et la table temporaire de
  liste ; les deux écrans gardent leurs handlers (noms inchangés) qui délèguent.
- Le formulaire dynamique « Chemin du fichier texte » est aussi présent, en statique, dans
  `CompArt.form`, `ImportStk.form`, `Impclient.form`, `Impart.form`, `MajFbtarif1.form`,
  `ImpartParam.form` : candidat à un sélecteur de fichier commun (phase 3).
- `Modifart` (propagation d'un changement de code article dans tout le schéma) recoupe la
  suppression d'article de `.src/Gestion/SupprArt.class` : la liste des tables « porteuses d'un code
  article » mériterait d'être définie une seule fois (ex. dans `Cbase`).

### Réduction de portée

- `art_man`, `AjoutArt`, `SelectionArt`, `SelectionFam`, `fam_Man`, `fam_Man2..4`, `Change`,
  `Change2`, `Change3`, `Modifart`, `verifam`, `verrou` : aucun appelant externe (grep). À passer en
  `Private` une fois couverts par les replays.
- **À conserver `Public`** : `Bsel`/`Bval` (écrits par `TriArticles` via `Object.SetProperty`),
  `Cmpt_KeyPress`/`cmpt_lostfocus` (handlers du groupe `Cmpt`, faux positifs de `deps.py`), tous les
  `*_Click`/`*_KeyPress`, `Bouton1..3_Click` (contrôles dynamiques).

### Séparation traitement / GUI

- `Modifart` est déjà pur (paramètres → SQL) : à conserver comme point d'entrée testable.
- Extraire de `Change2` une fonction `ChangeFamilleGlobale(ancienne, nouvelle)` sans accès aux
  contrôles ; idem pour la boucle de `Change3` (`TraiterListe()`) et pour l'analyse d'une ligne CSV
  de `Bouton2_Click` (`TraiterLigneFichier(lig) As String` qui renvoie le message d'erreur éventuel).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `ON UPDATE CASCADE` vers `Fiches_Art.art_code` et `Fiches_Fam.code_fam` : la
  propagation des changements de code deviendrait automatique et atomique.
- Transformer `Rupture`/`RuptureC` en tables temporaires (ou les créer dans le schéma de référence)
  pour que le `LOCK TABLES` ne dépende plus de leur existence.
- Stocker la famille d'une ligne d'historique par référence (id) plutôt que par code recopié.
