# Lettrage — Architecture

> Source : `.src/Compta/Lettrages/Lettrage.class`

## Vue d'ensemble

Écran de **lettrage manuel** des écritures d'un compte lettrable (client `C`, fournisseur `F` ou
bilan `B`). L'utilisateur choisit un compte (saisie, `TriCpt` par F2, ou navigation
premier/précédent/suivant/dernier dans la liste des comptes lettrables du type), coche des lignes
dans `Colcli` (marque `*`), puis :

- **Lettrer** (`Button5`, groupe `Btn` tag 3) : si le total débit − crédit des lignes cochées est
  nul, les lignes reçoivent `lettree = 1` et le numéro de lot saisi, ou à défaut un lot aléatoire
  à 7 chiffres ;
- **Délettrer** (`Button7`, tag 2) : `lettree = 0` sur les lignes cochées.

La lecture et l'écriture des écritures passent par [`Listextcpt`](../../Utils/Listextcpt.class/architecture.md)
(`resext` pour la liste, `letcpt(lind, valeur, lot, "lettrage")` pour l'UPDATE dans la bonne table
`Fiches_Mvt…Mvt5`). La fenêtre de dates va du début de l'exercice de `Fiches_Parametres.dteclec`
jusqu'à la fin de l'exercice suivant.

Ouvert par `Fmenu.Menu51_Click` (`New Lettrage("", "")`) et `Extrait.cmpt_keypress` (F4, avec le
compte et le type courants). `TriCpt` renvoie sa sélection par `Object.SetProperty` sur `Bsel`/`Bval`.

Nature globale : **GUI** avec SQL dans les handlers ; aucun calcul isolé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TT` | var | Private |  | Float | 28 |
| `TD` | var | Private |  | String | 29 |
| `TC` | var | Private |  | String | 30 |
| `Compt` | var | Private |  | String | 31 |
| `type` | var | Private |  | String | 32 |
| `rResult` | var | Private |  | Result | 33 |
| `rrResult` | var | Private |  | Result | 34 |
| `Tab2` | var | Private |  | String | 35 |
| `b` | var | Private |  | Integer | 36 |
| `son` | var | Private |  | Integer | 37 |
| `Lettrable` | var | Private |  | Integer | 38 |
| `Desg` | var | Public |  | String | 39 |
| `$lstex` | var | Private |  | Listextcpt | 40 |
| `Bsel` | var | Public |  | Boolean | 42 |
| `Bval` | var | Public |  | String | 43 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `convBool` | 45-56 | Public | 2 | 9 | 0 | portée réductible ? |
| `cpoint` | 58-62 | Public | 1 | 3 | 0 | portée réductible ? |
| `_New` | 64-119 | Public | 6 | 53 | 0 | méthode spéciale |
| `Let_KeyPress` | 121-161 | Public | 10 | 34 | 0 | handler GUI |
| `Let_GotFocus` | 166-172 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 174-191 | Public | 5 | 12 | 0 | handler GUI |
| `Button9_Click` | 193-206 | Public | 2 | 10 | 0 | handler GUI |
| `compteman` | 208-242 | Public | 7 | 32 | 0 | portée réductible ? |
| `Indexation` | 244-255 | Public | 4 | 10 | 0 | portée réductible ? |
| `clear` | 257-265 | Public | 1 | 7 | 0 | portée réductible ? |
| `affichage` | 267-370 | Public | 20 | 97 | 0 | portée réductible ? |
| `Colcli_Click` | 372-392 | Public | 8 | 19 | 0 | handler GUI |
| `Colcli_KeyPress` | 394-410 | Public | 7 | 14 | 0 | handler GUI |
| `Button5_Click` | 412-453 | Public | 11 | 39 | 0 | portée réductible ? |
| `Toutes_Click` | 455-460 | Public | 1 | 4 | 0 | handler GUI |
| `Enl_Click` | 462-467 | Public | 1 | 4 | 0 | handler GUI |
| `El_Click` | 469-474 | Public | 1 | 4 | 0 | handler GUI |
| `Bclient_Click` | 476-485 | Public | 1 | 8 | 0 | handler GUI |
| `Bfournisseur_Click` | 487-496 | Public | 1 | 8 | 0 | handler GUI |
| `Bbilan_Click` | 498-507 | Public | 1 | 8 | 0 | handler GUI |
| `Button7_Click` | 509-528 | Public | 4 | 13 | 0 | portée réductible ? |
| `Button1_Click` | 530-540 | Public | 2 | 9 | 0 | handler GUI |
| `Button2_Click` | 542-552 | Public | 2 | 9 | 0 | handler GUI |
| `Button3_Click` | 554-560 | Public | 1 | 5 | 0 | handler GUI |
| `Button4_Click` | 562-568 | Public | 1 | 5 | 0 | handler GUI |
| `Button8_Click` | 570-574 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tdate_Click` | 576-584 | Public | 2 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Utilitaires locaux

