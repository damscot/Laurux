# Lcr — Architecture

> Source : `.src/Gestion/Lcr/Lcr.class`

## Vue d'ensemble

Écran **« Traitements LCR non attribuées »** (menu Gestion › LCR, `Fmenu.MenuTrlcr_Click` ; le
menu LCR n'est visible que si `/Soc<XX>/Lcr` est vrai, `Fmenu.class:104`). C'est la **première
étape** de la chaîne LCR (lettres de change relevé) :

1. **Lcr** : import des traites générées à la facturation (`Fiches_Traites`, écrites par
   `EcrAuto`) dans `Fiches_Lcr`, saisie/correction manuelle des LCR non encore attribuées à une
   banque (`banque = 0`), impression de listes ;
2. [`Attribution`](../Attribution.class/architecture.md) : attribution d'une banque ;
3. [`Preparation`](../Preparation.class/architecture.md) : code entrée et création d'un bordereau
   (`Fiches_Bordereaux`) ;
4. [`Bordrx`](../Bordrx.class/architecture.md) : édition du bordereau, génération du **fichier
   bancaire** (format LCR magnétique CFONB, enregistrements `0360`/`0660`/`1660`/`0860`) et envoi
   par mail ;
5. [`Glcr`](../Glcr.class/architecture.md) : impression / suppression.

Aucune écriture comptable n'est produite par la chaîne LCR (aucun accès à `Fiches_Mvt` dans
`.src/Gestion/Lcr`, vérifié par `grep`).

L'écran affiche `Fiches_Lcr` dans une grille virtuelle `ColLcr` (`Utils.Base` + `ColLcr_Data`),
filtrée par trois radios `T` (toutes), `A` (acceptées), `E` (écartées), triée par clic sur les
en-têtes (`CO`, `Inte`, `DA`, `DAE`, `NUM`, `MNT`, `ACC`, `REJ`). Une fiche (onglet) permet la
création (`Button5` puis `Button3`), la modification (`Button3`) et la suppression (`Button2`).

L'écran n'appelle **pas** `Utils.Observers(Me)` : il n'est pas rejouable en l'état.

