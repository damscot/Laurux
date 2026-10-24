# VarEcr — Architecture

> Source : `.src/Compta/Utils/VarEcr.class`

## Vue d'ensemble

`VarEcr` décrit une **écriture comptable en préparation** pour le moteur d'écritures automatiques
[`EcrAuto`](../EcrAuto.class/architecture.md) / [`EcrReg`](../EcrReg.class/architecture.md).
Une même classe joue **deux rôles** :

1. **une ligne** d'écriture : compte, intitulé, libellé, dates (`dte`, `dtee` saisie, `dteech`
   échéance, toutes `LDate`), document, lot, montants débit/crédit, journal, `lind` (ligne existante
   en modification), `etat` (`L_*`), `type` (`Autre`, `Treso`, `Vente`, `Caisse`), `collectif`,
   `divers` (objet libre : code client pour une vente) et la table de lettrage `Tlettrage` ;
2. **un conteneur** de lignes : tableau privé `$Vecr As VarEcr[]`, énumérable (`For Each`),
   indexable en lecture (`_get`), avec `plus`, `moins`, `trouve`, `reccomp`, `modifi`, `somme`, `nb`,
   `Max`. L'objet racine porte les valeurs communes (date, journal, état, type) et peut s'ajouter
   lui-même comme ligne (`Vecr.plus(Vecr)` dans `EcrReg`, `ValidBR1`).

Chaque instance alloue un tableau `$Vecr`, un tableau `Tlettrage` et une structure `Tbl`, même
quand elle ne sert que de ligne.

Énumérations :
- `etat` : `L_sans` (0), `L_valide` (1), `L_ajou` (2), `L_modif` (3), `L_sup` (4), `L_caisse` (5) ;
- `type` : `Autre` (0), `Treso` (1), `Vente` (2), `Caisse` (3).
Les deux énumérations partagent les mêmes valeurs entières : `ObjFac.class:990-991` affecte
`type = L_ajou` et `etat = Vente` (inversés) sans effet, car `L_ajou = Vente = 2`.

Nature globale : **calcul pur** (aucun SQL, aucune GUI).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `L_sans` | enum | Public | oui |  | 3 |
| `L_valide` | enum | Public | oui |  | 3 |
| `L_ajou` | enum | Public | oui |  | 3 |
| `L_modif` | enum | Public | oui |  | 3 |
| `L_sup` | enum | Public | oui |  | 3 |
| `L_caisse` | enum | Public | oui |  | 3 |
| `Autre` | enum | Public | oui |  | 4 |
| `Treso` | enum | Public | oui |  | 4 |
| `Vente` | enum | Public | oui |  | 4 |
| `Caisse` | enum | Public | oui |  | 4 |
| `compte` | var | Private |  | String | 7 |
| `dte` | var | Private |  | LDate | 8 |
| `numlot` | var | Private |  | String | 9 |
| `numdoc` | var | Private |  | String | 10 |
| `montantd` | var | Private |  | Float | 11 |
| `montantc` | var | Private |  | Float | 12 |
| `lind` | var | Private |  | Integer | 13 |
| `numero` | var | Public |  | String | 16 |
| `lind` | var | Public |  | Integer | 17 |
| `dte` | var | Public |  | LDate | 18 |
| `dtee` | var | Public |  | LDate | 19 |
| `dteech` | var | Public |  | LDate | 20 |
| `journal` | var | Public |  | String | 21 |
| `compte` | var | Public |  | String | 22 |
| `intitul` | var | Public |  | String | 23 |
| `libelle` | var | Public |  | String | 24 |
| `numdoc` | var | Public |  | String | 25 |
| `numlot` | var | Public |  | String | 26 |
| `montantd` | var | Public |  | Float | 27 |
| `montantc` | var | Public |  | Float | 28 |
| `type` | var | Public |  | Integer | 29 |
| `etat` | var | Public |  | Integer | 30 |
| `collectif` | var | Public |  | Boolean | 31 |
| `divers` | var | Public |  | Variant | 32 |
| `Tlettrage` | var | Public |  | New TableLettrage[] | 34 |
| `Tbl` | var | Public |  | New TableLettrage | 36 |
| `$Vecr` | var | Private |  | New VarEcr[] | 38 |
| `Max` | property | Public |  | Integer | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_next` | 42-52 | Public | 3 | 9 | 0 | méthode spéciale |
| `_get` | 54-59 | Public | 2 | 4 | 0 | méthode spéciale |
| `_put` | 61-66 | Public | 2 | 4 | 0 | méthode spéciale |
| `_new` | 68-70 | Public | 1 | 2 | 0 | méthode spéciale |
| `newTbl` | 72-76 | Public | 1 | 3 | 1 |  |
| `plus` | 78-83 | Public | 1 | 4 | 5 |  |
| `moins` | 85-101 | Public | 3 | 14 | 1 |  |
| `trouve` | 103-111 | Public | 3 | 7 | 3 |  |
| `reccomp` | 113-123 | Public | 3 | 7 | 1 |  |
| `modifi` | 125-135 | Public | 3 | 9 | 2 |  |
| `somme` | 137-148 | Public | 4 | 9 | 2 |  |
| `nb` | 150-154 | Public | 1 | 3 | 3 |  |
| `Max_Read` | 156-160 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_next()`** [spéciale, `For Each`] [calcul]. Itère sur `$Vecr` via `Enum.Index` (initialisé à
  -1 si `Null`).
