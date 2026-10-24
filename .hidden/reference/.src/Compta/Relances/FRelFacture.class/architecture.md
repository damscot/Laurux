# FRelFacture — Architecture

> Source : `.src/Compta/Relances/FRelFacture.class`

## Vue d'ensemble

`FRelFacture` édite des **relevés de factures** clients ou fournisseurs sur une période (menu
Comptabilité › Relevés › De facture, `Fmenu.Menu52_Click`). C'est le **jumeau** de
[`FRelCompte`](../FRelCompte.class/architecture.md) (même `.form` à deux contrôles près, même
structure de code) avec trois différences :

1. sélection des écritures **non lettrées, hors trésorerie**, et seulement celles d'un journal de
   ventes (`type_jo = "VE"`, clients, si `cli_rlvf`) ou d'achats (`type_jo = "AC"`, fournisseurs) ;
2. table de travail `Fiches_RelFacture` (clé `(compte, numdoc, numero)`, sans `pays` ni `lind`) ;
3. le PDF (`~/tmp/RelFac.pdf`) se termine par le solde **en toutes lettres**
   (« Arrêté le présent relevé à la somme de … », `Numtostring.Convertir`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `dte1` | var | Private |  | String | 30 |
| `dte2` | var | Private |  | String | 31 |
| `Txt` | var | Private |  | String | 32 |
| `devises` | var | Private |  | String | 33 |
| `Enr` | var | Private |  | Integer | 34 |
| `son` | var | Private |  | Integer | 35 |
| `PosY` | var | Private |  | Integer | 36 |
| `Coulfond` | var | Private |  | New String[] | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 39-76 | Public | 3 | 34 | 0 | méthode spéciale |
| `MajTab` | 78-177 | Public | 15 | 97 | 0 | portée réductible ? |
| `dte_KeyPress` | 179-212 | Public | 11 | 29 | 0 | handler GUI |
| `Btn_Click` | 214-230 | Public | 6 | 11 | 0 | handler GUI |
| `dteN0_GotFocus` | 232-238 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 240-254 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 256-260 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 262-280 | Public | 4 | 17 | 0 | portée réductible ? |
| `Compdate` | 282-292 | Public | 3 | 9 | 0 | portée réductible ? |
| `Compdate2` | 294-305 | Public | 3 | 10 | 0 | portée réductible ? |
| `Releves` | 307-443 | Public | 24 | 133 | 0 | portée réductible ? |
| `Solde` | 445-480 | Public | 8 | 33 | 0 | portée réductible ? |
| `Button1_Click` | 482-486 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button2_Click` | 488-492 | Public | 1 | 3 | 0 | handler GUI |
| `RB1_Click` | 494-498 | Public | 1 | 3 | 0 | handler GUI |
| `RB2_Click` | 500-504 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 506-510 | Public | 1 | 3 | 0 | portée réductible ? |
| `RB3_Click` | 512-516 | Public | 1 | 3 | 0 | handler GUI |
| `RB4_Click` | 518-522 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions identiques à `FRelCompte` (`dte_KeyPress`, `Btn_Click`, `dteN0_GotFocus`,
`dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `Compdate2`, `Button1_Click`,
`Button2_Click`, `RB1_Click` … `RB4_Click`, `Button7_Click` → `Doc.Open("Relfact")`) sont décrites
dans [FRelCompte — Architecture](../FRelCompte.class/architecture.md), avec les mêmes défauts
(`Compdate` mort, contrôle de période sur `dte1` initial). Seules les différences sont détaillées ici.

- **`_New()`** [spéciale] [mixte]. Comme `FRelCompte` (dont `Coulfond` inutilisé), plus la devise :
  `SELECT * FROM  Fiches_Parametres` (en dur), `"Euro"` par défaut (et non `"Euros"` comme dans
  `FEditrel`).
