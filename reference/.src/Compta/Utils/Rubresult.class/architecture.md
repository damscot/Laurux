# Rubresult — Architecture

> Source : `.src/Compta/Utils/Rubresult.class`

## Vue d'ensemble

`Rubresult` est l'écran de **saisie des rubriques** des éditions comptables (table
`Fiches_Rubriques` : `numrub`, `intitule`, `type`, `detail`, `num`). Ouvert par Comptabilité >
Compte de résultat > Gestion des rubriques (`Fmenu.Menu122_Click`, `Rubresult.Show`).

Le numéro de rubrique porte l'édition dans sa première lettre : `B` (bilan, 111 rubriques sur 257 dans
`Laurux01.sql`), `R` (compte de résultat, 97), `S` (SIG, 49). Le `type` pilote les éditions :
`T` titre, `E` entête, `L` ligne alimentée par des plages de comptes (`Fiches_RubCompt`, voir
[Rubcompt](../Rubcompt.class/architecture.md)), `S` sous-total, `O` total, et pour le compte de
résultat `C`/`D` (bénéfice/perte), `R`/`G` (totaux produits/charges) ; `Laurux01.sql` contient aussi une rubrique de type `I` (`R`) et trois rubriques `S` sans type, qui ne sont imprimées par aucune branche des éditions (à confirmer). `detail` (`O`/`N`) et `num`
(`P` produit, `C`/`A` charge) servent aux éditions
([Imp_Bilan](../../Impressions/Imp_Bilan.module/architecture.md),
[Imp_Sig](../../Impressions/Imp_Sig.module/architecture.md),
[RubImp](../../Impressions/RubImp.class/architecture.md)).

L'écran contient la grille `colcol` (code, intitulé, type, détail, `P`), les champs `Numrub`,
`Intitule`, `TypeL`, `Det`, `Prod` (groupe `Lib`, tags 1 à 4 ; `Det` **et** `Prod` ont le tag 4),
les boutons du groupe `Btn` (`Button4` aide tag 1, `Button1` supprimer tag 2, `Button2`
enregistrer tag 3, `Button3` quitter tag 4, `Button5` importer tag 5) et un `DirChooser`
`BcrSelect` masqué, utilisé pour l'**import du paramétrage** depuis `Bcr.txt`/`Bcrcpt.txt`
(fichiers produits par [Exprub](../Exprub.class/architecture.md)).

Nature globale : **GUI avec SQL direct**, plus un traitement d'import destructif (DROP/CREATE des
deux tables de paramétrage).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-52 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 54-76 | Public | 4 | 19 | 0 | handler GUI |
| `colcol_Click` | 78-93 | Public | 1 | 9 | 0 | handler GUI |
| `CleanChamps` | 95-102 | Public | 1 | 6 | 0 | portée réductible ? |
| `Refresh` | 104-109 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 111-147 | Public | 10 | 32 | 0 | handler GUI |
| `Btn_KeyPress` | 149-158 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 160-182 | Public | 7 | 16 | 0 | handler GUI |
| `Lib_GotFocus` | 187-193 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 195-211 | Public | 4 | 14 | 0 | portée réductible ? |
| `Button2_Click` | 213-244 | Public | 4 | 29 | 0 | portée réductible ? |
| `Button3_Click` | 246-250 | Public | 1 | 3 | 0 | portée réductible ? |
| `Rubman` | 255-271 | Public | 3 | 14 | 0 | portée réductible ? |
| `Button5_Click` | 276-282 | Public | 1 | 5 | 0 | portée réductible ? |
| `BcrSelect_Activate` | 284-392 | Public | 21 | 104 | 0 | handler GUI |
| `Button4_Click` | 397-401 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation, liste et saisie

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Observateurs de replay,
  centrage, `Music.Load(Start.Musique)`, configuration des 5 colonnes, focus sur `Numrub`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. Affiche la grille, masque
  `BcrSelect`, `SELECT * FROM Fiches_Rubriques order by numrub` et une ligne par rubrique.
  `Catch` → `Message.Error(Error.Text & Error.Where)`.
- **`Refresh()`** [portée : réductible, avec réserve] [nature : GUI]. Vide la grille et rappelle
  `Form_Open`. Même réserve que dans `Rubcompt` : le nom masque `Form.Refresh`.
