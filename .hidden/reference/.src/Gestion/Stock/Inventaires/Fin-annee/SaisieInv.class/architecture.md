# SaisieInv — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class`

## Vue d'ensemble

Écran de **saisie des comptages de l'inventaire de fin d'exercice** (menu 82,
[`Fmenu.class:1058`](../../../../../Communs/Fmenu.class/architecture.md), `Saisieinv.Show`). Il
travaille sur la table de travail `Fiches_Inv` créée par [Geninv](../Geninv.class/architecture.md) :

- grille `Colinv` (n° ligne, code, désignation, qté théorique, qté comptée, écart) affichant les
  références **saisies** (`inv_comptee = 1`, `RadioButton1`, défaut) ou **non saisies**
  (`RadioButton2`) ;
- saisie d'une ligne par **n° de ligne** (`Nl`, défaut : `Nseq` → article chargé) ou par **code
  article** (`Ca` : code, code équivalent `art_cequ`, référence centrale, code-barres préfixé `*`),
  puis quantité comptée (`qtecomptee`, `TextReg` filtré `[0-9]*[.,]?[0-9]*`) et « Enregistrer » ;
- ressaisie d'une ligne déjà comptée : choix **cumuler / remplacer** ;
- rappel d'une ligne (`Colinv_Activate`, double-clic ou Entrée) pour correction, suppression d'une
  ligne (Suppr) ;
- **import d'un terminal portable** : fichier `~/Portable/inventaire.txt` (`codebarre;quantité`),
  rejets listés dans `~/tmp/Inv.txt` et ouverts dans l'éditeur.

Copie à 93 % de [SaisieInvT](../../Tournant/SaisieInvT.class/architecture.md) (389 lignes communes,
19 fonctions homonymes sur 20) : seule la table (`Fiches_Inv`/`Fiches_InvT`) change, plus quelques
divergences accidentelles listées dans les anomalies de SaisieInvT.

Groupes du `.form` : `Btn` (`Button1` Tag 1 « Enregistrer », `Button4` Tag 3 « Quitter »,
`Button3` Tag 4 « Importer », groupe écrit `btn`), `Rcpt` (`Nseq` Tag 1, `Cart` Tag 3).
`Button2` (aide) et `qtecomptee` ne sont pas groupés. Comme `Nseq` et `Cart` sont dans le groupe
`Rcpt`, **`Nseq_LostFocus` et `Cart_LostFocus` ne sont jamais levés par Gambas** (il faudrait
`Rcpt_LostFocus`) : ce sont des méthodes ordinaires appelées par `Rcpt_KeyPress` et `Btn_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfil` | var | Private |  | File | 3 |
| `Lig` | var | Private |  | String | 4 |
| `iPos` | var | Private |  | Integer | 5 |
| `son` | var | Private |  | Integer | 6 |
| `Dcem` | var | Private |  | String | 7 |
| `Lgrappel` | var | Private |  | Boolean | 8 |
| `filename` | var | Private |  | String | 9 |
<!-- /AUTO:declarations -->

- `hfil`, `Lig`, `iPos` : utilisés seulement dans `Import_Portable` (devraient être locaux).
- `Dcem` : nombre de décimales de l'article courant (`art_dec`), partagé entre `Nseq_LostFocus`,
  `Art_man` et `qtecomptee_LostFocus`.
- `Lgrappel` : vrai après un rappel de ligne (`Colinv_Activate`).
- `filename` : fichier de rejets de l'import.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 14-47 | Public | 1 | 29 | 0 | méthode spéciale |
| `Saisie_Inv` | 52-93 | Public | 12 | 39 | 0 | portée réductible ? |
| `Btn_Click` | 98-133 | Public | 10 | 31 | 0 | handler GUI |
| `Btn_KeyPress` | 138-147 | Public | 5 | 8 | 0 | handler GUI |
| `Rcpt_GotFocus` | 152-158 | Public | 1 | 5 | 0 | handler GUI |
| `Nseq_LostFocus` | 163-188 | Public | 3 | 20 | 0 | portée réductible ? |
| `Cart_LostFocus` | 190-201 | Public | 2 | 10 | 0 | portée réductible ? |
| `Art_man` | 206-245 | Public | 9 | 37 | 0 | portée réductible ? |
| `qtecomptee_LostFocus` | 250-268 | Public | 4 | 17 | 0 | handler GUI |
| `Rcpt_KeyPress` | 270-309 | Public | 12 | 33 | 0 | handler GUI |
| `Valigne` | 314-364 | Public | 6 | 43 | 0 | portée réductible ? |
| `Colinv_Activate` | 369-391 | Public | 1 | 19 | 0 | handler GUI |
| `Colinv_Keypress` | 396-418 | Public | 9 | 18 | 0 | handler GUI |
| `RadioButton1_Click` | 420-424 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton2_Click` | 426-430 | Public | 1 | 3 | 0 | handler GUI |
| `Nl_Click` | 432-441 | Public | 1 | 7 | 0 | handler GUI |
| `Ca_Click` | 443-452 | Public | 1 | 7 | 0 | handler GUI |
| `Import_Portable` | 457-539 | Public | 24 | 79 | 0 | portée réductible ? |
| `Button2_Click` | 541-545 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Affichage

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`, chaînage de
  saisie `New Chainage([Nseq, qtecomptee, Button1])`, colonnes de la grille, puis `Saisie_Inv("1")`.
