# FTvac — Architecture

> Source : `.src/Compta/Tables/FTvac.class`

## Vue d'ensemble

Écran de la **table des codes TVA sur achats** (`Fiches_Tvaac` : `code_tva` char(2) clé,
`taux_tva` varchar(5), `cc_tva` compte de TVA). Liste `Tvalist`, saisie code / taux / compte,
boutons Supprimer, Enregistrer, Quitter, aide ; F2 ou bouton `Button4` ouvre une liste de comptes
`445…` (ou commençant par la saisie) dans `Tvalist3`.

À l'enregistrement d'un code existant, le nouveau taux est aussi recopié dans
`Fiches_Comptes.taux_tachat` des comptes qui utilisent ce code. Aucun recalcul de documents
(contrairement à [FTvav](../FTvav.class/architecture.md)).

Ouvert par `Fmenu.Menu113_Click` (auto-instance `Show`). Écran jumeau de `FTvav` (même formulaire,
même logique à 80 %).

Nature : **GUI** avec SQL dans les handlers.

### Contrôles en groupe et handlers inactifs

`Cdtva`, `Txtva` et `Tvacc` appartiennent au groupe d'événements `Tva` : leurs événements vont à
`Tva_GotFocus`/`Tva_KeyPress`. Les procédures nommées `Cdtva_GotFocus`, `Txtva_GotFocus`,
`Tvacc_GotFocus` ne sont donc **jamais déclenchées par Gambas** ; elles sont seulement appelées
explicitement. Deux d'entre elles ne sont appelées par personne (signalées par
`deps.py -f handlers_inactifs`, vérifié par `grep`) :

- **`Txtva_LostFocus`** : la normalisation du taux saisi (`Format$(…, "0.00")`, `"0.00"` si non
  numérique) n'est jamais exécutée ; seul `Utils.PointBase` est appliqué à l'enregistrement.