- **`colcol_Click()`** [portée : nécessaire (handler, appelé aussi par `ReplayObserver`)] [nature :
  GUI]. Recopie la ligne courante dans les cinq champs (bloc commenté sur `Prod.Enabled`).
- **`CleanChamps()`** [portée : réductible] [nature : GUI]. Vide `Numrub`, `Intitule`, `TypeL`,
  `Det` ; ⚠️ pas `Prod`.
- **`Lib_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée/Retour/Tab : tag 1 →
  `Rubman` puis `Intitule` (si `Numrub` est vide, `Intitule` est passé par `Utils.Remplace` et le
  focus reste sur `Numrub`) ; tag 2 → `TypeL` ; tag 3 → `Det` ; tag 4 (`Det` ou `Prod`) →
  `Button2`. ⚠️ `Prod` n'est donc jamais atteint au clavier. F1 → aide.
- **`Rubman()`** [portée : réductible] [nature : mixte]. `SELECT * … where numrub = &1` ; si
  trouvée, recopie numéro, intitulé, type et détail (pas `num`). Aucun message si absente
  (création).

### Boutons

- **`Btn_Click()`** [portée : nécessaire (handler de groupe)] [nature : GUI]. Tag 1 aide, 2
  supprimer, 3 enregistrer, 4 `Me.Close`, 5 `Message.Question("Importer le paramétrage va écraser
  l'ancien. OK ?")` puis `Button5_Click`.
- **`Btn_KeyPress()`** [portée : nécessaire] [nature : GUI]. Toute touche sur le bouton de tag 3
  enregistre (même défaut que `Rubcompt`).
- **`Button1_Click()`** (supprimer) [portée : nécessaire] [nature : mixte]. Son, confirmation,
  `DELETE FROM Fiches_Rubriques WHERE numrub = &1` avec `colcol.Current[0]` (ligne sélectionnée,
  pas le champ saisi). Les plages `Fiches_RubCompt` de la rubrique restent en base (orphelines).
- **`Button2_Click()`** (enregistrer) [portée : nécessaire] [nature : mixte]. `Utils.Remplace`
  sur l'intitulé, `SELECT` sur `numrub`, puis `INSERT` ou `UPdate` de `intitule`, `UCase$(type)`,
  `UCase$(detail)`, `UCase$(num)`. Rafraîchit et resélectionne la ligne (sans `Try`, contrairement à
  `Rubcompt`). Sans numéro : `Message.Warning`.
- **`Button3_Click()`** — **code mort** (handler nominal inactif : `Button3` est dans le groupe
  `Btn` ; tag 4 traité par `Btn_Click` ; aucun appel trouvé par `grep`).
- **`Button4_Click()`** [portée : nécessaire] [nature : GUI]. `Doc.Open("Rubs")`.
- **`Lib_GotFocus()`** [portée : nécessaire] [nature : GUI]. `Utils.SetEditColor`.

### Import du paramétrage

- **`Button5_Click()`** [portée : nécessaire (appelé par `Btn_Click`)] [nature : GUI]. Affiche
  `BcrSelect` à la place de la grille.
- **`BcrSelect_Activate()`** (CC 21) [portée : nécessaire (handler)] [nature : mixte, traitement
  extractible]. Séquence :
  1. masque le sélecteur, lit le chemin ; contrôle `Exist(Path & "/Bcr.txt")` **deux fois** (le
     second test devait porter sur `Bcrcpt.txt`, anomalie RUBRESULT-A01) ;
  2. `Truncate Fiches_Rubriques`, `DROP TABLE IF EXISTS`, `CREATE TABLE` (`numrub Char(8)` clé,
     `intitule VARCHAR(70)`, `type`/`detail`/`num Char(2)`, `Utils.db.Engine()`) ;
  3. lecture de `Bcr.txt` : 5 champs séparés par `;` (découpage manuel `InStr`/`Left$`/`Mid$`),
     `SELECT` puis `INSERT` ou `UPdate` par ligne ;
  4. même chose pour `Fiches_RubCompt` (`numrub`, `compte1` clé, `compte2 Char(8)`,
     `amortissement TINYINT(1)`) depuis `Bcrcpt.txt` (4 champs ; le 4e est converti en
     `Boolean` : chaîne vide → faux, toute autre chaîne → vrai) ;
  5. rafraîchit la grille, son, `Message.Info("Importation terminée.")`.
  Aucun `Try`/`Catch` ni transaction : une erreur au milieu laisse les tables vidées ou
  partielles. Un `Truncate` n'existe pas en SQLite (non traduit par `DB_Connection`) : l'import y
  échoue dès la première requête (à confirmer).

### SQL émis (récapitulatif)

| Fonction | Requêtes | Tables |
|---|---|---|
| `Form_Open`, `Rubman` | `SELECT` | `Fiches_Rubriques` |
| `Button1_Click` | `DELETE … WHERE numrub = &1` | `Fiches_Rubriques` |
| `Button2_Click` | `SELECT` + `INSERT`/`UPdate` | `Fiches_Rubriques` |
| `BcrSelect_Activate` | `Truncate`, `DROP`, `CREATE`, puis `SELECT` + `INSERT`/`UPdate` par ligne | `Fiches_Rubriques`, `Fiches_RubCompt` |

## État global utilisé

- `Start.Son`, `Start.Musique`, `Music`.
- `Utils.Observers`, `Utils.SetEditColor`, `Utils.Remplace`, `Utils.db` (`Exec`, `Engine`).
- Aucune variable de classe hors `son` (les `Result` sont locaux).

## Propositions d'amélioration

### Réécriture / refactorisation

- `BcrSelect_Activate` : une fonction privée `ChampsLigne(sLigne, iNb) As String[]` qui reproduit
  **exactement** le découpage actuel (y compris le cas d'un `;` manquant : `InStr = 0` →
  `Left$(Lig, -1)`) remplace les deux boucles `For x = 1 To n` + `Select Case` ; une procédure
  `ChargeTable(sFichier, …)` par table.
- `Truncate` immédiatement suivi d'un `DROP TABLE` est inutile ; sa suppression change le SQL émis
  (dump identique) et rendrait l'import possible sous SQLite : changement de comportement sous
  SQLite, donc classé en anomalie (A03).

### Commonalisation avec d'autres fichiers

- [Exprub](../Exprub.class/architecture.md) écrit le format que `BcrSelect_Activate` relit : réunir
  l'export et l'import dans un même module (`Exporte(sRep)` / `Importe(sRep)`, format décrit une
  seule fois).
- [Rubcompt](../Rubcompt.class/architecture.md) : même squelette d'écran ; `LitRubrique(numrub)`
  commun (lecture de `Fiches_Rubriques`) ; clés `Cbase` `TabRubriques`/`TabRubCompt`.
- Le `CREATE TABLE` réécrit ici la structure des deux tables, déjà définie par les migrations de
  `LauruxMaj` et par `db_control.csv` ; aucune factorisation possible sans toucher à `LauruxMaj`
  (interdit) : documenter le lien dans l'en-tête.

### Réduction de portée

- `CleanChamps`, `Rubman` → `Private` (aucun appelant externe, vérifié par `grep`). `Refresh` :
  renommer plutôt que changer la portée. Handlers inchangés.

### Séparation traitement / GUI

- `EnregistreRubrique(sNum, sIntit, sType, sDet, sNumP)`, `SupprimeRubrique(sNum)` et
  `ImporteParametrage(sRep) As String` (renvoie le message d'erreur ou `""`) sans accès aux
  contrôles ; les handlers gardent `Message.*`, son, souris et rafraîchissement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère `Fiches_RubCompt.numrub` → `Fiches_Rubriques.numrub` avec suppression en cascade
  (aujourd'hui la suppression d'une rubrique laisse ses plages).
- Contrainte `CHECK` (ou table de référence) sur `type`, `detail`, `num` : les valeurs admises
  (`T`, `E`, `L`, `S`, `O`, `C`, `D`, `R`, `G` ; `O`/`N` ; `P`/`C`/`A`) ne sont contrôlées nulle part.
- Import dans une transaction avec `DELETE` au lieu de `DROP`/`CREATE`, pour ne jamais redéfinir la
  structure hors migration.
