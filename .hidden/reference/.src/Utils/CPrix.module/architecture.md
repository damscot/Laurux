# CPrix — Architecture

> Source : `.src/Utils/CPrix.module`

## Vue d'ensemble

Deux helpers de prix antérieurs à l'objet [LPrix](../LPrix.class/architecture.md) : application d'une
remise en cascade sur un prix d'achat (`Cascade`) et lecture du taux de TVA de vente d'un code TVA
(`CTva`). Utilisés par les écrans de tarifs et d'articles et par la facturation.

Nature : **calcul** (`Cascade`) et **SQL** (`CTva`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Cascade` | 3-11 | Public | 3 | 6 | 3 |  |
| `CTva` | 13-24 | Public | 2 | 9 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Cascade(PaHT As String, Rem As String) As String`** [portée : nécessaire] [nature : calcul].
  `Pa = PaHT − PaHT × Rem / 100`, avec `Val(Utils.cpoint(…))` (lecture localisée, virgule) ; le
  résultat `Float` est converti implicitement en `String` dans `Pa` (séparateur à confirmer : la
  conversion implicite n'est pas localisée). Erreur → `"0"`. Appelants : `Impart:1442-1444`,
  `MajTarifM:372-374,1097,1107,1118`, `Articles:1983-1985,2030,2040,2051`, toujours sous la forme
  `Format$(CPrix.Cascade(paht, remiseN), nbdec)` pour les remises 2, 3 et 4.
- **`CTva(Tva As String) As String`** [portée : nécessaire] [nature : SQL]. `SELECT * FROM
  Cbase.Table("TabTvav") WHERE code_tva = &1` → `taux_tva` (`Fiches_Tvaav`, `varchar(5)`), `""` si
  le code est inconnu. Appelants : `Facture:7606` (`Recup_Tva`), `MajTarifM:985,988`,
  `Articles:4607`, `ConsultArt:447`.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cascade` : déclarer `Pa As Float` et renvoyer `CStr(Pa)` explicitement (même chaîne qu'aujourd'hui,
  conversion rendue visible).
- `CTva` : `SELECT taux_tva` au lieu de `SELECT *`.

### Commonalisation avec d'autres fichiers

- La remise en cascade est aussi calculée en ligne dans `Impart:1438` (première remise, même formule)
  et par [LTaxe](../LTaxe.class/architecture.md) (type `Remise`) via `LPrix` : à terme, les écrans de
  tarifs devraient utiliser `LPrix`/`LTaxe`.
- Lecture du taux de TVA : nombreux `SELECT … FROM TabTvav WHERE code_tva` dans les écrans de
  facturation et de caisse (à recenser en phase 3) ; `CTva` est le candidat naturel.

### Réduction de portée

- Sans objet (les deux fonctions ont des appelants externes).

### Séparation traitement / GUI

- Déjà sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `taux_tva` en `varchar(5)` : un type `DECIMAL(5,2)` éviterait les conversions chaîne ↔ nombre.