Nature : écran **mixte** ; SQL dans les handlers ; deux impressions PDF.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `rs1` | var | Private |  | Result | 30 |
| `sel` | var | Private |  | String | 31 |
| `txt` | var | Private |  | String | 32 |
| `Lcrtable` | var | Private |  | New String[10] | 33 |
| `B` | var | Private |  | Integer | 34 |
| `rResult` | var | Private |  | Result | 35 |
| `son` | var | Private |  | Integer | 36 |
| `sKey` | var | Private |  | String | 37 |
| `Dbl` | var | Private |  | String | 38 |
| `CoulB` | var | Private |  | Integer | 39 |
| `CoulF` | var | Private |  | Integer | 40 |
| `Fnt` | var | Private |  | String | 41 |
| `CoulZns` | var | Private |  | Integer | 42 |
| `CoulZnaf` | var | Private |  | Integer | 43 |
| `Coulfc` | var | Private |  | Integer | 44 |
| `Coulfond` | var | Private |  | New String[] | 45 |
| `nv` | var | Private |  | Boolean | 46 |
| `Dte1` | var | Private |  | Integer | 47 |
| `Type` | var | Private |  | String | 48 |
| `Bsel` | var | Public |  | Boolean | 49 |
| `Bval` | var | Public |  | String | 50 |
| `sCmpt` | var | Public |  | String | 51 |
| `sdesg` | var | Public |  | String | 52 |
| `PosX` | var | Private |  | Integer | 53 |
| `PosY` | var | Private |  | Integer | 54 |
| `pdf` | var | Private |  | CLcr | 55 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 57-85 | Public | 2 | 26 | 0 | méthode spéciale |
| `Form_Open` | 87-95 | Public | 1 | 7 | 0 | handler GUI |
| `Entete` | 97-108 | Public | 1 | 10 | 0 | portée réductible ? |
| `CO_GotFocus` | 110-117 | Public | 1 | 6 | 0 | handler GUI |
| `Co_LostFocus` | 119-123 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 125-132 | Public | 1 | 6 | 0 | handler GUI |
| `Inte_LostFocus` | 134-138 | Public | 1 | 3 | 0 | handler GUI |
| `DA_GotFocus` | 140-147 | Public | 1 | 6 | 0 | handler GUI |
| `DA_LostFocus` | 149-153 | Public | 1 | 3 | 0 | handler GUI |
| `DAE_GotFocus` | 155-162 | Public | 1 | 6 | 0 | handler GUI |
| `DAE_LostFocus` | 164-168 | Public | 1 | 3 | 0 | handler GUI |
| `NUM_GotFocus` | 170-177 | Public | 1 | 6 | 0 | handler GUI |
| `NUM_LostFocus` | 179-183 | Public | 1 | 3 | 0 | handler GUI |
| `MNT_GotFocus` | 185-192 | Public | 1 | 6 | 0 | handler GUI |
| `MNT_LostFocus` | 194-198 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_LostFocus` | 200-204 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_GotFocus` | 206-213 | Public | 1 | 6 | 0 | handler GUI |
| `REJ_LostFocus` | 215-219 | Public | 1 | 3 | 0 | handler GUI |
| `REJ_GotFocus` | 221-228 | Public | 1 | 6 | 0 | handler GUI |
| `ColLcr_Data` | 230-263 | Public | 12 | 32 | 0 | handler GUI |
| `Tris` | 265-281 | Public | 1 | 14 | 0 | portée réductible ? |
| `Deb2` | 283-289 | Public | 4 | 5 | 0 | portée réductible ? |
| `Deb3` | 291-297 | Public | 4 | 5 | 0 | portée réductible ? |
| `T_click` | 299-303 | Public | 1 | 3 | 0 | handler GUI |
| `A_click` | 305-309 | Public | 1 | 3 | 0 | handler GUI |
| `E_click` | 311-315 | Public | 1 | 3 | 0 | handler GUI |
| `Refresh` | 317-321 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 323-327 | Public | 1 | 3 | 0 | handler GUI |
| `ColLcr_Click` | 329-339 | Public | 3 | 9 | 0 | handler GUI |
| `CleanChamps` | 341-352 | Public | 1 | 10 | 0 | portée réductible ? |
| `Maj_Zones` | 354-375 | Public | 5 | 19 | 0 | portée réductible ? |
| `Button10_Click` | 380-404 | Public | 5 | 22 | 0 | handler GUI |
| `Button3_Click` | 409-426 | Public | 4 | 16 | 0 | handler GUI |
| `Button2_Click` | 431-447 | Public | 3 | 14 | 0 | handler GUI |
| `Button1_Click` | 452-456 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 458-463 | Public | 1 | 4 | 0 | handler GUI |
| `Button7_Click` | 465-469 | Public | 1 | 3 | 0 | handler GUI |
| `compte` | 474-486 | Public | 2 | 10 | 0 | portée réductible ? |
| `compteman` | 491-498 | Public | 2 | 5 | 0 | portée réductible ? |
| `cmpt_keypress` | 500-507 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 509-520 | Public | 4 | 10 | 0 | handler GUI |
| `Imp_Traites` | 522-591 | Public | 16 | 67 | 0 | portée réductible ? |
| `Imp_Lcr` | 594-658 | Public | 17 | 61 | 0 | portée réductible ? |
| `Level1` | 661-686 | Public | 1 | 24 | 0 | portée réductible ? |
| `Level2` | 689-709 | Public | 1 | 19 | 0 | portée réductible ? |
| `Level3` | 712-735 | Public | 1 | 22 | 0 | portée réductible ? |
| `Level4` | 738-756 | Public | 1 | 17 | 0 | portée réductible ? |
| `Button9_Click` | 758-766 | Public | 4 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation, liste et tri

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI] : couleurs, fond (`Coul_fen`),
  musique, regex du code client `4*1*1*[0-9]{0,5}`, types date/numérique (2 décimales), `Chainage`
  des zones jusqu'à `Button3`, `Entete()`. `rResult` local inutilisé.
