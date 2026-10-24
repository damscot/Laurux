# EdNjustifiees — Architecture

> Source : `.src/Compta/Impressions/EdNjustifiees.class`

## Vue d'ensemble

`EdNjustifiees` est l'écran **« Impressions des écritures non justifiées »** (menu Compta,
`Fmenu.Menu252_Click` → `EdNjustifiees.Show()`). Pour une plage de comptes clients ou
fournisseurs (optionnellement restreinte à des types de clients via `TypeClient1`), il compare le
**solde mémorisé** du compte (`Fiches_Comptes.solde`) au **total des écritures validées non
lettrées** de `Fiches_Mvt` ; lorsque les deux diffèrent (comparaison des chaînes formatées
`",0.00"`), il imprime le compte (avec son solde mémorisé) suivi de toutes ses écritures non
lettrées avec un solde progressif. PDF `~/tmp/Enlettrees.pdf` (`Ccompta`, même nom que
l'édition des non lettrées), ouvert par `Visualiseur.Prog`.

L'écran n'a pas de période : seules les écritures de l'exercice en cours (`Fiches_Mvt`) sont
prises en compte, et l'en-tête porte « du <date du jour> ».

Nature globale : **mixte** ; `Button1_Click` (CC 16) contient tout le traitement.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotDeb` | var | Private |  | Float | 27 |
| `TotCred` | var | Private |  | Float | 28 |
| `TotSld` | var | Private |  | Float | 29 |
| `debit` | var | Private |  | Float | 30 |
| `credit` | var | Private |  | Float | 31 |
| `solde` | var | Private |  | Float | 32 |
| `Filename` | var | Private |  | String | 33 |
| `Tab1` | var | Private |  | String | 34 |
| `jour` | var | Private |  | String | 35 |
| `Compt` | var | Private |  | String | 36 |
| `cResult` | var | Private |  | Result | 37 |
| `rResult` | var | Private |  | Result | 38 |
| `Tab` | var | Private |  | String | 39 |
| `son` | var | Private |  | Integer | 40 |
| `Coulfond` | var | Private |  | New String[] | 41 |
| `PosY` | var | Private |  | Integer | 42 |
| `pdf` | var | Private |  | Ccompta | 43 |
| `Type` | var | Private |  | String | 44 |
| `Bsel` | var | Public |  | Boolean | 46 |
| `Bval` | var | Public |  | String | 47 |
<!-- /AUTO:declarations -->

Variables utiles : `Type` (`"C"`/`"F"`), `Compt`, `cResult`/`rResult`, `debit`/`credit`/`solde`
(solde progressif imprimé), `PosY`, `pdf`, `Filename`, `jour` (date du jour pour l'en-tête),
`son`, `Bsel`/`Bval` (**publics, écrits par `TriCpt`**). Inutiles : `Tab1` (`"Ctrln"`, jamais
utilisée), `Tab` (nom en dur réaffecté), `Coulfond` (lu, jamais utilisé), `TotDeb`/`TotCred`/
`TotSld` (cumulés, jamais imprimés).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 52-62 | Public | 1 | 8 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 67-107 | Public | 10 | 32 | 0 | handler GUI |
| `Btn_Click` | 112-128 | Public | 4 | 9 | 0 | handler GUI |
| `cpt_GotFocus` | 133-137 | Public | 2 | 3 | 0 | portée réductible ? |
| `cpt_LostFocus` | 139-143 | Public | 2 | 3 | 0 | portée réductible ? |
| `cpt2_GotFocus` | 145-149 | Public | 2 | 3 | 0 | portée réductible ? |
| `cpt2_LostFocus` | 151-155 | Public | 2 | 3 | 0 | portée réductible ? |
| `Raz` | 160-170 | Public | 1 | 9 | 0 | portée réductible ? |
| `Bclient_Click` | 175-184 | Public | 1 | 8 | 0 | handler GUI |
| `Bfournisseur_Click` | 189-198 | Public | 1 | 8 | 0 | handler GUI |
| `ToggleButton1_Click` | 203-214 | Public | 2 | 9 | 0 | handler GUI |
| `ToggleButton2_Click` | 219-230 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 235-359 | Public | 16 | 122 | 0 | portée réductible ? |
| `Button3_Click` | 364-368 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Coulfd` (inutile),
  observateurs, musique, centrage, `Bclient_Click()`, `jour` = aujourd'hui.
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI].
  Entrée/Tab alterne `Cpt` (tag 1) ↔ `Cpt2` (tag 2). F1 → `Button3_Click`. **F2 teste les tags 3
  et 4** (copie d'`EdNlettrees`, où `Cpt`/`Cpt2` portent ces tags) : ici aucun contrôle du groupe
  n'a ces tags, la sélection de compte au clavier est **inopérante** (EDNJUSTIFIEES-A01).
- **`Btn_Click()`** [portée : nécessaire (handler des groupes `Btn`/`btn`)] [nature : GUI]. Tag 2
  imprimer (`Button1`), 3 fermer (`Button6`), 1 vide.
- **`cpt_GotFocus`, `cpt_LostFocus`, `cpt2_GotFocus`, `cpt2_LostFocus`** [portée : nécessaire
  (noms de handlers)] [nature : GUI]. Couleurs par `Utils.ObsGotf`/`ObsLstf` (sous `Try`).
  Groupe `Cmpt` : exécutées seulement par appel explicite.
- **`Bclient_Click()`, `Bfournisseur_Click()`** [portée : nécessaire (handlers)] [nature : GUI].
  Plages `41100001`–`41199999` / `40100001`–`40199999`, `Type`, visibilité de `TypeClient1`.
- **`ToggleButton1_Click()`, `ToggleButton2_Click()`** [portée : nécessaire (handlers)] [nature :
  GUI]. Sélection par `TriCpt(Type, TriCpt.Avec_Solde, Me)` ; résultat dans `Cpt`/`Cpt2`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro (`solde` deux fois).
- **`Button3_Click()`** [portée : réductible — aucun contrôle `Button3` dans le `.form`, appelée
  par F1] [nature : GUI]. `Doc.Open("Njustifiees")`.

### Impression

- **`Button1_Click()`** (CC 16) [portée : nécessaire (appelé par `Btn_Click`, nom de handler)]
  [nature : mixte].
  1. `SELECT * FROM Fiches_Societes Where cd_sc = &1` (nom en dur), `Shell "cd …"` inutile,
     `New Ccompta`, `Entete("Impression des écritures non justifiées.")`, `Level0("du <jour>")`,
     `Level1`.
  2. Comptes : `SELECT compte_cc, intitule_cc, solde FROM Fiches_Comptes [,Fiches_Cli WHERE
     cli_code = compte_cc AND] cast(compte_cc as char) >= &1 and … <= &2 and type_cc = &4
     [And <TypeClient1.where>] … order by cast(compte_cc AS char)` (via `Cbase.Table("TabComptes")`
     sauf `Fiches_Cli` ; variable `req` vide concaténée ; paramètre `0` surnuméraire).
  3. Par compte : `SELECT * FROM Fiches_Mvt WHERE compte = &1 AND validee = 1 AND lettree = 0 order
     by dte` (via `Cbase.Table("TabMvt")`) ; somme `débit - crédit` ; si
     `Format$(solde mémorisé) <> Format$(somme)` : `MoveFirst`, `level6` (compte + solde mémorisé),
     une ligne `level2` par écriture avec solde progressif. Aucun total imprimé (les cumuls
     `totdeb`/`totcred`/`totsld` sont morts).
  4. `BasPage` (dernière page), `Output`, `Visualiseur.Prog`. Sans compte : son + « Aucune ecriture
     pour cette demande » ; si tous les comptes sont justifiés, un PDF sans ligne est produit.
  Saut de page `PosY >= 280` copié 4 fois.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Aff`, `Utils.ObsGotf`/`ObsLstf`, `Utils.Observers`,
  `Utils.Coulfd` ; `Cbase.Table("TabComptes"|"TabMvt")`.
- `TypeClient` (`where`), `TriCpt` (écrit `Bsel`/`Bval`), `Ccompta`, `Visualiseur`, `Doc`.
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- Noms en dur : `Fiches_Societes`, `Fiches_Cli`, `Ctrln` (déclaré, inutilisé).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les cumuls morts, `Tab1`, `req`, `Coulfond`, le `Shell "cd"`.
- Le total des écritures non lettrées peut être calculé en SQL (`SUM(montantd) - SUM(montantc)`)
  puis les lignes relues seulement si le compte est à imprimer (SQL modifié, dump identique ; la
  comparaison formatée `",0.00"` doit rester identique, sommes Float comprises — à confirmer).
- Helper `SautPage()` pour les quatre blocs `PosY >= 280`.

### Commonalisation avec d'autres fichiers

- **Socle commun des éditions comptables** et socle d'édition PDF paginée (EDITCOMPTE-006, voir
  [Editcompte](../Editcompte.class/rework.md) et [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- **Sélection de plage de comptes** partagée avec [EdNlettrees](../EdNlettrees.class/architecture.md)
  (`PlageComptes`, `ChoisirCompte`, `Comptes_Plage`) ; la requête des comptes est identique à celle
  d'`EdNlettrees` hors colonne `solde` et filtre `lettrable`.
- Le recalcul du solde mémorisé lui-même est fait par `Csolde`
  ([Csolde](../../../Utils/Csolde.module/architecture.md)) : une fonction commune « somme des non
  lettrées d'un compte » servirait aussi au lettrage.
- `Ctrln` : nom de table de travail partagé par Editcompte, EditcompteM, Extrait, FTVA, EdImpayes
  avec des structures différentes (collision multi-poste, EDITCOMPTE-A06) ; ici seulement déclaré,
  à supprimer.

### Réduction de portée

- `Raz`, `Button3_Click` (pas de contrôle `Button3`) → `Private`. **Ne pas** réduire `Bsel`/`Bval`
  (écrits par `TriCpt` via `Object.SetProperty`, faux positif de `deps.py`).

### Séparation traitement / GUI

- `Compte_Non_Justifie(sCompte, fSoldeMemorise) As Result` (ou `Null`) sans contrôle ;
  `Button1_Click` ne fait que le rendu.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le solde mémorisé `Fiches_Comptes.solde` est une donnée dérivée susceptible de diverger (c'est
  la raison d'être de l'écran) : une vue calculée le rendrait inutile.
- Index `(compte, validee, lettree)` sur `Fiches_Mvt*`.
