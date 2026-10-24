# Sdepots — Architecture

> Source : `.src/Gestion/Depots/Sdepots.class`

## Vue d'ensemble

Écran de **sorties manuelles de stock d'un dépôt** (hors magasin `01`, pour lequel l'écran renvoie
aux mouvements exceptionnels) : date (`Datej`), dépôt (`Code`), puis article (`Cart`) et quantité
(`Qte`) ; chaque validation (`Button1`) décrémente la ligne de `Fiches_StkDepots` (supprimée si le
stock devient ≤ 0) et ajoute une sortie `S` « Sortie manuelle » dans `Fiches_Sdepots`. La grille
`Colrcp` récapitule la saisie. Ouvert par `Fmenu.class:2164` (`Sdepots.show()`).

Copie partielle de [MvtDepots](../MvtDepots.class/architecture.md) (205 lignes communes) :
`aff_Depot`, `Cman`, `ToggleButton2`/`Coldepa`, `art_man` (version « dépôt »), `Dep_KeyPress`,
`Maj_Colrcp`, `Maj_Qtedep`. Groupe `Rcpt` : `Datej` (1), `Code` (2), `Cart` (3), `Qte` (4).
**Pas d'appel à `Utils.Observers`** : l'écran n'est pas instrumenté pour le log/replay.