- **`MajTab()`** [portée : réductible] [mixte] (CC 15). Recrée `Fiches_RelFacture` ;
  `SELECT * FROM Fiches_Mvt where left(compte,3) = &1 and dte >= &2 and dte <= &3 and tresorerie = 0
  and collectif is null and lettree = 0 order by compte` ; pour **chaque** écriture,
  `SELECT * FROM Fiches_Journaux where code_jo = &1` (sans `Available`), puis fiche tiers (sans
  `Available`) et `INSERT` : client si journal `VE` et `cli_rlvf` (sous `Try` : une écriture en
  double sur la clé `(compte, numdoc, numero)` est **silencieusement ignorée**) ; fournisseur si
  journal `AC` (sans `Try` : un doublon lève une erreur). Deux requêtes supplémentaires par
  écriture. Liste des comptes avec cumuls.
- **`Releves()`** [portée : réductible] [mixte] (CC 24). Comme `FRelCompte.Releves` (en-tête société
  sans `Available`, `Level1(…, "1")`), avec :
  - date de ligne calculée par `CStr(rResult!dte)` puis découpage `Mid$/Left$/Right$`. Essai
    `gbx3` (fuseau Europe/Paris) : `CStr(Date(2026,3,7))` donne `03/06/2026 22:00:00` (conversion
    UTC), et le découpage produit `06.03.0:00` : **date fausse (jour précédent) et année
    remplacée par l'heure** (FRELFACTURE-A01, à confirmer sur les données réelles, où `dte` vient
    d'une colonne `datetime`) ; `FRelCompte` utilise `Format$(…, "dd.mm.yyyy")` ;
  - solde = débit − crédit, signe mémorisé dans `Sens`, montant écrit par
    `Numtostring.Convertir(…, devises)` et préfixé de « - » si négatif ; ligne `Level9` ;
  - `PosY` est un membre de la classe (local dans `FRelCompte`) ; `Afflog` affectée, jamais lue ;
  - `Pays` n'est jamais lu (reste vide).
- **`Solde(Entier)`** [Public, **aucun appelant**] [calcul] — **code mort** (l'appel est commenté
  ligne 426). Recompose « euros/centimes » à partir de `Numtostring.Num2Text`, avec un appel écrit
  `numtostring.Num2Text` (ligne 464, minuscule). Voir la note sur les modules homonymes dans
  dependencies.md.

## État global utilisé

- Identique à `FRelCompte`, plus `Numtostring.Convertir` (et `Num2Text` dans le code mort).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Solde` (mort), `Afflog`, `Coulfond`, `Compdate`.
- `MajTab` : joindre `Fiches_Journaux` et la fiche tiers dans la requête principale
  (`… JOIN Fiches_Journaux ON code_jo = jour WHERE type_jo = 'VE'`) ; SQL modifié, contenu de
  `Fiches_RelFacture` identique (replay sur dump).

### Commonalisation avec d'autres fichiers

- **Base commune avec [`FRelCompte`](../FRelCompte.class/architecture.md)** (voir FRELCOMPTE-004) :
  seules diffèrent la requête de sélection, la table de travail, le libellé `Level1` et la ligne de
  solde en lettres.
- **En-tête société** : helper commun (voir [`Ligcli`](../Ligcli.class/architecture.md) LIGCLI-004).
- Montant en lettres : [`Numtostring.Convertir`](../../../Utils/Numtostring.module/architecture.md)
  est déjà la fonction commune (aussi utilisée par `ObjFac`) ; `Solde` en est une réimplémentation
  morte.
- Date de ligne : `Format$(rResult!dte, "dd.mm.yyyy")` comme `FRelCompte` (corrige A01, donc
  anomalie et non rework).

### Réduction de portée

- `MajTab`, `Compdate2`, `Releves` → `Private` ; `Solde`, `Compdate` → suppression.

### Séparation traitement / GUI

- Comme `FRelCompte` : construction de la table sans contrôle ; édition paramétrée par la liste des
  comptes.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La clé `(compte, numdoc, numero)` de la table de travail perd des écritures légitimes (deux
  lignes d'un même compte dans la même écriture) ; une clé `lind` comme dans `FRelCompte`
  conviendrait mieux.
- Index sur `Fiches_Mvt(compte, dte)` utile aux deux écrans de relevé.