- **`convBool(bln As Boolean) As String`** [portée : réductible, aucun appelant externe]
  [nature : calcul]. `"1"`/`"0"`. Utilisé uniquement dans `affichage` sous la forme
  `ConvBool(x.Value) = 1` : équivaut à `x.Value`. Homonyme **de signature différente** de
  `Utils.convBool(String)` ([Utils](../../../Utils/Utils.module/architecture.md)).
- **`cpoint(mtt)`** [portée : réductible] [nature : calcul]. Copie locale de `Utils.cpoint`
  (`.` → `,`) sans `LTrim$` ni repli `"0"` sur chaîne vide. Utilisée par `Colcli_Click` ; comme le
  résultat passe ensuite par `If Val(TD) = Null Then TD = "0"`, `Utils.cpoint` donne le même effet.

### Construction et sélection du compte

- **`_New(cpte, tpc)`** [portée : nécessaire] [nature : mixte]. `Utils.Observers(Me)`, colonnes
  de `Colcli` (9 colonnes visibles ; `Item[9]` sert à stocker `lind` hors colonne), type
  `C` par défaut (`IsNull("")` est vrai en Gambas), bouton radio correspondant. SQL :
  `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 and lettrable = &2 order by cast(compte_cc AS char)`
  (`True`) → `rrResult`, liste de navigation. Si `cpte` est fourni : `compteman()`.
- **`compteman()`** [portée : réductible] [nature : mixte]. Relit le type sur les radios ;
  `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1 and type_cc = &2 and lettrable <> false`.
  Trouvé : `Label2`, `Indexation()`, `affichage()`, `b = 1`. Sinon `Music.Play` (si `son`) +
  `Message.Warning`, `b = 0`. Compte vide : `b = 1`.
- **`Indexation()`** [portée : réductible] [nature : calcul]. Positionne `rrResult` sur le compte
  saisi (parcours linéaire).
- **`Button9_Click()`** [handler, F2] : `New TriCpt(Type, TriCpt.Avec_Solde, Me)` modal ; si
  `Bsel`, recopie `Bval` puis `compteman()` et `Indexation()` (cette dernière est redondante,
  `compteman` l'appelle déjà).
- **`Bclient_Click` / `Bfournisseur_Click` / `Bbilan_Click`** [handlers] : `clear()`, vide la liste
  et le compte, fixe `type` et **réexécute la même requête** que `_New` (trois copies).
- **`Button1_Click` / `Button2_Click` / `Button3_Click` / `Button4_Click`** [handlers] :
  précédent / suivant / dernier / premier, via le drapeau texte `Compt` (`"1"`…`"4"`, `"0"`)
  interprété par `affichage`.

### Affichage

- **`affichage()`** (CC 20, max du fichier) [portée : réductible] [nature : mixte].
  1. Navigation dans `rrResult` selon `Compt` (5 blocs quasi identiques). ⚠️ `Compt = "0"` ou
     `"4"` sur une liste vide : `MoveFirst`/`MoveLast` puis lecture de `rrResult!compte_cc` → erreur.
  2. `SELECT * FROM Fiches_Parametres` (nom en dur, sans test `Available`) → `dteclec` → bornes
     `LDate.EDeb` / `LDate.EFin` de l'exercice suivant.
  3. Sort si le compte est vide ; sinon `New Listextcpt(cpt, dtei.L, dtes.L, "n"|"o"|"t", odr)`
     selon les radios `Enl`/`El`/`Toutes` (via `ConvBool`), tri `dte ASC|DESC` selon `Tdate`.
  4. Remplit `Colcli` (clé `lind & numero`), marque `L` si `lettree`, cumule débit/crédit
     (`Format$` puis `Val(Utils.cpoint(...))`) et affiche le solde dans `Sld`.
  Les variables locales `Tab`/`Tab2` sont affectées sans être lues (`Tab2` est un membre).
- **`clear()`** [portée : réductible] [nature : GUI]. Remet `totselection` à `"0,00"`, vide
  `numlot`, remet `TT`/`TD`/`TC` à 0 (`TD`/`TC` sont des `String` affectées avec un entier).
- **`Toutes_Click` / `Enl_Click` / `El_Click`** [handlers] : `clear()` + `affichage()`.
- **`Tdate_Click()`** [handler] : `Colcli.Sorted = Not Tdate.Value` puis `affichage`.

### Sélection et lettrage

- **`Colcli_Click()`** [handler] [nature : mixte]. Bascule la marque de la ligne (`L` ou `""` →
  `*`, sinon `""`), ajoute ou retranche `débit − crédit` à `TT` et affiche le total dans
  `Totselection` (`"0,00"` forcé si nul). Recopie le lot de la ligne dans `numlot`.
- **`Colcli_KeyPress()`** [handler] : Espace = `Colcli_Click` ; Haut/Bas déplacent la ligne
  courante à la main (à confirmer : double déplacement possible avec la gestion native du clavier).
- **`Button5_Click()`** (CC 11) [handler via `Btn_Click` tag 3] [nature : mixte] — **Lettrer**.
  1. `Randomize`, lot = `Rnd(1000000, 9999999)` si `numlot` est vide.
  2. ⚠️ **Délettre d'abord** toutes les lignes cochées : `$lstex.letcpt(lind, False, lot, "lettrage")`.
  3. Si `Totselection.Text <> "0,00"` : avertissement « Lettrage impossible », rafraîchissement.
     Les lignes cochées restent **délettrées en base** avec le nouveau lot (anomalie A01). La
     comparaison sur le texte `"0,00"` dépend de la locale (A05).
  4. Sinon `letcpt(lind, True, lot, "lettrage")` sur chaque ligne cochée, puis rafraîchissement.
  `Lettrable` n'est jamais affecté (toujours 0) : la ligne 439 est morte ; `num` et `Tab` sont inutilisés.
- **`Button7_Click()`** [handler via `Btn_Click` tag 2] — **Délettrer** : `letcpt(lind, False,
  numlot.Text, "lettrage")` ; le lot n'est pas vidé, il prend la valeur de `numlot` (lot de la
  dernière ligne cliquée).