- **`Form_Open()`** [événement] : tri par date, `Tris()`, `Deb2()`, focus sur le code.
- **`Entete()`** [portée : réductible] [GUI] : titres des 8 en-têtes.
- **`CO/Inte/DA/DAE/NUM/MNT/ACC/REJ_GotFocus`** [événements] : couleur de focus, colonne de tri
  (`code`, `nom`, `date`, `datech`, `numfac`, `montant`, `acceptee`, `ecartee`), `Tris`, `Deb2`.
  **`*_LostFocus`** : `Utils.ObsLstf`. Le tri par `montant` est alphabétique (colonne `char(12)`).
- **`ColLcr_Data(Row, Column)`** [événement] [GUI] : lit `Utils.rs1` ; dates : `/` → `.` et 10
  premiers caractères (dépend du format de `Str(Date)`) ; acceptée/écartée : `1` → `X`.
  `Lcrtable` est rempli à chaque cellule.
- **`Tris()`** [portée : réductible] [GUI] : 9 colonnes (la 9ᵉ, `lind`, garde sa largeur par
  défaut).
- **`Deb2()`** [portée : réductible] [nature : mixte] : `Utils.Base(ColLcr, "select * from
  Fiches_Lcr where banque = 0 and bordereau <> 1 …")` (Toutes) ou `acceptee = 1`/`ecartee = 1`
  avec `bordereau = 0`. Valeurs concaténées (constantes) ; `Tri` vient d'une liste fermée.
- **`Deb3()`** : variante descendante avec filtre `like "<sel>%"` ; `sel` n'est jamais alimenté
  dans cet écran et `Deb3` n'a aucun appelant → **code mort**.
- **`T_click`, `A_click`, `E_click`** [événements] : `Deb2()`.
- **`Refresh()`** [portée : réductible] : `form_Open()`.

### Fiche LCR

- **`ColLcr_Click()`** [événement, `replay_dynamic` : doit rester `Public`] : `CleanChamps`,
  `Maj_Zones`, `nv = False` ; `Catch` → focus.
- **`CleanChamps()`** [portée : réductible] [GUI] : vide la fiche.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : `select * from Fiches_Lcr where lind
  = &1` (colonne 8 de la grille) puis remplissage de la fiche.
- **`Button5_Click()`** [événement] : `nv = True` + bulle « Création d'une nouvelle LCR ».
- **`Button3_Click()`** [événement] [nature : mixte] : si `nv = False`, `UPdate Fiches_Lcr SET
  code, nom, date, datech, montant, acceptee, ecartee, numfac where lind = <ligne courante>` ;
  sinon `Insert into Fiches_Lcr (…) value (…)` avec `banque = 0`, `bordereau = 0`,
  `codeentree = 0`. Mot-clé `value` (accepté par MySQL, **refusé par SQLite**, non traduit par
  `DB_Connection`). Toute erreur (y compris « aucune ligne sélectionnée ») affiche le même message
  « Il faut impérativement cliquer sur le bouton Créer… ».
- **`Button2_Click()`** [événement] [nature : mixte] : confirmation puis `DELETE FROM Fiches_Lcr
  WHERE lind = &1` ; sans ligne sélectionnée, `ColLcr[-1, 8]` lève une erreur non interceptée.
  `rResult`, `Suppr` inutilisés.
