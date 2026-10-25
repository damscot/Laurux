# Geninv — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class`

## Vue d'ensemble

Écran de **génération de l'inventaire de fin d'exercice** (menu 81,
[`Fmenu.class:1052`](../../../../../Communs/Fmenu.class/architecture.md), `Geninv.Show`) :

1. **Traitement** (`button1_Click` → `gen_Inv`) : recrée la table de travail `Fiches_Inv`
   (`DROP` + `CREATE TABLE`, clé primaire `inv_nlig char(9)`), puis y insère **tous les articles
   stockés** (`art_stocke = 1`) dans l'ordre choisi : *Tri 1* (familles, fournisseurs, casiers) puis
   *Tri 2* (code article ou désignation). Chaque ligne reçoit un numéro séquentiel `inv_nlig`
   (1, 2, …), le stock théorique courant (`art_qte` → `inv_qtestock`), la date saisie (`inv_date`),
   un comptage nul (`inv_qtecomptee = 0`, `inv_comptee = 0`), la désignation et le casier.
2. **Imprimer** (`Button3_Click`) : produit `~/tmp/Inventaire.pdf` (classe `Cstocks`, gabarit
   `Level1G`/`Level2G`) : feuille de comptage avec n° de ligne, code, désignation, casier, stock
   théorique (case « Impression du stock théorique ») et une colonne de quantité comptée vide.

La saisie des comptages se fait ensuite dans [SaisieInv](../SaisieInv.class/architecture.md), la
validation dans [Validinv](../Validinv.class/architecture.md). Les éditions de contrôle sont
[Ecarts](../Ecarts.class/architecture.md), [Ednsaisis](../Ednsaisis.class/architecture.md) et
[Edinv](../Edinv.class/architecture.md) (`"F"`).

