# LVar — Architecture

> Source : `.src/Utils/LVar.class`

## Vue d'ensemble

`LVar` est le **moteur de libellés et numéros automatiques** : il construit un contexte de
variables (`$nom → valeur`) et évalue avec `Eval()` une expression Gambas paramétrée par
l'utilisateur, par exemple le libellé par défaut d'un compte (`Fiches_Comptes.libel_def`) ou un
numéro de document. Les variables viennent :
- d'une `Collection` fournie par l'appelant (`$numbl`, `$numecr`, `$date`…) ;
- des champs d'un `Result` (`ParseResult` : `$<champ>`, les `.` remplacés par `_`) ;
- d'une date (`AddDate` : `$annee`, `$annee2`, `$mois`, `$moistr`, `$moistr3`, `$semaine`,
  `$jour`, `$jourstr`, `$jourstr3`, avec un préfixe optionnel).

Si un contrôle `Parent` est fourni, son infobulle est complétée par la liste des variables
disponibles (et par un message en cas d'erreur d'évaluation).

Appelants : `Saisecrit`, `Tresor`, `EcrAuto`, `ValidBR`, `ValidBR1`.

Nature globale : **calcul**, avec un effet de bord GUI optionnel (infobulle du `Parent`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$parent` | var | Private |  | Control | 5 |
| `$context` | var | Private |  | Collection | 6 |
| `$defaut_output` | var | Private |  | String | 7 |
| `$original_tooltip` | var | Private |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 11-29 | Public | 3 | 15 | 0 | méthode spéciale |
| `ParseResult` | 31-44 | Public | 3 | 9 | 5 |  |
| `AddDate` | 46-60 | Public | 1 | 12 | 5 |  |
| `Evaluate` | 62-78 | Public | 5 | 13 | 5 |  |
| `Update_Tooltip` | 80-92 | Private | 3 | 7 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Parent, VariableAssignement, defout)`** [portée : nécessaire] [nature : mixte].
  Mémorise la valeur par défaut renvoyée en cas d'échec (`defout`), le contexte (⚠️ **la
  collection de l'appelant elle-même, pas une copie** : `ParseResult`/`AddDate` y ajoutent des clés
  visibles par l'appelant et par les autres `LVar` qui partagent la même collection, ce qui est le
  cas dans `Saisecrit` l. 411-414 et 2984-2987), et le contrôle `Parent`. Si `Parent` est non Null,
  extrait l'infobulle d'origine (partie avant le séparateur `"\n-----…\n"`) puis appelle
  `Update_Tooltip`.
  ⚠️ `Left(Tooltip, Pos)` : si le séparateur est absent (`Pos = 0`), l'infobulle d'origine devient
  `""` (perdue) ; s'il est présent, le premier `\n` du séparateur est conservé, donc chaque nouvel
  `LVar` sur le même contrôle ajoute une ligne vide (anomalie LVAR-A01).
- **`ParseResult(res)`** [portée : nécessaire] [nature : calcul]. Ajoute chaque champ de la ligne
  courante du `Result` au contexte. ⚠️ `$context[clé] = …` remplace silencieusement une clé
  existante (les champs écrasent les variables fournies par l'appelant de même nom). Variable `out`
  inutilisée.
- **`AddDate(dte, Prefix)`** [portée : nécessaire] [nature : calcul]. Ajoute les composants de la
  date (`LDate.Year`, `Year2`, `Month`, `MonStr`, `MonStr3`, `Week`, `Day`, `WeekDay`, `WeekDay3`).
  `Format(CStr(x), "00")` reconvertit la chaîne en nombre pour la formater (détour inutile).
  ⚠️ `$annee2 = CStr(dte.Year2)` : `Year2` est un `Integer`, donc 2005 donne `"5"` et non `"05"`
  (anomalie LVAR-A02). `$moistr` hérite des noms de mois incohérents de `LDate.MonStr`
  (LDATE-A04).
- **`Evaluate(str)`** [portée : nécessaire] [nature : calcul]. `Eval(str, $context)` ; chaîne vide
  → `defout` ; erreur → `defout` et message d'erreur dans l'infobulle du `Parent`. ⚠️ L'expression
  provient de la base (`libel_def`, `numDoc`) et est évaluée par `Eval` : elle peut appeler les
  fonctions Gambas accessibles à `Eval` (périmètre exact à confirmer) ; c'est du paramétrage
  administrateur, à documenter comme tel.
- **`Update_Tooltip(info)`** (privé) [nature : GUI]. Reconstruit l'infobulle :
  origine + séparateur + `info` + « Variables Possible: » + liste des clés. Concaténation dans une
  boucle sur la propriété `Tooltip` (une réaffectation du contrôle par variable).

## État global utilisé

- Aucun état global ; dépend de [`LDate`](../LDate.class/architecture.md) pour `AddDate`.
- Contexte partagé par référence avec l'appelant (voir `_New`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Update_Tooltip` : construire la chaîne dans une variable locale (`String[]` + `Join`) puis une
  seule affectation de `Tooltip`.
- `AddDate` : `Format(dte.Month, "00")` directement (même résultat).
- Supprimer les variables `out` inutilisées (`ParseResult`, déclaration en tête d'`Evaluate`
  réutilisée : à garder dans `Evaluate`).

### Commonalisation avec d'autres fichiers

- La séquence `New LVar` → `AddDate(LDate(datej.Text))` → `ParseResult(r)` → `Evaluate(expr)` est
  répétée une douzaine de fois dans [`Saisecrit`](../../Compta/Saisecrit.class/architecture.md),
  `Tresor`, `EcrAuto`, `ValidBR`, `ValidBR1`. Un helper `Public Sub Calcule(parent, vars, defout,
  dte, res, expr) As String` (ou une méthode de classe statique) réduirait cette duplication ; les
  appelants seront modifiés dans leurs propres reworks.
- Les noms de jours/mois viennent de `LDate` : pas de duplication locale.

### Réduction de portée

- Aucune : les quatre méthodes Public sont appelées depuis l'extérieur.

### Séparation traitement / GUI

- Le seul couplage GUI est l'infobulle du `Parent` ; il est déjà isolé dans `Update_Tooltip`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les expressions `libel_def`/`numDoc` sont stockées comme code Gambas brut dans la base ; un
  format de gabarit déclaratif (`{annee}-{numbl}`) éviterait `Eval` et ses risques.
