# Cielcorspj — Architecture

> Source : `.src/Compta/Cielcorspj.class`

## Vue d'ensemble

Écran de saisie de la **table de correspondance des journaux Ciel → Laurux** (`Ciel_Lrx_Jo` :
`Cciel` clé, `Clrx` code journal Laurux sur 2 caractères, `Intitule`), utilisée par
[`Cielimp`](../Cielimp.class/architecture.md) (journal Ciel → journal Laurux) et `impfec`.
Ouvert en modal par `Fmenu.Menu181_Click` et `impfec.Buttonjo_Click`.

C'est une **copie à 89 %** de [`Cielcorsp`](../Cielcorsp.class/architecture.md) (178 lignes de
code identiques sur 192 hors commentaires). Différences :

| Point | `Cielcorsp` | `Cielcorspj` |
|---|---|---|
| Table de correspondance | `Ciel_Lrx` | `Ciel_Lrx_Jo` |
| Liste F1 (`Button1_Click`) | `Fiches_Comptes` filtré par type C/F (radio) | `Fiches_Journaux` triés par `code_jo` |
| Contrôle (`Cpt_man`) | `compte_cc`, intitulé `intitule_cc` | `code_jo`, intitulé `libelle_jo` |
| Doublon dans la liste | même code Ciel **ou** même compte Laurux | même code Ciel seulement (plusieurs journaux Ciel → un journal Laurux autorisé) |
| Largeur colonne 0 | 150 | 80 |

Nature globale : **mixte** (SQL dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rcpt` | var | Private |  | Result | 27 |
| `Intit` | var | Private |  | String | 28 |
| `B` | var | Private |  | Integer | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-64 | Public | 3 | 31 | 0 | méthode spéciale |
| `Button1_Click` | 69-101 | Public | 5 | 29 | 0 | handler GUI |
| `Colcpt_KeyPress` | 106-126 | Public | 6 | 17 | 0 | handler GUI |
| `Colcpt_Click` | 131-138 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 140-158 | Public | 5 | 12 | 0 | handler GUI |
| `btn_KeyPress` | 160-166 | Public | 4 | 5 | 0 | handler GUI |
| `Button2_Click` | 171-212 | Public | 8 | 38 | 0 | portée réductible ? |
| `Cpt_man` | 217-243 | Public | 4 | 24 | 0 | portée réductible ? |
| `ChkInput` | 245-253 | Public | 6 | 7 | 0 | portée réductible ? |
| `Listecompte_KeyPress` | 258-265 | Public | 2 | 6 | 0 | handler GUI |
| `Listecompte_Activate` | 267-274 | Public | 1 | 6 | 0 | handler GUI |
| `Compte_delete` | 276-283 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button3_Click` | 288-292 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions ont le même rôle que dans `Cielcorsp` ; seules les différences sont détaillées.

- **`_New()`** [portée : nécessaire] [nature : mixte]. Identique, table `Ciel_Lrx_Jo` ; `params`
  inutilisé, `Me.Center` en double.
- **`Button1_Click()`** [portée : nécessaire, `Btn_Click` Tag 1 et F1] [nature : mixte]. Liste
  `SELECT * FROM Fiches_Journaux order by code_jo` ; l'affectation de la colonne 0 est commentée
  (le texte de la colonne 0 vient de `Add(clé, texte)`).
- **`Colcpt_KeyPress()`**, **`Colcpt_Click()`**, **`Btn_Click()`**, **`btn_KeyPress()`**
  [handlers] [nature : GUI]. Identiques. `Button2_Click`/`Button3_Click` sont appelés par
  `Btn_Click` (Tag 2, 3) : pas de handler mort.
- **`Button2_Click()`** (CC 9) [portée : nécessaire] [nature : mixte]. Contrôle de doublon sur le
  seul code Ciel (ligne d'origine commentée), puis `SELECT`/`INSERT INTO Ciel_Lrx_Jo`.
- **`Cpt_man()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Journaux where
  code_jo = &1`, intitulé = `libelle_jo`.
- **`ChkInput()`** [portée : réductible, **code mort**] [nature : GUI].
- **`Listecompte_KeyPress()`**, **`Listecompte_Activate()`** [handlers] [nature : mixte].
  Identiques (suppression immédiate au double-clic).
- **`Compte_delete()`** [portée : réductible] [nature : calcul]. `DELETE FROM Ciel_Lrx_Jo …`.
- **`Button3_Click()`** [portée : nécessaire] [nature : GUI]. `Doc.Open("Cielimport")`.

## État global utilisé

- `Utils.db`, `Utils.Ciel`, `Utils.Observers`, `Start.Musique`, `Start.son`.
- Membres `rcpt`, `Intit`, `B` (même usage que `Cielcorsp`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Mêmes nettoyages que `Cielcorsp` (CIELCORSPJ-002).

### Commonalisation avec d'autres fichiers

- Module commun `CielCorresp` avec [`Cielcorsp`](../Cielcorsp.class/architecture.md)
  (CIELCORSPJ-003 = CIELCORSP-003, même commit) ; paramètres : table, requête de liste, requête
  de contrôle, champ intitulé, contrôle de doublon Laurux (non pour les journaux).
- `Utils.Ciel()` / `Cielimp.Btn_Click` : DDL de `Ciel_Lrx_Jo` identique dans les deux (seule
  `Ciel_Lrx` diffère, voir CIELIMP-A07).

### Réduction de portée

- `Cpt_man`, `Compte_delete` → `Private` ; `ChkInput` supprimé.

### Séparation traitement / GUI

- Même découpage que `Cielcorsp` (`AjouteCorrespondance`, `ControleCompteLaurux`), fourni par le
  module commun.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Clrx Char(2)` correspond à `Fiches_Journaux.code_jo varchar(2)` : à formaliser par une clé
  étrangère si la table entre dans le schéma de référence (voir `Cielcorsp`).
