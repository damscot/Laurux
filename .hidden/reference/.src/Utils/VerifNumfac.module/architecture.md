# VerifNumfac — Architecture

> Source : `.src/Utils/VerifNumfac.module`

## Vue d'ensemble

Module de **recherche du prochain numéro de facture libre** : à partir d'un numéro `Nfac`, il
incrémente un numéro à 6 chiffres jusqu'à trouver une valeur absente des factures historisées
(`Fiches_HistoFac`) et des BL facturés (`Fiches_Bl`), et, si l'option Matériel est active, des tables
`Fiches_HistoFacM`/`Fiches_BlM`.

**Code mort** : `Dnfac` n'a **aucun appelant** (les occurrences de `dnfac` dans `Parametre.class`
désignent un contrôle et la colonne `Fiches_Parametres.dnfac`, pas ce module).

Nature : **calcul (SQL)**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Dnfac` | 3-93 | Public | 26 | 86 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Dnfac(Nfac As String) As String`** [portée : réductible — aucun appelant] [nature : calcul].
  1. Si `Start.LocalSettings["/Soc<XX>/Materiel"]` : lit le plus grand `numfac` de `Fiches_HistoFacM`
     et `Fiches_BlM` (`ORDER BY numfac DESC`, toute la table) → `N5` (**jamais utilisé**), puis teste
     l'existence de `Nfac` → `b3facture` (**jamais utilisé**).
  2. Même chose sur `Fiches_HistoFac`/`Fiches_Bl` → `N4` (borne) et `bfacture` (**jamais utilisé**).
  3. Boucle : `N3 = Format$(Val(N3) + 1, "000000")`, teste `right(numfac,6) = N3` dans `HistoFac`
     et `Bl` (et, en mode Matériel, `HistoFacM`/`BlM` qui **écrasent** `b1facture`/`b2facture` au lieu
     de les combiner) ; sort au premier numéro libre ou quand `N3 ≥ N4 + 1`.
  4. Renvoie `N3` (6 chiffres, sans préfixe année/mois).
  Tables en dur ; `right()` traduit pour SQLite par `DB_Connection`. Jusqu'à 4 requêtes par
  itération, avec `right(numfac,6)` qui empêche l'usage d'un index.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/Materiel"]`, `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet si le module est supprimé. À défaut : supprimer `N5`, `bfacture`, `b3facture` et les 4
  requêtes associées ; combiner les booléens (anomalie A01).

### Commonalisation avec d'autres fichiers

- La numérotation réelle des factures est gérée ailleurs (`Fiches_Parametres.dnfac`, `Parametre`,
  `Facture`) : à rapprocher lors de la documentation de `Gestion/Facturation`.

### Réduction de portée

- Sans objet (suppression proposée).

### Séparation traitement / GUI

- Sans objet (aucun contrôle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un numéro de facture numérique séparé (ou une colonne générée `right(numfac,6)` indexée) rendrait
  ces recherches en O(log n).