- **`Saisie_Inv(Type)`** [portée : réductible] [nature : mixte]. `Try SELECT * FROM
  Cbase.Table("TabInv") WHERE inv_comptee = &1` (1 si `Type = "1"`, sinon 0), puis pour chaque
  ligne `SELECT * FROM TabArt WHERE art_code` (sans `Available`) et remplissage de `Colinv`.
  Écart : `inv_qtecomptee - inv_qtestock` si la quantité comptée est non nulle, sinon
  **`+inv_qtestock`** (signe inversé, SAISIEINV-A03). Table absente → message « aucun inventaire »
  et `Me.Close` (appelé depuis `_New`). Partie extractible : la requête et le calcul de l'écart.
- **`RadioButton1_Click()` / `RadioButton2_Click()`** [handlers] [GUI]. `Saisie_Inv("1"/"2")`.
- **`Nl_Click()` / `Ca_Click()`** [handlers] [GUI]. Bascule la saisie par n° de ligne / par code
  (visibilité de `Nseq`, `Cart` en lecture seule ou non).

### Saisie d'une ligne

- **`Rcpt_GotFocus()`** [handler du groupe `Rcpt`] [GUI]. `Utils.SetEditColor`.
- **`Rcpt_KeyPress()`** [handler] [GUI]. Entrée/Tab sur `Nseq` (Tag 1) → `Nseq_LostFocus` puis
  focus quantité ; sur `Cart` (Tag 3) → `Cart_LostFocus` ; `Case 2` vide ; F1 → aide.
- **`Nseq_LostFocus()`** [portée : réductible — pas un handler] [mixte]. `SELECT * FROM Fiches_Inv
  WHERE inv_nlig = &1` (nom en dur) ; si trouvé, `SELECT art_code, art_design, art_qte, art_dec`
  (sans `Available`) et affichage ; sinon « Ce numéro de ligne n'existe pas ». La qté théorique
  affichée est `art_qte` **courant**, pas `inv_qtestock`.
- **`Cart_LostFocus()`** [réductible — pas un handler] [GUI]. Code préfixé `*` → retire le `*`,
  `Utils.Find_Cbarre`, `Wait 0.2`, puis `Art_man`.
- **`Art_man(Prod)`** [réductible] [mixte]. Paramètre `Prod` **inutilisé** (lit `Cart.Text`) ; la
  branche `*` est morte (déjà retirée par `Cart_LostFocus`, seul appelant). Recherche successive
  `art_code`, `art_cequ`, `art_refcentrale`, puis `SELECT inv_nlig FROM Fiches_Inv WHERE Inv_code`.
  Messages « absent du fichier inventaire » / « Ce code n'existe pas ». `Catch` → `Message.Error`.
- **`qtecomptee_LostFocus()`** [handler] [GUI]. Normalise (`Utils.cpoint`, `Utils.Cdec(Dcem, …)`)
  ou signale « saisie erronée ».
- **`Btn_Click()`** [handler du groupe `Btn`] [mixte]. Tag 1 : si n° ligne, code et quantité sont
  remplis → `Valigne`, puis passage à la ligne suivante (`Nseq + 1`) en mode n° de ligne. Tag 3 :
  fermer. Tag 4 : `Import_Portable`.
- **`Btn_KeyPress()`** [handler] [GUI]. Entrée/Tab sur « Enregistrer » → `Btn_Click`.
- **`Valigne()`** [réductible] [mixte]. `UPdate Fiches_Inv SET inv_qtecomptee = &2, inv_comptee = 1
  WHERE inv_nlig = &1`, puis `Colinv.Add(Nseq.Text, Nseq.Text)`. Si la clé existe déjà dans la
  grille, l'`Add` lève une erreur et le **`Catch`** parcourt la grille pour proposer
  « 1 - cumuler / 2 - remplacer » et refait l'`UPDATE` avec la quantité retenue. La détection de
  doublon repose donc sur l'exception et sur le contenu affiché (SAISIEINV-A05).