Variante tournante : [GeninvT](../../Tournant/GeninvT.class/architecture.md) (sélection par bornes
et renumérotation à l'impression).

### Chaîne de l'inventaire (fin d'exercice et tournant)

| Étape | Fin d'exercice | Tournant | Tables |
|---|---|---|---|
| Génération | `Geninv` | `GeninvT` | crée `Fiches_Inv` / `Fiches_InvT` (lecture `Fiches_Art`) |
| Feuille de comptage | `Geninv.Button3` | `GeninvT.Button3` (renumérote `inv_nlig`) | lecture |
| Saisie | `SaisieInv` | `SaisieInvT` | `UPDATE inv_qtecomptee, inv_comptee` ; `DELETE` ligne |
| Contrôles | `Ecarts`, `Ednsaisis`, `Edinv("F")` | `EcartsT`, `EdnsaisisT`, `Edinv("T")` | lecture |
| Validation | `Validinv` | `ValidinvT` | `Fiches_Art`, `Fiches_Parametres.dteinv`, `Fiches_HisInvT` / `Fiches_Mvtexp`, `Fiches_HisInvT` |
| Remise à zéro | `RazInv` | `RazInvT` | `DROP` |
| Code mort | `Edinv1` | `EdinvT` | — |

### Duplication mesurée entre les variantes

Mesure sur les lignes de code non vides hors commentaires (`difflib`, script
`output/claude/2026-10-24_rework/phase1/inventaires/dup.py`) :

| Fin d'exercice | Tournant | Lignes communes | Fonctions homonymes |
|---|---|---|---|
| `RazInv` (13) | `RazInvT` (13) | 11 (85 %) | 3/3 |
| `Geninv` (203) | `GeninvT` (531) | 156 (77 % de `Geninv`) | 6/23 (`gen_Inv`, `Button3_Click`…) |
| `SaisieInv` (418) | `SaisieInvT` (418) | 389 (93 %) | 19/20 |
| `Validinv` (158) | `ValidinvT` (122) | 64 (41 %) | 4/5 |
| `Ecarts` (162) | `EcartsT` (164) | 150 (91 %) | 7/7 |
| `Ednsaisis` (154) | `EdnsaisisT` (151) | 143 (93 %) | 7/7 |
| `Edinv` (135) | `EdinvT` (161) | 61 (38 %) | 4/9 |
| `Edinv` (135) | `Edinv1` (126) | 118 (87 %) | 6/6 |
| `Ecarts` (162) | `Ednsaisis` (154) | 100 (62 %) | 7/7 |

Environ 1 090 lignes de code sur 3 030 (15 fichiers) sont des copies d'une variante à l'autre. Les différences portent
presque uniquement sur le **nom de la table** (`Fiches_Inv` / `Fiches_InvT`), les **libellés**
(« Inventaire du » / « Inventaire tournant du ») et quelques divergences accidentelles (corrections
appliquées d'un seul côté, voir les anomalies de chaque fichier). `Edinv` est déjà paramétré
(`_New(choix)` avec `"F"`/`"T"`) et a rendu `Edinv1`/`EdinvT` morts : c'est le précédent à suivre.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `PosY` | var | Private |  | Integer | 29 |
| `Coulfond` | var | Private |  | New String[] | 30 |
| `pdf` | var | Private |  | Cstocks | 31 |
| `tri` | var | Private |  | String | 32 |
<!-- /AUTO:declarations -->

- `Filename` : initialisé à `~/tmp/Edinv.ps` (vestige), puis réaffecté à `~/tmp/Inventaire.pdf`
  par `Button3_Click` ; supprimé à la fermeture (`button2_Click`).
- `son` : `Start.Son` (son activé). `PosY` : position verticale dans le PDF. `pdf` : `Cstocks`.
- `Coulfond` : affecté dans `_New`, **jamais lu** (code mort).
- `tri` : calculé dans `Button3_Click`, **jamais lu** (code mort).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-45 | Public | 1 | 9 | 0 | méthode spéciale |
| `button1_Click` | 47-75 | Public | 6 | 26 | 0 | handler GUI |
| `gen_Inv` | 77-153 | Public | 13 | 73 | 0 | portée réductible ? |
| `Button3_Click` | 155-237 | Public | 11 | 80 | 0 | handler GUI |
| `button2_Click` | 239-244 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 246-250 | Public | 1 | 3 | 0 | handler GUI |
| `Label1_MouseDown` | 252-254 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`,
  `Music.Load`, date du jour dans le `TextReg` `dte` (type date).
- **`button1_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Lit
  `SELECT inv_valid FROM Fiches_Inv` (nom en dur) : si une ligne existe, demande confirmation
  (« inventaire validé / non validé est en cours ») puis `DROP` et `gen_Inv` ; sinon `gen_Inv`.
  Si la table n'existe pas, l'`Exec` lève une erreur (précédée d'un `Message.Error` SQL si le mode
  backtrace est actif) et le **`Catch` appelle `gen_Inv`** : le flux normal de la première
  génération passe par une exception. Toute erreur levée **dans** `gen_Inv` après confirmation
  relance aussi `gen_Inv` depuis le `Catch` (une seconde erreur n'est plus rattrapée).
  `inv_valid` n'est jamais écrit pour `Fiches_Inv` (seul `ValidinvT` l'écrit, sur `Fiches_InvT`) :
  le texte « validé » n'apparaît jamais. Le `DROP` l. 65 est redondant avec celui de `gen_Inv`.
- **`gen_Inv()`** [portée : réductible] [nature : mixte]. `DROP TABLE IF EXISTS Fiches_Inv`,
  `Try CREATE TABLE Fiches_Inv (inv_nlig char(9) PK, inv_code, inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date, inv_comptee TINYINT, inv_valid, inv_design, inv_casier)
  + Utils.db.Engine()` (échec du `CREATE` ignoré). Six `SELECT * FROM Fiches_Art WHERE art_stocke =
  1 ORDER BY <tri1>, <tri2>` selon `Ca`/`Fm`/`Fr` (les six requêtes ne diffèrent que par
  l'`ORDER BY`). Puis un `INSERT` par article (paramétré, date via `Utils.Cdate_Dbase(dte.Text)`).
  `art_qte` vide ou Null → 0. Messages « Traitement terminé » ou « Aucun article ». CC 13. Partie
  extractible : tout sauf la lecture des radios, de `dte` et les messages.
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : mixte]. `SELECT * FROM
  Fiches_Inv` **sans `ORDER BY`**, puis un `SELECT * FROM Fiches_Art WHERE art_code = &1` par
  ligne (sans test `Available`). Pagination à 288 mm (`Baspage` / `Entete` / `Level1G`).
  `qtecomptee` n'est jamais affectée (colonne vide sur la feuille, voulu ?). `tri`, `Nbpage` et
  `Stktheorique` sont calculés et inutilisés. `Shell "cd ~"` sans effet. Toute erreur (dont un
  article supprimé depuis la génération) aboutit au message « Veuillez générer votre inventaire ».
  Sur MySQL/InnoDB, l'ordre de parcours sans `ORDER BY` est celui de la clé primaire `inv_nlig`
  **char(9)**, donc lexicographique (1, 10, 100, 11…) : à confirmer en phase 2 (GENINV-A01).
- **`button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Supprime `Filename`
  s'il existe et ferme.
- **`Button4_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Aide `Doc.Open("Geninv")`.
- **`Label1_MouseDown()`** [portée : nécessaire (handler)] [nature : GUI]. **Vide** ; l'enregistrement
  `MouseDown` de `ReplayObserver` est commenté : code mort.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.db` (`Exec`, `Engine`), `Utils.Cdate_Dbase`,
  `Utils.Coulfd`, `Utils.Observers` ; `Cstocks` (PDF), `Visualiseur.Prog`, `Doc.Open`, `LDate`,
  `TextReg.EstDate`.
- Tables (noms en dur, sans `Cbase.Table`) : `Fiches_Inv` (créée), `Fiches_Art` (lecture).

## Propositions d'amélioration

### Réécriture / refactorisation

- `gen_Inv` : construire l'`ORDER BY` à partir de deux listes blanches
  (`["art_fam", "art_four", "art_casier"]` × `["art_code", "art_design"]`) et n'émettre qu'un
  `SELECT` ; le texte SQL émis reste identique pour chaque combinaison.
- Remplacer le contrôle par exception de `button1_Click` par `Utils.db.Tables.Exist` : cela
  supprime le `Message.Error` SQL affiché en mode backtrace, donc **changement visible** → GENINV-A03.
- `Button3_Click` : séparer la lecture des lignes (avec désignation et casier) de la mise en page.

### Commonalisation avec d'autres fichiers

**Socle commun inventaire proposé (phase 3)** — module `Inventaire` (nouveau fichier
`.src/Gestion/Stock/Inventaires/Inventaire.module`, sans contrôle graphique), paramétré par le type
`"F"` / `"T"` comme [Edinv](../Edinv.class/architecture.md) :

| Fonction | Remplace | Utilisateurs |
|---|---|---|
| `Table(sType)` | littéraux `Fiches_Inv`/`Fiches_InvT`, `Cbase.Table("TabInv"/"TabInvT")` | les 13 fichiers vivants |
| `Libelle(sType)` | « Inventaire du » / « Inventaire tournant du » | éditions, `Geninv*` |
| `DateInv(sType) As String` | lecture de `inv_date` + formatage (4 variantes) | `Ecarts*`, `Ednsaisis*`, `Edinv` |
| `Supprimer(sType)` | `DROP TABLE IF EXISTS` | `RazInv*`, `Geninv*`, `ValidinvT` |
| `Creer(sType)` / `Generer(sType, sWhere, aArgs, sOrdre, sDate) As Integer` | `CREATE` + boucle d'`INSERT` | `Geninv.gen_Inv`, `GeninvT.gen_Inv` |
| `Lignes(sType, iComptee) As Result` | `SELECT … WHERE inv_comptee = &1` | `SaisieInv*`, `Ecarts*`, `Ednsaisis*` |
| `MajComptage(sType, sNlig, fQte, iComptee)` | 4 `UPDATE` par variante | `SaisieInv*` |
| `ImportPortable(sType, sFichier, sRejets) As Integer[]` | `Import_Portable` | `SaisieInv*` |

Les deux DDL diffèrent (`Fiches_Inv` : clé `inv_nlig` ; `Fiches_InvT` : clé auto-incrémentée
`lind`) et doivent rester distincts dans `Creer`. Les `.form`, noms de contrôles et handlers ne
changent pas : chaque classe garde ses handlers, qui délèguent au module. Une fusion des écrans
jumeaux en un seul `.form` paramétré serait plus efficace mais modifie les `.form` : hors périmètre.

Autres rapprochements :
- Boucle d'impression de la feuille de comptage (`Button3_Click`) : identique à
  [GeninvT.Button3_Click](../../Tournant/GeninvT.class/architecture.md) hors renumérotation et date.
- Valeur « stock théorique » : même lecture `art_qte` que [Stockmvt](../../../../Stockmvt.class/architecture.md)
  (`Checkstth`) ; la définition des mouvements reste divergente (STOCKMVT-A05).

### Réduction de portée

- `gen_Inv` → `Private` : aucun appelant externe (`grep -rn gen_Inv .src` : seulement `Geninv` et
  `GeninvT`, chacun le sien), pas d'appel dynamique.

### Séparation traitement / GUI

- `gen_Inv` : fonction `Generer(sOrdre1, sOrdre2, sDate) As Integer` (nombre de lignes) sans accès
  aux contrôles ; le handler lit les radios, la date, et affiche les messages.
- `Button3_Click` : lecture des lignes dans une fonction, mise en page dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table permanente unique `Fiches_Inv` (`inv_type`, `inv_statut`, `inv_nlig INT`) déclarée dans
  `db_control.csv` : supprime le `DROP`/`CREATE` à l'exécution, l'ordre lexicographique de
  `inv_nlig char(9)` et le statut « validé » jamais écrit.
- `inv_qtestock`/`inv_qtecomptee` en `Decimal(12,2)` alors que `art_dec` admet 3 décimales :
  le stock théorique est tronqué à 2 décimales (écarts fictifs ≤ 0,005 dans `Ecarts`). Passer en
  `Decimal(15,3)` comme les quantités d'article.
- Index sur `inv_code` (recherches de `SaisieInv.Art_man`, `Import_Portable`, `Changefam`).
