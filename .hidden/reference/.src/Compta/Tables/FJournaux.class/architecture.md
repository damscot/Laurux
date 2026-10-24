# FJournaux — Architecture

> Source : `.src/Compta/Tables/FJournaux.class`

## Vue d'ensemble

Écran de la **table des journaux comptables** (`Fiches_Journaux` : `code_jo` varchar(2) clé,
`libelle_jo`, `type_jo` (`AC`, `VE`, `TR`, `OD`…), `cde_banque` = compte de trésorerie pour les
journaux `TR`). Liste `Coljo`, saisie code / libellé / type / compte, boutons Enregistrer,
Supprimer, Quitter, aide ; `Button4` (ou F2 sur le compte) ouvre la liste `Coljo2` des comptes de
trésorerie (`comptr_cc` non nul) ou des autres comptes selon le type.

Règles appliquées : code numérique (contrôle `IsNull(Val(code))` sur Entrée et à l'enregistrement),
compte obligatoire pour un journal `TR` et interdit pour les autres.

Points d'entrée : `Fmenu.Menu115_Click` et `Fmenu.journal_Click` (`Show`), `Parametre` (`ShowModal`
de l'auto-instance quand un journal saisi n'existe pas).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `b` | var | Private |  | Integer | 27 |
| `son` | var | Private |  | Integer | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-42 | Public | 1 | 11 | 0 | méthode spéciale |
| `Form_Open` | 44-62 | Public | 3 | 15 | 0 | handler GUI |
| `ColjoRefresh` | 64-69 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 71-79 | Public | 1 | 7 | 0 | portée réductible ? |
| `Cleanchamps` | 81-88 | Public | 1 | 6 | 0 | portée réductible ? |
| `Jo_KeyPress` | 90-146 | Public | 13 | 48 | 0 | handler GUI |
| `Btn_KeyPress` | 148-163 | Public | 3 | 12 | 0 | handler GUI |
| `Btn_Click` | 165-189 | Public | 6 | 18 | 0 | handler GUI |
| `Jo_GotFocus` | 194-200 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 205-247 | Public | 13 | 40 | 0 | portée réductible ? |
| `Coljo_Click` | 252-256 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 261-276 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button4_Click` | 281-315 | Public | 5 | 31 | 0 | handler GUI |
| `Coljo2_Click` | 320-327 | Public | 1 | 6 | 0 | handler GUI |
| `Coljo2_KeyPress` | 332-353 | Public | 6 | 18 | 0 | handler GUI |
| `cptman` | 358-393 | Public | 11 | 33 | 0 | portée réductible ? |
| `Button5_Click` | 398-402 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste et zones

- **`_New()`** [portée : nécessaire] [nature : GUI] : observateurs, son, 2 colonnes de `Coljo`
  (type et compte sont stockés dans `Item[2]`/`Item[3]`, hors colonnes visibles).
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_Journaux order by code_jo`.
- **`ColjoRefresh()`** [portée : réductible] : vide la liste et relance `Form_Open`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : recopie la ligne courante.
- **`Cleanchamps()`** [portée : réductible, **code mort**] : jamais appelée.
- **`Coljo_Click()`** [handler] : `Maj_Zones`.

### Saisie

- **`Jo_KeyPress()`** (CC 13) [handler, groupe `Jo`] : Entrée/Tab : code → contrôle numérique →
  libellé → type (mis en majuscules) → compte ; sur le compte, `cptman()` puis focus selon `b`
  (`b = 1` → retour au code, `b = 0` → reste sur le compte ; l'affectation `b = 1` de la branche
  `Else` est redondante). F1 aide ; F2 sur le compte → `Button4_Click`.
- **`Jo_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`cptman()`** (CC 11) [portée : réductible] [nature : mixte] : journal `TR` avec compte →
  `SELECT * FROM Fiches_Comptes where compte_cc = &1` ; compte absent → avertissement, `b = 0` ;
  compte présent mais non trésorerie → avertissement et `b = 0`, **aussitôt écrasé** par `b = 1`
  (l'avertissement n'est pas bloquant). Journal non `TR` avec compte → avertissement, `b = 1`.

### Boutons

- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer (après contrôle
  numérique), 4 fermer.
- **`Btn_KeyPress()`** [handler] : **toute touche** sur Enregistrer (tag 3) → contrôle numérique
  puis `Button1_Click`.
- **`Button1_Click()`** (CC 13) [nature : mixte] — enregistrement. `cptman()`, puis contrôles
  compte/type (le message « Vous devez renseigner le code comptable » passe par `Message.Question`
  avec un seul bouton). SQL **par concaténation**, exécuté sous `Try` (échec silencieux) :
  `SELECT … WHERE code_jo = '<code>'` ; existant → `UPdate … SET code_jo, libelle_jo, type_jo,
  cde_banque … WHERE code_jo = '<coljo.Current.key>'` (clé de la **ligne sélectionnée**) ; sinon
  `INSERT`. Puis `ColjoRefresh`. Code vide : question « REMPLIR LES CHAMPS OBLIGATOIRES ».
- **`Button3_Click()`** — suppression : confirmation puis `DELETE … WHERE code_jo =
  '<coljo.Current[0]>'` (concaténation, ligne sélectionnée), sans contrôle d'usage du journal dans
  les écritures.
- **`Button4_Click()`** : bascule de `Coljo2` ; `TR` → `comptr_cc is not null and comptr_cc != 0`,
  sinon `comptr_cc is null or comptr_cc = 0` (un paramètre `0` est passé sans placeholder).
- **`Coljo2_Click` / `Coljo2_KeyPress`** [handlers] : choix du compte (Entrée), F1, Échap/F2 ferme.
- **`Button5_Click()`** : `Doc.Open("Journaux")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor` ; `Start.Son`, `Start.Musique`.
- Tables en dur : `Fiches_Journaux`, `Fiches_Comptes`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser le contrôle numérique répété trois fois (`Jo_KeyPress`, `Btn_KeyPress`, `Btn_Click`)
  dans `CodeValide() As Boolean` (avec son message).
- `Cbase.Table("TabJour")` et `Cbase.Table("TabComptes")` à la place des noms en dur.

### Commonalisation avec d'autres fichiers

- Liste de comptes déroulante (`Button4_Click` + `Coljo2_*`) : même motif que
  [FTvac](../FTvac.class/architecture.md), [FTvav](../FTvav.class/architecture.md) et
  [FComptes](../FComptes.class/architecture.md) → helper commun `ListeComptes(cv, sFiltre)` en phase 3.
- Squelette « table de paramétrage » (liste, `Maj_Zones`, `Cleanchamps`, `Refresh`, `Btn_Click`)
  partagé avec [FCollectif](../FCollectif.class/architecture.md),
  [FLibelle](../FLibelle.class/architecture.md), [FPostes](../FPostes.class/architecture.md).

### Réduction de portée

`ColjoRefresh`, `Maj_Zones`, `cptman` → `Private` ; `Cleanchamps` supprimée.

### Séparation traitement / GUI

`EnregistreJournal(sCode, sLib, sType, sCompte, sCleSel)` et `SupprimeJournal(sCode)` sans contrôle
(SQL inchangé jusqu'à la décision sur A01).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère `Fiches_Mvt.jour → Fiches_Journaux.code_jo` (interdirait la suppression d'un journal utilisé).
- `cde_banque` en clé étrangère vers `Fiches_Comptes.compte_cc`.
