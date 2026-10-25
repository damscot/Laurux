# EdArt2 — Architecture

> Source : `.src/Gestion/Impressions/EdArt2.class` · Formulaire : `.src/Gestion/Impressions/EdArt2.form`

## Vue d'ensemble

`EdArt2` est l'ancien écran d'**impression du tarif client** (PV HT, TVA, PV TTC). Il n'est plus
appelé nulle part : le menu Gestion > Impression des tables > Tarif > Client
(`Fmenu.Menu74_Click`, `Fmenu.class:863`) ouvre `EdArt4` (classe [`Edart4`](../Edart4.class/architecture.md),
gb.report) depuis le commit `29df3a6d` (« Fix rebase branche boisson sur v3.67 »), qui a remplacé
`EdArt2.Show` par `EdArt4.Show`. Aucune autre référence (grep insensible à la casse sur `EdArt2`
dans `.src`) : le couple `EdArt2.class` + `EdArt2.form` est du **code mort** (anomalie EDART2-A01,
suppression soumise à validation).

Le code est une copie d'[`EdArt1`](../EdArt1.class/architecture.md) (81 % de lignes communes, mêmes
23 fonctions) dont seul `Button2_Click` diffère : colonnes `Level9`/`Level8` (code, désignation,
famille, fournisseur, PV HT, code TVA, PV TTC) ou `Level9bis`/`Level8bis` en mode photo, fichier
`~/tmp/Tarif2.pdf` (nom réutilisé par `EdMat`).

Nature globale : **GUI**, traitement dans `Button2_Click` (CC 21).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `PosX` | var | Private |  | Integer | 32 |
| `Phot_art` | var | Private |  | String | 33 |
| `Bsel` | var | Public |  | Boolean | 35 |
| `Bval` | var | Public |  | String | 36 |
| `Origine` | var | Private |  | String | 38 |
| `b` | var | Private |  | Integer | 39 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 41-57 | Public | 1 | 14 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 59-64 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 66-71 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_Click` | 76-108 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam_KeyPress` | 113-133 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 138-170 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam2_KeyPress` | 175-195 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 200-232 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour_KeyPress` | 237-257 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 262-294 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour2_KeyPress` | 299-319 | Public | 6 | 17 | 0 | handler GUI |
| `SelectionArt` | 322-343 | Public | 4 | 19 | 0 | portée réductible ? |
| `art_man` | 348-374 | Public | 6 | 24 | 0 | portée réductible ? |
| `Colfam_Click` | 379-387 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 392-400 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 405-413 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 418-425 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 427-443 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 445-452 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 454-531 | Public | 20 | 69 | 0 | handler GUI |
| `Cmpt_GotFocus` | 536-542 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 544-651 | Public | 21 | 105 | 0 | portée réductible ? |
| `Button1_Click` | 653-657 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Comportement identique à `EdArt1` pour toutes les fonctions sauf `_New` et `Button2_Click`
(voir [EdArt1/architecture.md](../EdArt1.class/architecture.md#description-des-fonctions)) :

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI] : `Utils.Observers(Me)` en
  premier, pas de lecture de couleurs ; mêmes plages par défaut.
- **`ToggleButton1_Click()` … `ToggleButton6_Click()`**, **`Colfam_KeyPress()`**,
  **`Colfam2_KeyPress()`**, **`Colfour_KeyPress()`**, **`Colfour2_KeyPress()`** [portée : nécessaire
  (handlers)] [nature : mixte pour les listes, GUI sinon] : listes `Fiches_Fam`/`Fiches_Four` (en
  dur, sans `Raise`).
- **`Colfam_Click()`, `Colfam2_Click()`, `Colfour_Click()`, `Colfour2_Click()`** [portée :
  nécessaire (handler, rejeu dynamique)] [nature : GUI].
- **`SelectionArt()`** [portée : réductible] [nature : GUI] ; **`art_man()`** [portée :
  réductible] [nature : mixte].
- **`Btn_Click()`**, **`Btn_KeyPress()`**, **`Cmpt_KeyPress()`**, **`Cmpt_GotFocus()`**,
  **`Button1_Click()`** [portée : nécessaire (handlers)] [nature : GUI].
- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 21). Titre « Impression du tarif client au <date> », en-tête `Level9bis` (photo) ou `Level9`.
  Requêtes `Fiches_Art` (en dur) : ⚠️ ce ne sont **pas** des `Else If` mais 4 `If` successifs, et
  seul le tri par code (`RadioButton1`) filtre la plage fournisseur ; les tris 2 à 4 l'ignorent
  (l. 587, 590, 593). Par article : PV HT, code TVA (`art_tva`), PV TTC formatés selon `art_nbd`,
  `Level8` ou, en mode photo, `Level8bis` + `Photo` (article omis si la photo est illisible) +
  `Ligne2`. `Gpvcons` et `Pvcons` sont lus mais **jamais imprimés**. Saut de page à 283 mm. Variables
  mortes : `Nbpage`, `dte`, `PosX`.

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.Societe`, `Start.LocalSettings` (`/Soc<XX>/Photart`,
  `/Soc<XX>/Pvcons`).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Find_nbdec`,
  `Cbase.Table("TabArt")`, `Visualiseur.Prog`, `Doc.Open`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune tant que l'anomalie EDART2-A01 (suppression) n'est pas tranchée : retravailler un écran
  inatteignable n'apporte rien. Si l'utilisateur décide de le conserver (réactivation du menu), lui
  appliquer les mêmes étapes qu'`EdArt1` (EDART1-002 à 009).

### Commonalisation avec d'autres fichiers

- Voir le tableau de duplication d'[EdArt1](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers)
  (81 % avec `EdArt1`, 77 % avec `EdArt3`). La suppression retire 489 lignes de code.
- Les méthodes `Carticles.Level8`, `Level8bis`, `Level9`, `Level9bis` et `Ligne2` ne sont appelées
  que par `EdArt2` (grep sur les utilisateurs de `Carticles`) : elles deviendraient mortes avec lui
  (à reporter dans le lot Reports).

### Réduction de portée

- `SelectionArt`, `art_man`, `Button2_Click` : sans appelant externe (signal `deps.py` confirmé) ;
  sans objet si le fichier est supprimé.

### Séparation traitement / GUI

- Sans objet (fichier mort).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier.
