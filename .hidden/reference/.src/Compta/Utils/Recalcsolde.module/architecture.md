# Recalcsolde — Architecture

> Source : `.src/Compta/Utils/Recalcsolde.module`

## Vue d'ensemble

Module de **recalcul du solde de tous les comptes** à partir des écritures validées de l'exercice
en cours. C'est une **copie quasi identique** de [`Csolde.Recalc_solde`](../../../Utils/Csolde.module/architecture.md)
(même requêtes, même boucle, mêmes variables de module), sans le découpage en `Solde_caisse`. Une
3ᵉ variante existe dans [`Calcsolde.Calcul`](../../../Utils/Calcsolde.class/architecture.md).

**Aucun appelant** : grep `Recalcsolde` ne trouve que le fichier lui-même (ni `Prgm`, ni menu, ni
appel dynamique par chaîne). Le module est **mort**.

Nature : **calcul + SQL**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotSldHP` | var | Private | oui | Float | 3 |
| `TotDeb` | var | Private | oui | Float | 4 |
| `TotCred` | var | Private | oui | Float | 5 |
| `TotSld` | var | Private | oui | Float | 6 |
| `debit` | var | Private | oui | Float | 7 |
| `credit` | var | Private | oui | Float | 8 |
<!-- /AUTO:declarations -->

Variables de module privées utilisées comme accumulateurs (`TotDeb`, `TotCred`, `TotSld`, `debit`,
`credit`) ; `TotSldHP` est mise à 0 et jamais lue.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Calc` | 13-57 | Public | 5 | 42 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Calc()`** (CC 5) [portée : réductible — aucun appelant] [nature : calcul + SQL]. Déclarée
  `Function` sans type de retour (ne renvoie rien).
  - `SELECT * FROM Fiches_Comptes ORDER BY cast(compte_cc AS char)` ;
  - pour chaque compte : `SELECT * FROM Fiches_Mvt WHERE compte = &1 AND validee = &2 ORDER BY dte`
    (`validee = 1`), cumul `montantd − montantc` dans un `While i < Count` + `MoveNext` ;
  - `UPdate Fiches_Comptes SET solde = Utils.PointBase(TotSld) WHERE compte_cc = &1` (deux branches
    identiques selon qu'il y a des écritures ou non, la seconde avec `TotSld = 0`) ;
  - `Intit` lue mais inutilisée ; branche `Else` vide ; bloc `With Utils` pour le seul
    `.PointBase`.
  - Cumul en `Float` (risque d'arrondi sur beaucoup de lignes, comme `Csolde`).

Différences avec `Csolde.Recalc_solde` + `Solde_caisse` (diff ligne à ligne) : uniquement la
structure (une seule fonction au lieu de deux) et la variable `Intit` ; requêtes et calcul
identiques.

## État global utilisé

- `Utils.db`, `Utils.PointBase`.
- Tables en dur : `Fiches_Comptes` (lecture, `UPDATE solde`), `Fiches_Mvt` (lecture).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : le module est à supprimer.

### Commonalisation avec d'autres fichiers

- Implémentation unique du recalcul de solde dans [`Csolde`](../../../Utils/Csolde.module/architecture.md)
  (rework CSOLDE-004) ; `Recalcsolde` est supprimé plutôt que redirigé, faute d'appelant.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet (pas d'IHM).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `Csolde` : un solde calculé par `SELECT compte, SUM(montantd − montantc) … GROUP BY compte`
  en une seule requête ne demande pas de changement de schéma (rework de `Csolde`) ; un solde
  maintenu par déclencheur en demanderait un.
