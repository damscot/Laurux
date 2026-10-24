# LTrans — Architecture

> Source : `.src/Utils/LTrans.class`

## Vue d'ensemble

`LTrans` est un **objet de transport** (« standard object carrier ») entre une fenêtre appelante et
une fenêtre de sélection : il porte un texte (`Text`) et une liste (`List As Variant[]`). La
fenêtre de sélection le reçoit en paramètre (`Obj`/`$obj`) et y écrit le résultat ; l'appelant le
relit après `ShowModal`.

Deux usages coexistent :
1. **Par instance** (correct) : `GedR.SupprimerTags_Click`, `GedR.AjoutTags_Click`,
   `LGed.Copier_Click` créent `New LTrans`, le passent à [`LBox`](../LBox.class/architecture.md),
   qui écrit `$obj.List = ….Copy()` ; l'appelant teste `IsNull(trans.List)`.
2. **Par l'auto-instance statique** (`Create Static`) : `Caisse.class:7159` crée
   `Selection = New LTrans` et le passe à `TriFacture`, mais `TriFacture` écrit
   `LTrans.List = Selected.Copy()` (l. 82, 285) ou `LTrans.List.Clear()` (l. 294) sur
   l'**auto-instance**, et `Caisse` relit `LTrans.List.Copy()` (l. 7162). L'objet passé ne sert
   qu'à tester le type (`Object.Class(Obj).Name = "LTrans"`) : c'est un **état global déguisé**.

Nature globale : **calcul** (conteneur sans logique).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$text` | var | Private |  | String | 8 |
| `$list` | var | Private |  | Variant[] | 9 |
| `Text` | property | Public |  | String | 11 |
| `List` | property | Public |  | Variant[] | 12 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `New` | 15-20 | Public | 1 | 4 | 0 | portée réductible ? |
| `Text_Read` | 22-26 | Private | 1 | 3 | 0 |  |
| `Text_Write` | 28-32 | Private | 1 | 3 | 0 |  |
| `List_Read` | 34-38 | Private | 1 | 3 | 0 |  |
| `List_Write` | 40-44 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`New()`** [portée : réductible — **code mort**] [nature : calcul]. Initialise `$text = ""` et
  `$list = New Variant[]`. ⚠️ Ce n'est **pas** le constructeur (qui s'appellerait `_new`) : la
  méthode n'est jamais appelée. Une instance neuve a donc `List = Null`, et les appelants
  **s'appuient sur ce Null** (`IsNull(trans.List)` dans `GedR`, `Copiefichier.List = Null` dans
  `LGed`) pour détecter l'absence de sélection. Renommer `New` en `_new` changerait ce comportement
  (voir anomalie LTRANS-A01).
- **`Text_Read`/`Text_Write`** [nature : calcul] : accesseurs de `$text`. La propriété `Text`
  n'est utilisée par aucun appelant (vérifié par `grep` sur les variables `LTrans`).
- **`List_Read`** : renvoie la référence interne (pas de copie).
- **`List_Write(List)`** : stocke une **copie** (`List.Copy()`) ; affecter `Null` provoque une
  erreur (appel de méthode sur Null). Les appelants passent des `String[]` (conversion implicite
  vers `Variant[]` acceptée à l'exécution, à confirmer par test).

## État global utilisé

- Auto-instance statique `LTrans` utilisée comme variable globale entre `TriFacture` et `Caisse`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `New()` (code mort) en conservant l'état initial `List = Null`.
- Documenter le contrat : « `List = Null` tant que la fenêtre de sélection n'a rien écrit ».

### Commonalisation avec d'autres fichiers

- Le couple `Bsel`/`Bval` (`Object.SetProperty(Obj, "Bsel", …)`) utilisé par `TriFacture`,
  `TriGen`, `TriCpt` vers `LGed`, `GedR`, `Caisse` … joue le même rôle pour une valeur unique.
  `LTrans` pourrait devenir le transporteur commun (`Text` ↔ `Bval`, `List` ↔ sélection
  multiple) ; changement transverse lourd, à évaluer en phase 3 (fichiers :
  [`TriFacture`](../../Affichages/TriFacture.class/architecture.md),
  [`GedR`](../GedR.class/architecture.md), [`LGed`](../LGed.class/architecture.md),
  `TriGen`, `TriCpt`, `Caisse`).

### Réduction de portée

- `New` : code mort. `Text` : propriété sans usage, conservée tant que `LTrans` est présenté comme
  transporteur générique (à décider en phase 3).

### Séparation traitement / GUI

- Sans objet.

### Réarchitecture (fichiers appelants)

- `TriFacture` devrait écrire dans l'objet reçu (`Obj.List = …`) et `Caisse` relire
  `Selection.List` : même résultat fonctionnel pour un usage séquentiel, sans état global
  (LTRANS-003).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
