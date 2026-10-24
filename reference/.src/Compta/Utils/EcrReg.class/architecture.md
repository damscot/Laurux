# EcrReg — Architecture

> Source : `.src/Compta/Utils/EcrReg.class`

## Vue d'ensemble

`EcrReg` **hérite d'[`EcrAuto`](../EcrAuto.class/architecture.md)** et prépare les **écritures de
règlement** : à partir d'un mode de règlement (`Fiches_Reglements.code`), d'un journal et d'un
[`VarEcr`](../VarEcr.class/architecture.md), il complète ou transforme les lignes (contrepartie
banque/caisse, montants inversés, états) avant que l'appelant n'appelle `ecriture()` (héritée).

Construction : `New EcrReg(nreg, njo, var)` — `nreg` va à `EcrReg._new`, `njo` et `var` au
constructeur hérité `EcrAuto._new` (exécuté en premier, il charge `resjou` et `Vecr`). `_new`
lit le mode de règlement (`Error.Raise` s'il n'existe pas) puis appelle `reglement`.

Appelants : `SaiReg` (saisie et validation de bordereaux de règlement, `Gestion/Facturation`) et
`Moulinage` (règlements de caisse, `L_caisse`).

Nature globale : **traitement** (préparation de lignes, deux lectures SQL).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$resreg` | var | Private |  | Result | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-16 | Public | 2 | 7 | 0 | méthode spéciale |
| `_call` | 18-25 | Public | 1 | 5 | 0 | méthode spéciale |
| `reglement` | 27-155 | Private | 18 | 120 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(nreg)`** [spéciale] [traitement]. `SELECT * FROM Fiches_Reglements WHERE code=&1` ;
  `Error.Raise("Réglement innexistant …")` si absent ; `reglement`.
- **`_call(nreg, njo, var) As EcrReg`** [Public, **aucun appelant**] [calcul] — **code mort** avec le
  `Create Static` qui le rend possible : les appelants utilisent `New EcrReg(…)` (vérifié par grep ;
  `deps.py` compte à tort ces `New` comme des `_call`).
- **`reglement()`** [Private] [traitement] (CC 18). Force `Vecr.type = Treso`, puis selon
  `Vecr.etat` :
  - **`L_ajou`** : ajoute la racine comme ligne (`Vecr.plus(Vecr)`) et une contrepartie sur le compte
    intermédiaire du règlement (`cptint`) ou, à défaut, la banque du journal (`resjou!cde_banque`),
    montants inversés, mêmes date/document/lot/libellé ;
  - **`L_modif`** : pour chaque ligne existante, `SELECT * FROM Fiches_Comptes WHERE compte_cc=&1`
    (**sans `Available`**) ; montants recopiés de la racine pour les comptes collectifs, clients ou
    fournisseurs, inversés sinon ; recopie document, numéro, lot, état, libellé, type, intitulé (50
    car.), date ; puis ajoute la racine comme ligne ;
  - **`L_valide`** (validation de bordereau) : remplace le compte des lignes par `cptint` s'il existe,
    cumule le solde et ajoute une ligne de banque (`cde_banque`) pour le total, intitulé
    « <libellé règlement> du <date> », libellé = intitulé du compte de banque (`Fiches_Comptes`,
    sans `Available`) ;
  - **`L_sup`** : passe toutes les lignes en `L_sup` et ajoute la racine ;
  - **`L_caisse`** : ajoute la racine, remplace le compte de chaque ligne par `cptint` ou la banque
    du journal, cumule, et ajoute une ligne `L_caisse` sur le compte d'origine pour le total arrondi
    à 2 décimales (`Round(tot, -2)`).
  Les appels `Vecr.modifi(Vecr.trouve(var), var)` sont sans effet (même objet). Dans `L_sup`, la
  racine est ajoutée **après** la boucle et garde son état d'origine (`L_sup`, posé par l'appelant).

## État global utilisé

- `Utils.db.Exec` ; membres hérités `Vecr`, `resjou`.
- Tables en dur : `Fiches_Reglements`, `Fiches_Comptes`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_call` et `Create Static` (inutilisés).
- Supprimer les `trouve`/`modifi` sans effet (objets modifiés en place) : comportement identique.
- Un helper `Contrepartie(compte, montantd, montantc)` pour les lignes de banque/caisse créées dans
  `L_ajou`, `L_valide`, `L_caisse`.
- Découper `reglement` en une fonction privée par état (CC 18 → ≤ 6 chacune).

### Commonalisation avec d'autres fichiers

- La détermination du compte de contrepartie (`cptint` sinon banque du journal) est à rapprocher
  de `SaiReg` et `Moulinage` (Gestion/Caisse) qui préparent les mêmes lignes.
- Lecture du compte (`Fiches_Comptes WHERE compte_cc`) répétée dans `EcrAuto.ajout` : fonction
  commune de lecture de compte (phase 3).

### Réduction de portée

- `_call` : suppression (pas de réduction possible pour une méthode spéciale).

### Séparation traitement / GUI

- Sans objet (aucune GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier.
