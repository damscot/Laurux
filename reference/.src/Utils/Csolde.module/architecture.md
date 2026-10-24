# Csolde — Architecture

> Source : `.src/Utils/Csolde.module`

## Vue d'ensemble

Recalcul du **solde comptable** d'un compte (`Solde_caisse`) ou de tous les comptes
(`Recalc_solde`) à partir des écritures validées de `Fiches_Mvt`, puis mise à jour de
`Fiches_Comptes.solde`. Appelé après le moulinage de caisse, l'édition des bordereaux, l'épuration
des journaux et la modification de montants.

Nature : **traitement SQL** (aucune GUI).

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
| `Compt` | var | Private | oui | String | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Recalc_solde` | 11-28 | Public | 3 | 15 | 2 |  |
| `Solde_caisse` | 30-63 | Public | 3 | 31 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Recalc_solde()`** [portée : nécessaire] [nature : calcul/SQL]. `SELECT * FROM Fiches_Comptes
  ORDER BY cast(compte_cc AS char)` puis `Solde_caisse(compte)` pour chaque compte : **N+1 requêtes**
  et N `UPDATE` (une requête par compte du plan comptable). Écrit la variable de module `Compt`.
  Appelants : `Epurjdv:189`, `Fmontant:206` (l'appel de `Moulinage:1442` est commenté).
- **`Solde_caisse(Compt As String)`** [portée : nécessaire] [nature : calcul/SQL]. `SELECT * FROM
  Fiches_Mvt WHERE compte = &1 AND validee = &2 ORDER BY dte` (avec `1`), cumule `montantd` et
  `montantc` dans des **variables de module** `Float` (`totdeb`, `totcred`, `totsld`, `debit`,
  `credit`), puis `UPdate Fiches_Comptes SET solde = &2 WHERE compte_cc = &1` avec
  `Utils.PointBase(Totsld)` (conversion implicite Float → String). Aucune écriture : solde 0.
  Remet les totaux à 0 en fin d'appel. Appelants : `Moulinage:939-941,1353,1403`,
  `BordereauxC:332,362,372`.
  Remarques : noms de tables **en dur** (`Fiches_Mvt`, `Fiches_Comptes`) au lieu de `Cbase.Table`
  (`TabMvt`, `TabComptes`) ; seules les écritures de `Fiches_Mvt` sont prises en compte (pas
  `Mvt1`-`Mvt5`, à confirmer selon le rôle de ces tables) ; `SELECT *` ramène toutes les colonnes
  pour en sommer deux ; boucle `While i < Count` au lieu de l'idiome `Repeat … Until MoveNext()` ;
  `With Utils` utilisé uniquement pour `.PointBase` ; `totsldhp` est remis à 0 mais jamais utilisé.
  Un `montantd`/`montantc` `NULL` est converti en 0 par l'affectation `Float` (à confirmer). Les
  sommes en `Float` peuvent différer au centime près d'un `SUM()` SQL sur `decimal(12,2)`.

## État global utilisé

- Variables de module (privées) : `TotSldHP`, `TotDeb`, `TotCred`, `TotSld`, `debit`, `credit`,
  `Compt` : état partagé entre appels, sans nécessité (toutes pourraient être locales).
- `Utils.db`, `Utils.PointBase`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Variables locales au lieu de variables de module ; suppression de `TotSldHP`.
- `Solde_caisse` : `SELECT montantd, montantc` (même cumul Float, même ordre) ; idiome
  `Repeat … Until MoveNext()`.
- `Cbase.Table("TabMvt")`/`Cbase.Table("TabComptes")` au lieu des noms en dur (mêmes tables).

### Commonalisation avec d'autres fichiers

Le même calcul existe **trois fois** :
- `Csolde.Solde_caisse` / `Recalc_solde` (ce module, cumul `Float` en Gambas) ;
- [Recalcsolde.Calc](../../Compta/Utils/Recalcsolde.module/architecture.md) : copie quasi identique
  de `Recalc_solde` + `Solde_caisse` (mêmes requêtes, mêmes variables), sans appelant trouvé par grep
  (à confirmer dans son propre document) ;
- [Calcsolde.Calcul](../Calcsolde.class/architecture.md) : version `SUM(montantd) - SUM(montantc)` en
  SQL, avec en plus le solde pointé (`soldep`) et le formatage `LPrix(…).D`.

Candidat phase 3 : une seule implémentation (celle de `Calcsolde.Calcul`, plus efficace), à condition
que les tests montrent des soldes identiques au centime ; sinon, garder le cumul `Float` pour
préserver le comportement.

### Réduction de portée

- Les deux fonctions ont des appelants externes. Les variables sont déjà privées (déclarées sans
  `Public`).

### Séparation traitement / GUI

- Sans objet (aucune GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Comptes.solde` est un `double` alors que les montants sont en `decimal(12,2)` : un
  `decimal` éviterait les écarts d'arrondi.
- Un index `(compte, validee)` sur `Fiches_Mvt` (et variantes) accélérerait `Solde_caisse` (à vérifier
  dans `db_control.csv`).
- Le solde dérivé pourrait être calculé à la volée (vue) plutôt que stocké.