- **`Button7_Click()`** → **`compte()`** [portée : réductible] [GUI] : `New TriCpt(TriCpt.Client,
  TriCpt.Avec_Solde, Me)` en modal ; `TriCpt` renseigne `Bsel`/`Bval` de l'écran par
  `Object.SetProperty` (d'où leur portée `Public` nécessaire). `Bsel` n'est jamais remis à `False`.
- **`compteman()`** [portée : réductible] [nature : mixte] : intitulé du compte client
  (`Cbase.Table("TabComptes")`, `compte_cc = &1 and coll <> 1`).
- **`cmpt_keypress()`** [événement du groupe `Cmpt`] : F1 → aide (`Button1_Click`).
- **`Cmpt_Lostfocus()`** [événement du groupe `Cmpt`] : Tag 1 → `compteman` ; Tag 6 (montant) :
  si nul, focus conservé.
- **`Button1_Click()`** : `Doc.Open("LCR")`. **`Button4_Click()`** : fermeture.

### Import des traites

- **`Button10_Click()`** [événement] [nature : mixte] : pour chaque ligne de `Fiches_Traites`,
  `Insert into Fiches_Lcr (…) value (…)` (banque 0, code entrée « 0 », bordereau « 0 »), puis
  message, `Imp_Traites()` et `Refresh()`. Aucune déduplication : les traites restent dans
  `Fiches_Traites` si l'utilisateur refuse la purge proposée par `Imp_Traites` (ou si la purge
  n'est pas proposée) → un nouvel import crée des **doublons**. Variables `Traite` inutilisée.
- **`Imp_Traites()`** [portée : réductible] [nature : mixte] (CC 16) : PDF `~/Traites.pdf` avec
  `Ccompta` (`Entete`, `Level1T`, `Level2T`, `BasPage`) : RIB et domiciliation du client
  (`Cbase.Table("TabCli")`), dates `LDate(…).L`. `PosY` avance de 10 + 5 par ligne d'adresse non
  vide alors que `Ccompta.Level2T` occupe toujours 25 mm → **chevauchement** des blocs quand une
  adresse est incomplète (`Traites.class` avance toujours de 25). Ensuite, si
  `Not Start.localSettings["/Soc" & "/Lcr"]` — clé **sans le code société** (`/Soc/Lcr`), donc
  normalement absente, d'où une condition toujours vraie, alors que `Traites.class` lit
  `"/Soc" & Start.Societe & "/Lcr"` — proposition de vider la table par `TRUNCATE Fiches_Traites`
  (non supporté par SQLite).

### Impression de la liste

- **`Button9_Click()`** [événement] : libellé `Type` selon la radio, message, `Imp_Lcr()`.
- **`Imp_Lcr()`** [portée : réductible] [nature : mixte] (CC 17, max) : sélection
  `SELECT * FROM Fiches_Lcr` (Toutes, **sans** les filtres `banque = 0`/`bordereau` de la grille) ou
  `acceptee = 1` / `ecartee = 1` ; PDF `~/Lcr.pdf` avec le membre `pdf As CLcr` : `Entete`,
  `Level1`, puis `Level2` (11 arguments, **arité correcte**, voir dependencies.md), `Lines`. Saut de
  page à 268 mm sans réimprimer `Level1`. Si le client n'existe plus, les variables d'adresse de
  la LCR précédente sont réutilisées pour calculer `PosY`. Variables `setb`, `sguichet`, `snum`,
  `srib`, `sdom`, `Traite`, `Filename` locale, `Numero` inutilisées ; `Coulfond` inutilisé.

### Code mort (impression `Draw` de l'ancienne version)

- **`Level1()`, `Level2(…)`, `Level3()`, `Level4(…)`** : impression `Draw` (gb.qt), aucun appel
  direct (les appels `pdf.Level1()`/`pdf.Level2()` visent `CLcr`). `deps.py` ne signale que
  `Level3`/`Level4` : `Level1`/`Level2` sont aussi morts.

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`, `/Soc<XX>/Coul_fen`, `/Soc/Lcr` erroné), `Start.Societe`,
  `Start.Son`, `Start.Musique`.
- `Utils.Base`/`Utils.rs1`, `Utils.db`, `Utils.convBool`, `Utils.Cdate_Aff`, `Utils.Coulfd`,
  `Utils.FColr`, `Utils.ObsLstf`, `Cbase.Table` (`TabCli`, `TabComptes`), `LDate`, `TextReg`,
  `Chainage`, `TriCpt`, `Ccompta`, `CLcr`, `Visualiseur.Prog`, `Doc.Open`.
- Tables : `Fiches_Lcr`, `Fiches_Traites` (en dur), `Fiches_Cli`, `Fiches_Comptes` (via `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplir `Lcrtable` une seule fois (dans `_New`) au lieu de chaque appel de `ColLcr_Data`.
- `Button3_Click` : séparer création et modification ; vérifier la sélection avant l'`UPdate`.
- Supprimer les variables locales inutilisées de `Imp_Lcr`, `Imp_Traites`, `Button2_Click`.

### Commonalisation avec d'autres fichiers

- `Imp_Traites` duplique `Traites.class` (`.src/Gestion/Impressions`, voir sa documentation) :
  même PDF `Ccompta.Level1T/Level2T`, mais nom de fichier (`~/Traites.pdf` vs `~/tmp/Traites.pdf`),
  formatage des dates, pas vertical, clé de réglage et purge (`TRUNCATE` vs `DROP`/`CREATE`)
  différents. Une fonction commune paramétrée (`ImprimeTraites(fichier, purge)`) est possible si les
  différences sont conservées en paramètres ; l'alignement complet relève des anomalies.
- `Imp_Lcr` : même boucle (client, adresse, `Level2`/`Level2A`, `Lines`, saut de page) dans
  [`Attribution.Imp_Lcr`](../Attribution.class/architecture.md) et
  [`Preparation.Imp_Lcr`](../Preparation.class/architecture.md) → une fonction commune
  `ImprimeListeLcr(rTraite, titre, avec_banque)` (module LCR commun, phase 3).
- `compte`/`compteman`/`Cmpt_Lostfocus`/`cmpt_keypress`, `CleanChamps`/`Maj_Zones`, les 16 handlers
  d'en-tête et `ColLcr_Data` sont quasi identiques dans `Attribution` et `Preparation` (copier-coller
  de `Lcr`). Les handlers restent dans chaque écran (noms intouchables), mais leurs corps peuvent
  appeler des fonctions communes (`ClientIntitule(code)`, `LireLcr(lind) As Result`).