### Divers

- **`Let_KeyPress()`** [handler, groupe `Let`] : Entrée/Tab sur `cpt` (tag 1) → `compteman` puis
  focus `numlot` ; sur `numlot` (tag 2) → retour à `cpt` ; F1 aide ; F2 sur `cpt` → `TriCpt`.
- **`Let_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 délettrer, 3 lettrer, 4 fermer.
- **`Button8_Click()`** : `Doc.Open("Lettrage")`.

Les SQL émis par `Listextcpt` (UNION sur `Fiches_Mvt…Mvt5`, UPDATE `numlot`/`lettree` par `lind`)
sont décrits dans sa propre documentation. `letcpt` ne recalcule pas le SHA1 des écritures, à la
différence de `Lettragemontant`/`Lettragesoldes` ; le SHA1 ne couvre ni `numlot` ni `lettree`
(voir [Sha1Calc](../../../Utils/Sha1Calc.module/architecture.md)).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Cdate_Aff`, `Utils.cpoint`.
- `Start.Son`, `Start.Musique` ; `Music` (son d'erreur).
- Tables : `Fiches_Comptes`, `Fiches_Parametres` (en dur), `Fiches_Mvt…Mvt5` (via `Listextcpt`).
- Membres `Public` `Bsel`/`Bval` écrits par `TriCpt` (`Object.SetProperty`) ; `Desg` inutilisé.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le drapeau texte `Compt` par une fonction `Naviguer(iSens)` et les trois blocs
  `New Listextcpt` par un calcul du filtre `"n"|"o"|"t"` : `affichage` passe de CC 20 à moins de 8.
- Fonction unique `ChargeComptes()` pour la requête répétée dans `_New` et les trois radios.
- `Button5_Click` / `Button7_Click` : collecter d'abord la liste des `lind` cochés (partie GUI),
  puis appeler `Lettrer(aLind, bValeur, sLot)` (partie traitement).

### Commonalisation avec d'autres fichiers

- `cpoint` local → [`Utils.cpoint`](../../../Utils/Utils.module/architecture.md) (même effet ici) ;
  six copies locales recensées (Cpostaux, Marques, Lettrage, FTvac, FComptes, ArchivesTck).
- `convBool(Boolean)` local : supprimé plutôt que fusionné, `Utils.convBool` ayant un paramètre `String`.
- La navigation premier/précédent/suivant/dernier sur un `Result` de comptes existe aussi dans
  [Extrait](../../Extrait.class/architecture.md) (à vérifier en phase 3).
- Le lettrage par lot est aussi écrit par [Lettragemontant](../Lettragemontant.class/architecture.md),
  [Lettragesoldes](../Lettragesoldes.class/architecture.md) et `TresorFac.Lettrage` sans passer
  par `Listextcpt.letcpt` : une API unique de lettrage (avec règle de numérotation des lots)
  serait à créer en phase 3.

### Réduction de portée

`convBool`, `cpoint` (supprimés), `compteman`, `Indexation`, `clear`, `affichage` → `Private`
(aucun appelant externe : `grep -rn "Lettrage\."` ne trouve que des appels à `Show`/`New`).
`Bsel`/`Bval` restent `Public` (`TriCpt` les écrit par `Object.SetProperty`). `Desg` est supprimé.

### Séparation traitement / GUI

- `Lettrer(aLind As String[], bValeur As Boolean, sLot As String)` : boucle `letcpt`.
- `TotalSelection(fTotal, sDebit, sCredit, bCoche) As Float` : calcul de `Colcli_Click`, testable en gb.test.
- `BornesLettrage() As LDate[]` : lecture de `dteclec` et calcul des bornes.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Séquence ou table de compteurs pour les numéros de lot de lettrage (aujourd'hui aléatoires, sans
  contrôle d'unicité, `numlot char(10)`).
- Colonne `lettrable` en `tinyint` comparée tantôt à `True`, tantôt à `false` : un type booléen
  homogène simplifierait les requêtes.
