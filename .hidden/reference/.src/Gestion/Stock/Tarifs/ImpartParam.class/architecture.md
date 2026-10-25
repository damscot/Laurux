# ImpartParam — Architecture

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class`

## Vue d'ensemble

Écran **« Table des fichiers d'import »** (Gestion > Stock > Tarif, `Fmenu.Menu245_Click`,
`ShowModal`) : édition des **définitions d'import** utilisées par [`Impart`](../Impart.class/architecture.md).
Une définition (`num`) comprend :

- un en-tête dans `Fiches_ImpArtDef` : nom, fournisseur et famille par défaut, chemin du fichier,
  type (`typesep` : `S` = champs séparés, `F` = largeur fixe), séparateur ;
- jusqu'à 32 zones dans `Fiches_ImpArtDef2` (une seule ligne de 161 colonnes) : pour chaque rang
  `x`, `col_x` (libellé « NN - nom du champ Laurux »), `pos_x` (n° de champ, mode `S`),
  `db_x`/`lg_x` (début/longueur, mode `F`), `posorg_x` (n° du champ Laurux, 1 à 31).

L'écran affiche les premières lignes du fichier (`Lignes`), permet d'ajouter une zone
(`BtnEnregistreZone_Click`), d'en retirer (`BtnRetirerZone_Click`, `Champs_Activate`), de la
déplacer (`+`/`-` dans `Champs_KeyPress`) ; chaque modification **réécrit toute la ligne**
`Fiches_ImpArtDef2` (`EnregistreZones`).

Nature globale : **mixte**, quasi entièrement GUI ; le SQL est dans les handlers. Tables en dur
(`Fiches_ImpArtDef`, `Fiches_ImpArtDef2` n'ont pas de clé `Cbase`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `ligne` | var | Private |  | String | 3 |
| `choicetmp` | var | Private |  | Boolean | 4 |
| `ajoutligne` | var | Private |  | Integer | 5 |
| `col_i` | var | Private |  | New String[33] | 6 |
| `pos_n` | var | Private |  | New String[33] | 7 |
| `db_n` | var | Private |  | New String[33] | 8 |
| `lg_n` | var | Private |  | New String[33] | 9 |
| `posorg` | var | Private |  | New String[33] | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 12-18 | Public | 1 | 5 | 0 | handler GUI |
| `Svs_Click` | 20-43 | Public | 6 | 22 | 0 | handler GUI |
| `Lignes` | 45-62 | Public | 6 | 15 | 0 | portée réductible ? |
| `TgleBtnFour_Click` | 67-102 | Public | 7 | 31 | 0 | handler GUI |
| `fourList_Click` | 107-117 | Public | 1 | 8 | 0 | handler GUI |
| `fourList_KeyPress` | 122-134 | Public | 5 | 11 | 0 | handler GUI |
| `TgleBtnFam_Click` | 139-174 | Public | 7 | 31 | 0 | handler GUI |
| `FamList_Click` | 179-188 | Public | 1 | 7 | 0 | handler GUI |
| `FamList_KeyPress` | 193-205 | Public | 5 | 11 | 0 | handler GUI |
| `TgleBtnFDef_Click` | 210-249 | Public | 6 | 36 | 0 | handler GUI |
| `DefList_Click` | 254-269 | Public | 2 | 13 | 0 | handler GUI |
| `affiche_Selection` | 271-330 | Public | 8 | 55 | 0 | portée réductible ? |
| `DefList_KeyPress` | 335-347 | Public | 5 | 11 | 0 | handler GUI |
| `Cmpt_keypress` | 353-408 | Public | 17 | 50 | 0 | handler GUI |
| `Cmpt_Gotfocus` | 410-430 | Public | 11 | 14 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 432-452 | Public | 11 | 14 | 0 | handler GUI |
| `Cmpt2_keypress` | 454-468 | Public | 13 | 10 | 0 | handler GUI |
| `Cmpt2_Gotfocus` | 470-482 | Public | 5 | 8 | 0 | handler GUI |
| `Cmpt2_Lostfocus` | 484-497 | Public | 6 | 9 | 0 | handler GUI |
| `Pfic_Change` | 499-512 | Public | 4 | 10 | 0 | handler GUI |
| `TabOnglet_Click` | 514-526 | Public | 3 | 11 | 0 | handler GUI |
| `BtnQuitter_Click` | 528-532 | Public | 1 | 3 | 0 | handler GUI |
| `BtnEffacerList_Click` | 534-541 | Public | 1 | 5 | 0 | handler GUI |
| `Sep_Click` | 543-559 | Public | 2 | 15 | 0 | handler GUI |
| `Cfix_Click` | 561-577 | Public | 2 | 15 | 0 | handler GUI |
| `DefColonnes` | 579-603 | Public | 2 | 23 | 0 | portée réductible ? |
| `BtnEnregistreZone_KeyPress` | 605-609 | Public | 3 | 3 | 0 | handler GUI |
| `BtnEnregistreZone_Click` | 611-637 | Public | 4 | 22 | 0 | handler GUI |
| `BtnEnregistre_Click` | 639-661 | Public | 6 | 20 | 0 | handler GUI |
| `EnregistreZones` | 663-720 | Public | 9 | 54 | 0 | portée réductible ? |
| `BtnRetirerZone_Click` | 722-736 | Public | 3 | 12 | 0 | handler GUI |
| `Champs_Activate` | 738-750 | Public | 2 | 11 | 0 | handler GUI |
| `Renumerotation` | 752-766 | Public | 3 | 12 | 0 | portée réductible ? |
| `Champs_KeyPress` | 768-917 | Public | 27 | 147 | 0 | handler GUI |
| `Btncreer_Click` | 919-935 | Public | 2 | 14 | 0 | handler GUI |
| `BtnSupprime_Click` | 937-951 | Public | 4 | 12 | 0 | handler GUI |
| `Efface_Zone` | 953-965 | Public | 1 | 11 | 0 | portée réductible ? |
| `Cmpt2_Click` | 967-979 | Public | 3 | 10 | 0 | handler GUI |
| `BtnHelp_Click` | 981-985 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture, fichier, listes

- **`form_Open()`** [GUI] : centrage, `Utils.Observers(Me)` (une fois), focus sur `Cdef`.
- **`Svs_Click()`** [GUI] : exige fournisseur et famille, choix du fichier, puis `Lignes`.
- **`Lignes()`** [portée : réductible] [mixte] : ouvre le fichier, saute la 1re ligne, affiche les
  5 suivantes dans `Ligne2` et garde la 2e ligne du fichier dans `Ligne` (modèle des champs).
  ⚠️ Le fichier n'est **jamais fermé** ; `Catch` vide (fichier court ou absent ignoré) ; aucune
  conversion d'encodage.
- **`TgleBtnFour_Click()` / `TgleBtnFam_Click()`** [mixte] : listes des fournisseurs / familles
  (`Cbase.Table("TabFour"/"TabFam")`), présélection et couleur du champ ; `choicetmp` permet de
  ne pas afficher la liste (appel depuis `affiche_Selection`).
- **`fourList_Click()`, `FamList_Click()`** [GUI] (`replay_dynamic`, `Public` requis),
  **`fourList_KeyPress()`, `FamList_KeyPress()`** [GUI].
- **`TgleBtnFDef_Click()`** [mixte] : liste des définitions (`SELECT num, nom, cfour, nfour FROM
  Fiches_ImpArtDef`). **`DefList_Click()`** [GUI] (`replay_dynamic`) : sélection puis
  `affiche_Selection`. **`DefList_KeyPress()`** [GUI].
- **`affiche_Selection()`** [portée : réductible] [mixte] : `SELECT … Fiches_ImpArtDef d INNER
  JOIN Fiches_ImpArtDef2 n` (à défaut l'en-tête seul) ; remplit les champs, relit le fichier,
  colore fournisseur/famille, puis remplit la grille `Champs` avec les zones 1 à 30 jusqu'à la
  première vide (colonnes selon le mode). `Catch` vide.

### Validation de saisie (groupes `Cmpt`, `Cmpt2`)

- **`Cmpt_keypress()`** (CC 17) [mixte] : tag 1 (`Cdef`) : relit l'en-tête de la définition
  (sans les zones ni le type) ; F2 → liste ; tag 3 (`Four`), tag 4 (`Fam`) : contrôle d'existence.
- **`Cmpt_Gotfocus()` / `Cmpt_Lostfocus()`** [GUI] : `Utils.ObsGotf`/`ObsLstf` selon le tag.
- **`Cmpt2_keypress()`** [GUI] : enchaînement `CBoxZone` → `Debut` → `Longueur` → bouton.
- **`Cmpt2_Gotfocus()`** [GUI] : ⚠️ décalage d'un rang : tag 1 (`CBoxZone`) colore `debut`, tag 2
  (`Debut`) colore `longueur` (le `Lostfocus` est correct) : effet visuel seulement (IMPARTPARAM-A05).
- **`Cmpt2_Lostfocus()`** [GUI] : tag 3 affiche l'aperçu `Mid$(Ligne, Debut, Longueur)`.
- **`Cmpt2_Click()`** [GUI] : focus sur `Pfic` ou `Debut` selon le mode.
- **`Pfic_Change()`** [GUI] : aperçu du champ n° `Pfic` de `Ligne`, découpée par `";"` **en dur**
  (le séparateur choisi `Cbox` est ignoré).

### Définition et zones

- **`TabOnglet_Click()`** [mixte] : passage à l'onglet 2 → `BtnEnregistre_Click` (sauvegarde
  automatique de l'en-tête).
- **`BtnEnregistre_Click()`** [mixte] : `UPDATE` ou `INSERT` de `Fiches_ImpArtDef` (paramètres
  `&N`).
- **`BtnEnregistreZone_Click()`** [mixte] : ajoute une ligne à `Champs`, `DELETE` de la ligne
  `Fiches_ImpArtDef2`, `EnregistreZones`, réaffichage. **`BtnEnregistreZone_KeyPress()`** [GUI].
- **`EnregistreZones()`** [portée : réductible] [mixte] : recopie `Champs` dans les tableaux
  `col_i`, `pos_n`, `db_n`, `lg_n`, `posorg` (indices 1 à 32, taille 33 : plus de 32 zones →
  dépassement d'indice), puis :
  - **ligne existante** (cas de `Champs_KeyPress`, sans `DELETE` préalable) : série d'`UPDATE`.
    Mode `F` : la 2e requête saute `col_i[21]` (paramètres décalés de `col_21` à `col_26`, et trois
    paramètres manquants) ; la 3e requête lit `db_n[231]` → **dépassement d'indice** systématique
    (IMPARTPARAM-A01). Mode `S` : la 2e requête attribue `&{37}` à `pos_25` et `col_26`, `&{41}` à
    `col_28` et `pos_28` (décalage) ; la 4e requête est un SQL invalide (`set = posorg_30 = &{30}
    … where num = &{4}` avec 4 paramètres) (IMPARTPARAM-A02) ;
  - **ligne absente** (cas de `BtnEnregistreZone_Click`/`BtnRetirerZone_Click`, après `DELETE`) :
    `INSERT`. Mode `F` : seules les zones 1 à 15 sont enregistrées et **aucun `posorg`**
    (IMPARTPARAM-A03). Mode `S` : zones 1 à 29 + `UPDATE` 30-32 + `UPDATE` des `posorg`.
  Puis remise à blanc des tableaux (indices 1 à 32 ; `posorg` vidé deux fois).
- **`BtnRetirerZone_Click()`** [mixte] : supprime la ligne courante de `Champs`, `DELETE`,
  `Renumerotation`, `EnregistreZones`, réaffichage (`SELECT` initial inutilisé).
- **`Champs_Activate()`** [GUI] : recharge la zone dans les champs de saisie puis la **retire**
  (édition = retrait + ressaisie).
- **`Renumerotation()`** [portée : réductible] [GUI] : renumérote la colonne 0.
- **`Champs_KeyPress()`** (CC 27, max) [mixte] : Suppr → retrait ; `-` (45) / `+` (43) : échange
  la zone avec la précédente / suivante (deux blocs de 60 lignes quasi symétriques), puis
  `EnregistreZones` (chemin `UPDATE`, donc A01/A02), réaffichage et repositionnement.
- **`BtnEffacerList_Click()`** [mixte] : `DELETE FROM Fiches_ImpArtDef2 WHERE num`, vide la grille.
- **`Sep_Click()` / `Cfix_Click()`** [GUI] : bascule de mode (cases exclusives), vide la grille,
  `DefColonnes`. **`DefColonnes()`** [portée : réductible] [GUI] : en-têtes de `Champs`.
- **`Btncreer_Click()`** [mixte] : `Efface_Zone`, nouveau numéro = dernier `num` lu **sans
  `ORDER BY`** + 1 (ordre dépendant du moteur, IMPARTPARAM-A04).
- **`BtnSupprime_Click()`** [mixte] (handler du groupe `BtnSupprime`, bouton `Button3`) :
  confirmation puis `DELETE` des deux tables. **`Efface_Zone()`** [portée : réductible] [GUI].
- **`BtnQuitter_Click()`, `BtnHelp_Click()`** [GUI].

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Cbase.Table("TabFour"/"TabFam")`.
- Variables de module : `ligne` (2e ligne du fichier), `choicetmp`, `ajoutligne`, tableaux
  `col_i`, `pos_n`, `db_n`, `lg_n`, `posorg`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `EnregistreZones` : construire les `UPDATE`/`INSERT` par boucle sur les 32 rangs (liste de
  colonnes et de paramètres générée), ce qui supprime de fait les décalages ; **change le SQL
  et le contenu écrit** dans les cas A01-A03 : à faire seulement avec ces anomalies.
