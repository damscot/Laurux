# FPrepRel2 — Architecture

> Source : `.src/Compta/Relances/FPrepRel2.class`

## Vue d'ensemble

`FPrepRel2` est l'**ancien écran de préparation des relances** (en-tête : `FPrepRel.class`, 2004).
**Il n'est plus ouvert nulle part** : le menu « Préparation des relances » (`Fmenu.Menu49_Click`)
ouvre [`FEditrel`](../FEditrel.class/architecture.md) ; aucune référence à `FPrepRel2` n'existe dans
`.src` (grep sur `.class`, `.module`, `.form` ; seul `STRUCTURE.md` le cite). Le couple
`FPrepRel2.class` + `FPrepRel2.form` est donc du **code mort** ; sa suppression est une anomalie
soumise à validation (FPREPREL2-A01), conformément à PLAN.md §0.

Fonctionnement (pour mémoire) : génération de `Fiches_relances` (clé `(compte, numdoc, lind)`,
`numdoc NOT NULL`) à partir de `Fiches_Mvt` par une requête directe, liste des comptes
(`compteRel`) et de leurs écritures (`relances`), choix du niveau par boutons radio, suppression
de comptes ou d'écritures de la liste. Aucune édition : l'impression se faisait ailleurs.

Nature globale : **mixte** (SQL dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Niv` | var | Private |  | Integer | 28 |
| `Devises` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-48 | Public | 3 | 13 | 0 | méthode spéciale |
| `Form_Open` | 50-94 | Public | 1 | 43 | 0 | handler GUI |
| `dte_KeyPress` | 96-112 | Public | 6 | 13 | 0 | handler GUI |
| `dteN1_GotFocus` | 114-120 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 122-135 | Public | 2 | 12 | 0 | portée réductible ? |
| `compteRel_KeyPress` | 137-144 | Public | 2 | 6 | 0 | handler GUI |
| `compteRel_Activate` | 146-170 | Public | 6 | 22 | 0 | handler GUI |
| `Relances_KeyPress` | 172-179 | Public | 2 | 6 | 0 | handler GUI |
| `relances_Activate` | 181-202 | Public | 6 | 19 | 0 | handler GUI |
| `button1_KeyPress` | 204-208 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 210-281 | Public | 10 | 68 | 0 | handler GUI |
| `compteRel_Click` | 283-323 | Public | 6 | 38 | 0 | handler GUI |
| `MajTab` | 325-373 | Public | 6 | 46 | 0 | portée réductible ? |
| `relances_Click` | 375-397 | Public | 5 | 21 | 0 | handler GUI |
| `Button2_Click` | 399-411 | Public | 4 | 10 | 0 | handler GUI |
| `Niv0_Click` | 413-417 | Public | 1 | 3 | 0 | handler GUI |
| `Niv1_Click` | 419-423 | Public | 1 | 3 | 0 | handler GUI |
| `Niv2_Click` | 425-429 | Public | 1 | 3 | 0 | handler GUI |
| `Niv3_Click` | 431-435 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 437-441 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 443-447 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions sont des handlers ou `_New` sauf `MajTab` ; l'écran étant mort, la portée est
sans objet.

- **`_New()`** [spéciale] [mixte]. Observateurs, son, date du jour, devise de `Fiches_Parametres`
  (`"Euros"` par défaut).
- **`Form_Open()`** [handler] [GUI]. Colonnes des deux `ColumnView` (`compteRel` 7 colonnes,
  `relances` **8** colonnes alors que l'index 8 est écrit dans `compteRel_Click`).
- **`dte_KeyPress()`** [handler du groupe `Dte`] [GUI]. Entrée/Tab → `dteN1_LostFocus` ; F1 → aide.
- **`dteN1_GotFocus()` / `dteN1_LostFocus()`** [handlers] [GUI]. Couleur et normalisation de la date.
- **`compteRel_KeyPress()` / `compteRel_Activate()`** [handlers] [mixte]. Suppr ou double-clic :
  confirmation puis, **pour chaque ligne** du compte, le même
  `DELETE FROM Fiches_relances WHERE compte= '…'` **par concaténation** (N fois la même requête) ;
  la ligne est retirée de la liste même si l'utilisateur répond « Non », puis `MajTab`.
- **`Relances_KeyPress()` / `relances_Activate()`** [handlers] [mixte]. Même schéma par `numdoc`
  (concaténation, requête répétée).
- **`button1_KeyPress()`** [handler] [GUI]. Toute touche sur le bouton → `Button1_Click`.
- **`Button1_Click()`** [handler] [mixte] (CC 10). `DROP`/`CREATE` de `Fiches_relances` ;
  `SELECT * FROM Fiches_Mvt` (comptes `411`, non lettrées, hors collectif : échéance ≤ date ou nulle
  pour `tresorerie = 0`, date ≤ date pour `tresorerie = 1`) ; niveau = `relance + 1` borné à 3 ;
  `INSERT` sous `Try` avec la **date d'échéance** dans `dte`, repli `numdoc = compte & lind` ;
  `MajTab`.
- **`compteRel_Click()`** [handler] [mixte]. Écritures du compte, total dû ; les deux branches du
  test `Relances.count > 1` sont identiques ; `Devises` est mis au pluriel de façon permanente.
- **`MajTab()`** [Public, aucun appelant externe] [mixte]. Liste des comptes avec cumul débit/crédit
  et total général.
- **`relances_Click()`** [handler] [GUI]. Coche le bouton radio du niveau de la ligne
  (`relances.Item[8]`, colonne hors des 8 déclarées).
- **`Button2_Click()`** [handler] [mixte]. `UPdate Fiches_relances SET niveau = '<Niv>'`
  (concaténation) pour la ligne courante ; branche `Else` vide.
- **`Niv0_Click` … `Niv3_Click`** [handlers] [GUI]. Niveau choisi.
- **`Button3_Click()`** [handler] [GUI]. Ferme. **`Button7_Click()`** : `Doc.Open("Preprelances")`.

## État global utilisé

- `Utils.db`, `Utils.Cdate_*`, `Utils.Observers`, `Cbase.Table("TabParam")`, `Start.Son`,
  `Start.Musique`, `Doc.Open`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : supprimer le couple `.class`/`.form` (anomalie A01). Tant qu'il est conservé, ne pas y
  investir de rework.

### Commonalisation avec d'autres fichiers

- Génération de `Fiches_relances` concurrente de [`FEditrel.Button1_Click`](../FEditrel.class/architecture.md)
  avec une **clé primaire différente** : si l'écran était rouvert, il changerait la structure de la
  table de travail utilisée par `FEditrel`, `Ligcli` et `Ligext`.

### Réduction de portée

- `MajTab` : réductible (aucun appelant externe), sans intérêt si le fichier est supprimé.

### Séparation traitement / GUI

- Sans objet (code mort).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier (voir `FEditrel` pour la table de travail `Fiches_relances`).