Nature : **mixte** (mise à jour du stock dans une fonction qui lit les contrôles).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Coulfond` | var | Private |  | New String[] | 3 |
| `Tri` | var | Private |  | String | 4 |
| `Decm` | var | Private |  | String | 5 |
| `B` | var | Public |  | Boolean | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-39 | Public | 1 | 30 | 0 | méthode spéciale |
| `Rcpt_GotFocus` | 44-50 | Public | 1 | 5 | 0 | handler GUI |
| `ToggleButton1_Click` | 53-63 | Public | 2 | 9 | 0 | handler GUI |
| `aff_Depot` | 65-79 | Public | 3 | 12 | 0 | portée réductible ? |
| `Coldep_Click` | 81-95 | Public | 2 | 13 | 0 | handler GUI |
| `Code_KeyPress` | 97-112 | Public | 6 | 14 | 0 | portée réductible ? |
| `Code_GotFocus` | 114-118 | Public | 2 | 3 | 0 | portée réductible ? |
| `Code_LostFocus` | 120-124 | Public | 2 | 3 | 0 | portée réductible ? |
| `Cman` | 126-142 | Public | 3 | 14 | 0 | portée réductible ? |
| `Button3_Click` | 144-148 | Public | 1 | 3 | 0 | handler GUI |
| `Rcpt_keypress` | 150-189 | Public | 13 | 33 | 0 | handler GUI |
| `Rcpt_dblclick` | 191-203 | Public | 3 | 10 | 0 | handler GUI |
| `DateChooser1_Activate` | 205-210 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 213-243 | Public | 6 | 28 | 0 | handler GUI |
| `Coldepa_Click` | 245-252 | Public | 1 | 6 | 0 | handler GUI |
| `art_man` | 257-279 | Public | 3 | 19 | 0 | portée réductible ? |
| `Dep_KeyPress` | 281-307 | Public | 11 | 24 | 0 | portée réductible ? |
| `button1_KeyPress` | 309-313 | Public | 3 | 3 | 0 | handler GUI |
| `Button1_Click` | 315-333 | Public | 4 | 17 | 0 | handler GUI |
| `Maj_Colrcp` | 335-368 | Public | 10 | 31 | 0 | portée réductible ? |
| `Maj_Qtedep` | 373-398 | Public | 5 | 22 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Dépôt et date

- **`_new()`** [portée : nécessaire] [nature : GUI] : centre, `Coulfond = Utils.Coulfd()` (jamais
  utilisé), colonnes, date du jour, focus.
- **`Rcpt_GotFocus()`** [handler du groupe `Rcpt`] : `Utils.SetEditColor`.
- **`Rcpt_keypress()`** [handler du groupe `Rcpt`] (CC 13, max du fichier) : F2 sur la date →
  calendrier, sur le dépôt → liste ; Entrée sur le dépôt → refus de `01` ou `Cman`, sur l'article →
  `Art_Man`, sur la quantité → focus Valider.
- **`Rcpt_dblclick()`** [handler du groupe `Rcpt`] : calendrier sur la date.
- **`DateChooser1_Activate()`** [handler] : date choisie.
- **`ToggleButton1_Click()`** [handler] : bascule de la liste des dépôts (`aff_Depot`).
- **`aff_Depot()`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabDepots> order by code`.
- **`Coldep_Click()`** [handler] : refus du dépôt `01` (message), sinon dépôt choisi. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Code_KeyPress()`, `Code_GotFocus()`, `Code_LostFocus()`** [handlers inactifs] : `Code`
  appartient au groupe `Rcpt`, Gambas ne lève jamais ces handlers ; la saisie du dépôt passe par
  `Rcpt_keypress`/`Rcpt_GotFocus` : **code mort** (`handlers_inactifs`, `unused`).
- **`Cman()`** [portée : réductible] [nature : mixte] : libellé du dépôt saisi ou message « Ce dépôt
  n'existe pas ».

### Article et sortie

- **`ToggleButton2_Click()`** [handler] : liste `Coldepa` des articles du dépôt. Sa première
  instruction, `Tab = "Fiches_Art" & Start.Soc` (ligne 218), référence **`Start.Soc`, qui n'existe
  pas** (IMPRESSION-A03) : erreur d'exécution systématique, la liste des articles n'est jamais
  affichée (anomalie A01). La variable `Tab` n'est d'ailleurs pas utilisée ; la requête passe par
  `db.Exec` (classe `DB`).
- **`Coldepa_Click()`** [handler] : article choisi → `art_man`. Rejoué par `ReplayObserver`
  (`replay_dynamic`) : **reste `Public`** (inatteignable tant que A01 n'est pas corrigée).
- **`art_man()`** [portée : réductible] [nature : mixte] : article présent dans le stock du dépôt
  (`<TabArt> Left join <TabStkDepots> … where codea = &1 and coded = &2`) par **`db.Exec`**
  (classe `DB` de gb.db, hors `Utils.db`, ligne 262) ; `b` = vrai en cas d'échec.
- **`Dep_KeyPress()`** [portée : réductible] : handler d'un groupe `Dep` **absent** de ce `.form`
  (copié de MvtDepots) : jamais levé, **code mort** (`unused`).
- **`button1_KeyPress()`** [handler] : Entrée/Retour → `Button1_Click`.
- **`Button1_Click()`** [handler] [nature : mixte] : si un dépôt est saisi : `Maj_Colrcp`, puis
  `Maj_Qtedep` si `b` ; vide la saisie. Comme dans MvtDepots, `Maj_Colrcp` remet `b` à vrai : un
  article introuvable est quand même traité, mais `Maj_Qtedep` ne fait rien sans ligne de stock.
- **`Maj_Colrcp()`** [portée : réductible] [nature : GUI] : ajout à la grille (clé article + dépôt),
  proposition de cumul sur doublon.
- **`Maj_Qtedep()`** [portée : réductible] [nature : calcul + GUI] : `LOCK TABLES <TabStkDepots>
  WRITE, <TabSdepots> WRITE` ; si la ligne de stock existe : `UPDATE` si le nouveau stock est > 0,
  sinon `DELETE` (une sortie supérieure au stock fait disparaître la ligne, l'historique enregistre
  la quantité saisie), puis `INSERT` de la sortie `S` ; sans ligne de stock, rien n'est fait et
  aucun message n'est affiché.
- **`Button3_Click()`** [handler] : ferme.

## État global utilisé

- `Utils.db`, **classe `DB`** (`db.Exec`), `Utils.Coulfd`, `Utils.SetEditColor`, `Utils.ObsGotf`,
  `Utils.ObsLstf`, `Utils.Cdec`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Cbase.Table` ; `Start.son`,
  **`Start.Soc` (inexistant)**.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`, `Dep_KeyPress`, `Coulfond`, `Tri`.
- La ligne `Tab = "Fiches_Art" & Start.Soc` ne peut pas être supprimée en rework autonome : elle
  provoque aujourd'hui l'erreur qui empêche la liste ; sa suppression change le comportement (A01).

### Commonalisation avec d'autres fichiers

- Module `Depot` partagé avec [MvtDepots](../MvtDepots.class/architecture.md),
  [ImpDepots](../ImpDepots.class/architecture.md) et [Depots](../Depots.class/architecture.md)
  (liste des dépôts, libellé, stock d'un article, mouvement de stock, `Maj_Colrcp`).
- Calendrier F2/double-clic : helper commun avec [Edsdepots](../Edsdepots.class/architecture.md)
  et [Fpromo](../../Tables/Fpromo.class/architecture.md).

### Réduction de portée

`aff_Depot`, `Cman`, `art_man`, `Maj_Colrcp`, `Maj_Qtedep`, variable `B` → `Private` ;
`Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`, `Dep_KeyPress` supprimés.

### Séparation traitement / GUI

`SortieDepot(sDepot, sArt, fQte, sDate) As Boolean` sans contrôle, appelée par `Button1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Autoriser un stock négatif (ou bloquer la sortie) plutôt que supprimer la ligne ; `qte` de
  `Fiches_Sdepots` en décimal ; `code` char(2) trop court (voir Depots).