- **`Tvacc_LostFocus`** → **`Tvaman`** : le contrôle d'existence du compte de TVA n'est jamais
  exécuté, donc `Enr` reste à 0. Conséquence dans `Tva_KeyPress` (tag 3) : Entrée/Tab sur le compte
  ramène toujours le focus sur `Tvacc` au lieu de passer au bouton Enregistrer, et un compte
  inexistant est accepté (anomalie FTVAC-A01).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dne` | var | Private |  | String | 29 |
| `Enr` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-51 | Public | 1 | 16 | 0 | méthode spéciale |
| `cpoint` | 53-57 | Public | 1 | 3 | 0 | portée réductible ? |
| `Form_Open` | 59-77 | Public | 6 | 15 | 0 | handler GUI |
| `Refresh` | 79-89 | Public | 1 | 8 | 0 | portée réductible ? |
| `Maj_Zones` | 91-107 | Public | 3 | 14 | 0 | portée réductible ? |
| `Cleanchamps` | 109-115 | Public | 1 | 5 | 0 | portée réductible ? |
| `Tva_GotFocus` | 120-126 | Public | 1 | 5 | 0 | handler GUI |
| `Tva_KeyPress` | 128-175 | Public | 16 | 40 | 0 | handler GUI |
| `Btn_KeyPress` | 177-186 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 188-203 | Public | 4 | 10 | 0 | handler GUI |
| `Cdtva_GotFocus` | 205-209 | Public | 1 | 3 | 0 | portée réductible ? |
| `Txtva_GotFocus` | 211-215 | Public | 1 | 3 | 0 | portée réductible ? |
| `Txtva_LostFocus` | 217-231 | Public | 2 | 12 | 0 | portée réductible ? |
| `Tvacc_GotFocus` | 233-237 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tvacc_LostFocus` | 239-243 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tvalist_Click` | 245-249 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 251-273 | Public | 3 | 18 | 0 | portée réductible ? |
| `Button3_Click` | 275-296 | Public | 5 | 19 | 0 | portée réductible ? |
| `Button4_Click` | 298-330 | Public | 5 | 30 | 0 | handler GUI |
| `Tvalist3_Click` | 332-339 | Public | 1 | 6 | 0 | handler GUI |
| `Tvalist3_KeyPress` | 344-366 | Public | 6 | 19 | 0 | handler GUI |
| `Button5_Click` | 368-372 | Public | 1 | 3 | 0 | handler GUI |
| `Tvaman` | 374-390 | Public | 3 | 14 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste et zones

- **`_New()`** [portée : nécessaire] [nature : GUI] : observateurs, son, colonnes de `Tvalist`,
  `Cdtva_GotFocus()` (coloration) et focus.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_Tvaac` (sans `ORDER BY`),
  ajout dans `Tvalist` (`Try` sur l'ajout et sur le format du taux).
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide la liste et les zones (`Txtva.clear`
  deux fois) puis `Form_Open`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : recopie la ligne courante, taux reformaté
  par `Val(Utils.cpoint(...))` + `Format$(…, "0.00")`.
- **`Cleanchamps()`** [portée : réductible, **code mort**] : jamais appelée (vérifié par `grep`).
- **`cpoint(mtt)`** [portée : réductible] [nature : calcul] : copie locale de `Utils.cpoint`, appelée
  seulement par `Txtva_LostFocus` (elle-même jamais appelée) : code mort de fait.

### Saisie et focus

- **`Tva_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Tva_KeyPress()`** (CC 16) [handler] : Entrée/Tab enchaîne code → taux → compte ; sur le compte,
  `Dne` reçoit le texte avant la frappe, F1 aide, F2 liste des comptes. Le bloc `Else` (`Enr = 1`
  puis focus bouton) n'est jamais atteint (voir ci-dessus).
- **`Cdtva_GotFocus` / `Txtva_GotFocus` / `Tvacc_GotFocus`** : fond `&HAAFF7F&` (appels explicites).
- **`Txtva_LostFocus` / `Tvacc_LostFocus`** : handlers inactifs, jamais appelés.
- **`Tvaman()`** [portée : réductible] [nature : mixte] : `SELECT * FROM Fiches_Comptes where
  compte_cc = &1` ; message d'erreur et `Enr = 0` si absent, `Enr = 1` sinon. Jamais exécutée.

### Boutons

- **`Btn_Click()`** [handler, groupe `Btn`] : tag 1 supprimer, 2 enregistrer, 3 fermer.
- **`Btn_KeyPress()`** [handler] : **toute touche** sur `Button1` (tag 2) enregistre.
- **`Button1_Click()`** [nature : mixte] — enregistrement, SQL **par concaténation** :
  `SELECT * FROM Fiches_Tvaac WHERE code_tva = '<code>'` ; existant → `UPdate Fiches_Tvaac SET
  code_tva, taux_tva = PointBase(taux), cc_tva` puis `UPdate <TabComptes> SET taux_tachat = &1 WHERE
  code_tachat = &2` (paramétré) ; sinon `INSERT`. Puis `Refresh`. Code vide : sélection de `Tvacc`.
- **`Button3_Click()`** — suppression : confirmation, puis refus si un compte de
  `Fiches_Comptes.code_tachat` utilise le code ; sinon `DELETE … WHERE code_tva = '<Tvalist.Current[0]>'`.
  Le code testé et supprimé est celui de la **ligne sélectionnée**, pas celui saisi ; aucune
  sélection → erreur. Le test sur `CdTva.Text` ne sert que de garde.
- **`Button4_Click()`** — liste des comptes (bascule visible/caché) : `left(compte_cc,3) = '445'` si
  `Dne` est vide, sinon `left(compte_cc,'<n>') = '<saisie>'` (concaténation).
- **`Tvalist3_Click` / `Tvalist3_KeyPress`** [handlers] : choix du compte (Entrée), F1, Échap/F2 ferme.
- **`Tvalist_Click()`** [handler] : `Maj_Zones`.
- **`Button5_Click()`** : `Doc.Open("Tvaachats")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.cpoint`, `Utils.PointBase`,
  `Cbase.Table("TabComptes")` ; `Start.Son`, `Start.Musique`.
- Membres : `Tab` (nom de table réaffecté dans chaque handler), `Dne`, `Enr`.
- Tables : `Fiches_Tvaac` (en dur), `Fiches_Comptes` (en dur et via `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Paramétrer `Button1_Click`, `Button3_Click`, `Button4_Click` (`&1`, `&2`) : SQL identique tant que
  les saisies ne contiennent pas d'apostrophe (codes et comptes numériques) — voir A02 pour le cas
  de l'apostrophe.
- Supprimer le membre `Tab` au profit de `Cbase.Table("TabTvac")`/`Cbase.Table("TabComptes")`.

### Commonalisation avec d'autres fichiers

- [FTvav](../FTvav.class/architecture.md) : `_New`, `Form_Open`, `Refresh`, `Maj_Zones`,
  `Cleanchamps`, `Tva_KeyPress`, `Button3_Click`, `Button4_Click`, `Tvaman` et la liste de comptes
  sont identiques au nom de table et de colonne près (`code_tachat`/`code_tvente`). Un module commun
  `TableTva` paramétré par (table TVA, colonne de `Fiches_Comptes`) est proposé en phase 3.
- La liste déroulante de comptes (`Button4_Click` + `Tvalist3_*`) existe aussi dans
  [FJournaux](../FJournaux.class/architecture.md) (`Coljo2`), [FTvav](../FTvav.class/architecture.md)
  (`Tvavlist`) et [FComptes](../FComptes.class/architecture.md) (`Tvalist`/`Tvalist2`).
- `cpoint` local → [`Utils.cpoint`](../../../Utils/Utils.module/architecture.md).

### Réduction de portée

`cpoint`, `Cleanchamps` (code mort), `Refresh`, `Maj_Zones`, `Tvaman` → `Private`. Les procédures
`*_GotFocus`/`*_LostFocus` gardent leur nom et leur portée `Public` (règle des handlers, même inactifs).

### Séparation traitement / GUI

`EnregistreTva(sCode, sTaux, sCompte)` et `SupprimeTva(sCode) As String` (renvoie le compte qui
bloque la suppression, ou `""`) sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `taux_tva` en `varchar(5)` et `Fiches_Comptes.taux_tachat` dupliqué : un taux numérique
  (`DECIMAL(5,2)`) lu par jointure éviterait la recopie dans les comptes.
- Clé étrangère `Fiches_Comptes.code_tachat → Fiches_Tvaac.code_tva` à la place du contrôle applicatif.