- `Champs_KeyPress` : procédure privée `EchangeZones(iDecalage)` pour les blocs `+`/`-`
  (CC 27 → ≤ 10).
- `Lignes` : fermer le fichier (`Close`).

### Commonalisation avec d'autres fichiers

- Formulaire « chemin fichier texte » (`Svs_Click`, aperçu du fichier) : `CompArt`, `ImportStk`,
  `Impclient`, [`Impart`](../Impart.class/architecture.md), [`MajFbtarif1`](../MajFbtarif1.class/architecture.md)
  (notes transverses).
- Listes fournisseurs/familles/définitions (`TgleBtn*_Click`, `*List_Click/KeyPress`) :
  quasi identiques dans [`Impart`](../Impart.class/architecture.md) (`ToggleButton1/3_Click`,
  `TgleBtnFDef_Click`).
- Lecture de la définition : `affiche_Selection` (ici) et `Impart.DefList_Click`/`ChargementFichierDef`
  lisent les mêmes tables avec des boucles différentes (1-30, 1-25) : une classe `LImpDef`
  (chargement/enregistrement d'une définition) servirait aux deux écrans.

### Réduction de portée

- `Lignes`, `affiche_Selection`, `DefColonnes`, `EnregistreZones`, `Renumerotation`,
  `Efface_Zone` → `Private` (aucun appelant externe, `grep` vérifié).

### Séparation traitement / GUI

- Séparer la lecture de la grille `Champs` (tableaux) de l'écriture SQL dans `EnregistreZones`
  (`EcritZones(num, bSep)` sans accès aux contrôles).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer la ligne unique de 161 colonnes de `Fiches_ImpArtDef2` par une table normalisée
  `(num, rang, libelle, pos, debut, longueur, champ)` : une ligne par zone, sans limite de 32
  zones, et des requêtes génériques.
- Ajouter des clés `Cbase` pour `Fiches_ImpArtDef*`.