- Initialisation des couleurs de `_New` : commonalisation transverse `/Coul/*`.

### Réduction de portée

- `Entete`, `Tris`, `Deb2`, `Refresh`, `CleanChamps`, `Maj_Zones`, `compte`, `compteman`,
  `Imp_Traites`, `Imp_Lcr` → `Private` (aucun appel externe, vérifié par
  `grep -rn "Lcr\.\(Entete\|Tris\|Deb2\|Imp_\)" .src`).
- `sCmpt`, `sdesg` : membres `Public` jamais lus ni écrits (ni ici ni par `TriCpt`) → suppression.
- `Bsel`, `Bval` restent `Public` (écrits par `TriCpt` via `Object.SetProperty`).

### Séparation traitement / GUI

- Extraire `ImporteTraites() As Integer` (boucle d'`INSERT`, sans contrôle) de `Button10_Click`.
- Extraire `EnregistreLcr(…)`/`SupprimeLcr(lind)` de `Button3_Click`/`Button2_Click`.
- Extraire la sélection de `Imp_Lcr` (`RequeteImpression(mode) As Result`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Lcr.montant` en `char(12)` : tri alphabétique et ambiguïté du séparateur décimal ; un
  `DECIMAL(12,2)` les supprimerait.
- Clé d'unicité (client, n° de facture, échéance) sur `Fiches_Lcr` pour empêcher les doublons à
  l'import des traites, ou colonne « importée » dans `Fiches_Traites`.
- `banque`, `bordereau` en `varchar(35)` contenant des entiers → `INT`.