- **`_get(i)`** [spéciale] [calcul]. `$Vecr[i]`, ou `Null` si `i > Max` (un indice négatif lève une
  erreur). Utilisé par `SaiReg.class:1058` (`$Lecr[ret].dte = …`).
- **`_put(value, i)`** [spéciale] [calcul] — **code mort** (aucune écriture `VarEcr[i] = …` dans le
  projet ; `Moulinage.class:2547` écrit dans une `Collection`). Bornes erronées : `Resize(i)` donne
  `Max = i - 1`, l'affectation suivante sort du tableau.
- **`_new()`** [spéciale] — vide.
- **`newTbl()`** [portée : nécessaire, `SaiReg`] [calcul]. Nouvelle structure `Tbl` (ligne de
  lettrage en cours de saisie).
- **`plus(value) As Integer`** [nécessaire] [calcul]. Ajoute une ligne, renvoie son index.
- **`moins(Value) As Boolean`** [nécessaire, `SaiReg:735`] [calcul]. Supprime par index (Integer) ou
  par objet (`Find`).
- **`trouve(value) As Variant`** [nécessaire] [calcul]. Integer → la ligne ou -1 ; objet → son index.
  Type de retour variable selon l'argument.
- **`reccomp(cpt) As Integer`** [nécessaire, `ValidBR1`] [calcul]. Index de la première ligne du
  compte, -1 sinon.
- **`modifi(ind, value) As Boolean`** [nécessaire] [calcul]. Remplace la ligne `ind`. Les appels
  `modifi(trouve(var), var)` d'`EcrReg` (même objet) sont sans effet.
- **`somme() As Float`** [nécessaire, `EcrAuto`, `EdReg`] [calcul]. Σ(débit − crédit) des lignes
  non collectives et non supprimées, arrondie à 2 décimales (`Utils.arrondi`). Sert au contrôle
  d'équilibre d'`EcrAuto.ecriture`.
- **`nb() As Integer`** [nécessaire] [calcul]. Nombre de lignes.
- **`Max_Read()`** [propriété `Max`] [calcul]. `$Vecr.Max` (utilisée par `SaiReg:1057`).

## État global utilisé

- `Utils.arrondi` uniquement.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_put` (mort et faux) et `_new` vide.
- `trouve` : deux fonctions typées (`Ligne(i) As VarEcr`, `Index(v) As Integer`) seraient plus
  sûres ; changement d'API → tous les appelants (`EcrReg`, `SaiReg`, `ValidBR1`, `EdReg`) dans le
  même commit.
- À terme, séparer la ligne (`LigneEcr`) du conteneur (`VarEcr`) : réarchitecture lourde touchant
  `EcrAuto`, `EcrReg`, `SaiReg`, `ValidBR1`, `ObjFac`, `Moulinage`, `EdReg` ; à n'envisager qu'avec
  les replays de ces écrans (voir Optimisations, hors rework immédiat).

### Commonalisation avec d'autres fichiers

- `somme` réimplémente un cumul débit − crédit présent ailleurs (`Listextcpt.Controle`,
  [`Equilibrage`](../Equilibrage.class/architecture.md)) ; pas de fonction commune évidente à ce
  stade.

### Réduction de portée

- Aucune : tous les membres publics ont un appelant (vérifié par grep), sauf `_put` (à supprimer).

### Séparation traitement / GUI

- Sans objet (aucune GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe ne touche pas la base.
