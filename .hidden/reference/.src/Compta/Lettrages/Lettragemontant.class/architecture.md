# Lettragemontant — Architecture

> Source : `.src/Compta/Lettrages/Lettragemontant.class`

## Vue d'ensemble

Traitement de masse « **lettrage par le montant** » lancé depuis `Fmenu.Menu126_Click`. Pour chaque
compte client (`C`) ou fournisseur (`F`) de `Fiches_Comptes`, il cherche dans `Fiches_Mvt` les
écritures validées non lettrées qui portent le même montant que la première écriture non lettrée du
compte ; si leur total débit − crédit est nul, il les lettre avec un lot `"M" & Right$(lot, 9)` et
recalcule le SHA1 de chaque écriture. Un message final donne le nombre de lignes lettrées.

Le texte du formulaire prévient que le traitement « n'a pas de contrôle sur le numéro de lot ».
Aucune confirmation, aucune transaction.

Nature : **mixte**, tout le traitement est dans `Button2_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TT` | var | Private |  | Float | 28 |
| `TD` | var | Private |  | String | 29 |
| `TC` | var | Private |  | String | 30 |
| `type` | var | Private |  | String | 31 |
| `Tab2` | var | Private |  | String | 32 |
| `son` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-42 | Public | 1 | 5 | 0 | méthode spéciale |
| `Btn_Click` | 44-58 | Public | 4 | 10 | 0 | handler GUI |
| `clear` | 60-66 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 68-146 | Public | 16 | 75 | 0 | portée réductible ? |
| `Button1_Click` | 148-152 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers(Me)`, chargement du son, centrage.
- **`Btn_Click()`** [handler, groupe `Btn`] : tag 1 aide, 2 lancement, 3 fermeture.
- **`clear()`** [portée : réductible, **code mort**] : remet à zéro `TT`/`TD`/`TC`, jamais appelée ;
  les trois membres ne servent nulle part ailleurs.
- **`Button2_Click()`** (CC 16) [handler via `Btn_Click` tag 2] [nature : mixte, partie extractible :
  tout sauf curseur, son et message].
  1. `type` = `C` si `Bclient`, sinon `F`.
  2. `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 order by cast(compte_cc AS char)`.
  3. Pour chaque compte, **deux passes** (`For i = 1 To 2`, même requête) :
     - `SELECT * FROM Fiches_Mvt WHERE compte = &1 and lettree = &2 and validee = &3 order by compte, numlot`
       (0, 1) : seule la **première ligne** est utilisée (`num` = son lot) ;
     - montant de référence `Mnt` = `montantd` (clients) ou `montantc` (fournisseurs), si la valeur
       n'est pas `""` (donc aussi quand elle vaut 0) ;
     - `SELECT … WHERE compte = &1 and montantd = &2 and lettree = &3 and validee = &4 or compte = &1
       and montantc = &2 and …` → somme débit et crédit (`EcrResult`) ;
     - si `Totd − Totc = 0` (égalité stricte sur Float) : relit la même sélection, puis **pour chaque
       ligne** exécute le même `UPdate Fiches_Mvt SET numlot = &1, lettree = &2 WHERE <même filtre>`
       (la première exécution lettre tout, les suivantes ne trouvent plus rien) et
       `Sha1Calc.CalcSha1("Fiches_Mvt", numero)` ; `B` compte les lignes.
  4. Message « Traitement terminé ! n écriture(s) lettrée(s) ».

  Particularités (voir anomalies) : si le montant de référence est 0 (première ligne au crédit pour
  un client), le filtre `montantd = 0 or montantc = 0` couvre presque toutes les lignes du compte ;
  si le test `<> ""` échoue, `EcrResult` garde la valeur de l'itération précédente (ou `Null` au
  premier compte, d'où une erreur) ; le lot `"M" & Right$(num, 9)` vaut `"M"` quand la première
  ligne n'a pas de lot. Variables mortes : `Deb`/`cred` (intermédiaires), `TotE` remis à 0, `Tab2`
  membre utilisé comme locale.
- **`Button1_Click()`** [handler via tag 1] : `Doc.Open("Lettragem")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Sha1Calc.CalcSha1`, `Doc.Open`.
- `Start.Son`, `Start.Musique`.
- Tables en dur : `Fiches_Comptes`, `Fiches_Mvt` (exercice courant uniquement ; `Fiches_Mvt1…5`
  ne sont pas traitées).

## Propositions d'amélioration

### Réécriture / refactorisation

- Une seule fonction privée `EcrituresMontant(sCompte, fMnt) As Result` pour la requête écrite
  trois fois (l. 104, 108, 120).
- Exécuter l'UPDATE une seule fois par groupe, puis `CalcSha1` une fois par `numero` distinct :
  **SQL modifié, dump identique** (les UPDATE répétés ne modifient aucune ligne ; `CalcSha1` est
  idempotent sur une écriture inchangée). `B` doit garder le nombre de lignes du groupe.

### Commonalisation avec d'autres fichiers

- [Lettragesoldes](../Lettragesoldes.class/architecture.md) a la même structure (formulaire,
  `_New`, `Btn_Click`, `clear`, boucle sur les comptes d'un type, UPDATE répété + SHA1) : un module
  commun `Lettrages` (boucle comptes, application d'un lot, message) éviterait la duplication.
- Le lettrage par lot existe aussi dans [Listextcpt.letcpt / letgroupe](../../Utils/Listextcpt.class/architecture.md)
  et [Lettrage](../Lettrage.class/architecture.md) : à unifier en phase 3 (règle des lots,
  tables `Mvt1-5`, SHA1).

### Réduction de portée

`clear` est supprimée (code mort). Les handlers restent `Public`.

### Séparation traitement / GUI

`LettrerParMontant(sType As String) As Integer` (SQL + calcul, renvoie `B`), appelée par
`Button2_Click` qui garde curseur, son et message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(compte, lettree, validee)` sur `Fiches_Mvt` pour les deux requêtes par compte.
- Compteur de lots de lettrage (voir Lettrage) pour éviter le lot commun `"M"`.
