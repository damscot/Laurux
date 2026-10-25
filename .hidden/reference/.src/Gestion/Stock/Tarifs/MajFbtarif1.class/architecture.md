# MajFbtarif1 — Architecture

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class`

## Vue d'ensemble

Écran d'**import d'une « future base tarif »** depuis un fichier texte : pour chaque ligne
`référence;intitulé;prix;code-barre`, l'article correspondant (par code-barre ou référence
fournisseur, ou par référence centrale) reçoit le futur prix de base `art_pbfbt` et la date
d'application `art_datefbt`. L'application effective des prix est faite ensuite par
[`MajFbtarif2`](../MajFbtarif2.class/architecture.md).

**L'écran est inaccessible** : aucune référence à `MajFbtarif1` dans `.src` hors du fichier
(vérifié par `grep -rn MajFbtarif1 .src`), et le menu « Future base tarif » de `Fmenu`
(`Menu244`) ne propose que `Menu246` (`MajFbtarif2`) et `Menu247` (`Etiqfbtarif`). La même
fonction est assurée par l'option « Maj future base tarif » (`MajFtbt`) d'[`Impart`](../Impart.class/architecture.md),
qui écrit `art_pbfbt`/`art_datefbt` à partir d'une définition d'import paramétrable. Le couple
`.class` + `.form` est donc du **code mort** ; sa suppression est une anomalie soumise à
validation (MAJFBTARIF1-A01).

Nature globale : **mixte** (GUI + lecture de fichier + SQL dans le même handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-11 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 13-17 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 22-64 | Public | 7 | 39 | 0 | handler GUI |
| `fourList_Click` | 69-76 | Public | 1 | 6 | 0 | handler GUI |
| `fourList_KeyPress` | 81-93 | Public | 5 | 11 | 0 | handler GUI |
| `ToggleButton2_Click` | 95-103 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 105-110 | Public | 1 | 4 | 0 | handler GUI |
| `Svs_Click` | 112-120 | Public | 2 | 7 | 0 | handler GUI |
| `Button2_Click` | 122-192 | Public | 21 | 68 | 0 | handler GUI |
| `RadioButton1_Click` | 194-200 | Public | 1 | 5 | 0 | handler GUI |
| `RadioButton2_Click` | 202-208 | Public | 1 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions sont des handlers d'événements (`Public` obligatoire) sauf `_new`.

- **`_new()`** [portée : nécessaire] [nature : GUI]. `Utils.Observers(Me)` (une seule fois),
  chargement du son, centrage.
- **`Button3_Click()`** [GUI] : fermeture.
- **`Button4_Click()`** [mixte] : bascule la liste `fourlist` ; selon `RadioButton1` (fournisseur)
  ou `RadioButton2` (centrale), `SELECT * FROM Fiches_Four` ou `Fiches_Centrales`
  (`Cbase.Table`), boucle `Do … Loop Until MoveNext()`.
- **`fourList_Click()`** [GUI] : recopie code et nom ; `<Grille>_Click` appelé par le rejeu
  (`replay_dynamic`) : doit rester `Public`. **`fourList_KeyPress()`** [GUI] : Entrée → clic,
  Échap/F2 → fermeture de la liste.
- **`ToggleButton2_Click()`**, **`DateChooser1_Activate()`** [GUI] : choix de la date
  (`dd.mm.yyyy`).
- **`Svs_Click()`** [GUI] : sélection du fichier (`Dialog.OpenFile`).
- **`Button2_Click()`** (CC 21, max) [mixte] : lit le fichier ligne par ligne (`Line Input`, sans
  conversion d'encodage), découpe les 4 premiers champs au `;` :
  référence, intitulé (inutilisé), prix (`Utils.cpoint`, `Val = Null` → 0), code-barre (vidé si
  longueur ≠ 13). Recherche de l'article :
  - mode fournisseur : par `art_cbarre`, sinon `art_cfour` + `art_four` ;
  - mode centrale : par `art_refcentrale = Cbarre` (le champ 4 sert de référence centrale ;
    `art_refcentrale` est un `char(13)`, c'est probablement voulu, à confirmer), sinon `art_cbarre = Cbarre` + `art_centrale` (⚠️ un code-barre vide trouve n'importe quel
    article de la centrale sans code-barre, MAJFBTARIF1-A02).
  Puis `UPdate Fiches_Art SET art_pbfbt, art_datefbt` (date via `Utils.Cdate_Dbase`). Pas de
  transaction ; le fichier n'est fermé que sur le chemin normal.
- **`RadioButton1_Click()` / `RadioButton2_Click()`** [GUI] : libellé « Fournisseur »/« Centrale »
  et remise à blanc.
- `Button1` (« Doc HTML ») n'a pas de handler.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.Observers`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune tant que la suppression (A01) n'est pas tranchée : l'écran n'est pas exécuté.

### Commonalisation avec d'autres fichiers

- Formulaire « chemin fichier texte » (`Svs_Click`) commun à `CompArt`, `ImportStk`,
  `Impclient`, [`Impart`](../Impart.class/architecture.md), [`ImpartParam`](../ImpartParam.class/architecture.md)
  (notes transverses, phase 3).
- Liste fournisseurs/centrales (`Button4_Click`, `fourList_*`) : même code dans
  [`Impart`](../Impart.class/architecture.md), [`MajTarifP`](../MajTarifP.class/architecture.md),
  [`MajTarifM`](../MajTarifM.class/architecture.md), [`ImpartParam`](../ImpartParam.class/architecture.md).

### Réduction de portée

- Aucune fonction réductible (handlers et `_new`).

### Séparation traitement / GUI

- Sans objet si l'écran est supprimé ; sinon, extraire `ImporteLigne(sLigne, bCentrale, sFour,
  sDate)` sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table `Fiches_TarifFutur(art, prix, date)` permettrait plusieurs bases tarif futures au
  lieu des deux colonnes `art_pbfbt`/`art_datefbt` de `Fiches_Art`.