### Correction et suppression

- **`Colinv_Activate()`** [handler] [mixte]. Recharge la ligne courante dans les champs, la retire
  de la grille et **remet immédiatement le comptage à zéro en base** (`inv_qtecomptee = 0,
  inv_comptee = 0`) ; `Lgrappel = True` (SAISIEINV-A01).
- **`Colinv_Keypress()`** [handler] [mixte]. Suppr + « Oui » → `DELETE FROM Fiches_Inv WHERE
  inv_nlig` (la ligne sort de l'inventaire, SAISIEINV-A02) ; F1 → aide ; Entrée → `Colinv_Activate`.

### Import portable

- **`Import_Portable()`** [réductible] [mixte]. CC 24. Ouvre `~/Portable/inventaire.txt` (message
  si absent), crée `~/tmp/Inv.txt`. Pour chaque ligne contenant `;` : champ 1 → code-barres →
  `Utils.Find_cbarre` ; champ 2 → quantité `Format$(Val(cpoint), "#.###")`. Si la ligne d'inventaire
  n'est pas encore comptée : `UPDATE … inv_qtecomptee, inv_comptee = 1 WHERE inv_code` ; sinon rejet
  « Déjà saisit » (pas de cumul, contrairement à la saisie manuelle). `Code` n'est **pas
  réinitialisé** d'une ligne à l'autre (SAISIEINV-A06). Rejets → `Editeur.Prog_Editeur`. Puis
  `Saisie_Inv("1")` et message de fin. Partie extractible : lecture/parse du fichier et mises à jour.
- **`Button2_Click()`** [handler] [GUI]. Aide `Doc.Open("Saisieinv")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.db`, `Utils.cpoint`, `Utils.CDec`, `Utils.Find_Cbarre`,
  `Utils.SetEditColor`, `Utils.Observers` ; `Chainage`, `Editeur`, `Doc`.
- Fichiers : `~/Portable/inventaire.txt` (lu), `~/tmp/Inv.txt` (écrit).
- Tables : `Fiches_Inv` (lecture, `UPDATE`, `DELETE` ; `Cbase` ou littéral selon la fonction),
  `Fiches_Art` (lecture).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Import_Portable` : `Split(Lig, ";")` au lieu de la boucle `For x = 1 To 2` + `Select` ; membres
  `hfil`, `Lig`, `iPos` en variables locales.
- Les quatre `UPDATE` de comptage (`Valigne` ×3, `Colinv_Activate`) → une fonction privée
  `MajComptage(sNlig, fQte, iComptee)`.

### Commonalisation avec d'autres fichiers

- [SaisieInvT](../../Tournant/SaisieInvT.class/architecture.md) : 93 % identique → module
  `Inventaire` (voir [Geninv](../Geninv.class/architecture.md)) : `Lignes`, `MajComptage`,
  `ImportPortable(sType, …)`. Les deux classes conservent leurs handlers (les `.form` diffèrent par
  la mise en page) mais délèguent tout le SQL au module.
- Lecture de `~/Portable/inventaire.txt` (code-barres ; quantité) dupliquée dans
  [Achat.Import](../../../../Entrées/Achat.class/architecture.md),
  [Facture.GenFacPort](../../../../Facturation/Facture.class/architecture.md) et
  [Majcasier.Import_Portable](../../../../Lcr/Portables/Majcasier.class/architecture.md) : parseur
  commun `Utils.LirePortable(sFichier) As String[][]` (phase 3).
- Recherche d'article `Art_man` (code, `art_cequ`, `art_refcentrale`) proche de
  [`DB_Connection.RecArt`](../../../../../Utils/DB_Connection.class/architecture.md) (code,
  `art_cfour`, `art_refcentrale`) : les champs diffèrent, une fusion demanderait un paramètre de
  liste de champs (rapprochement à étudier en phase 3, pas un rework autonome).

### Réduction de portée

- `Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`, `Import_Portable` →
  `Private` : aucun appelant externe (grep), pas d'appel dynamique ; `Nseq_LostFocus` et
  `Cart_LostFocus` ne sont pas des handlers levés (contrôles groupés).

### Séparation traitement / GUI

- `Valigne`, `Colinv_Activate`, `Colinv_Keypress`, `Import_Portable`, `Saisie_Inv` : SQL et calcul
  d'écart dans des fonctions sans contrôle ; les handlers gardent l'affichage et les questions.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `inv_code` (recherche par code et import).
- Historiser les saisies (une ligne par comptage) au lieu d'écraser `inv_qtecomptee` : permettrait
  le cumul multi-compteurs et l'annulation d'un rappel.
