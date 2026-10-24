# Calc — Architecture

> Source : `.src/Utils/Calc.class`

## Vue d'ensemble

`Calc` est une **ancienne calculatrice** (formulaire `Calc.form` : pavé numérique, opérateurs,
zone `Box1`) qui renvoie son résultat dans la variable statique `Calc.Resultat`.

**La classe est entièrement morte** : aucun fichier ne l'ouvre ni ne lit `Calc.Resultat` (grep
`Calc` sur `.src/`, `.project`, `.form`). Le seul autre usage du nom est le type de retour de
`FCalc.GetParent() As Calc`, lui-même jamais appelé. L'appel historique est commenté dans
`Facture.class:10647` (`'IF Key.Code = Key.F5 THEN Calc.run()`). Elle a été remplacée par
[`FCalc`](../FCalc.class/architecture.md).

Nature : **mixte** (calcul arithmétique sur chaînes mêlé aux contrôles).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Resultat` | var | Public | oui | String | 3 |
| `a` | var | Private |  | Float | 4 |
| `Op` | var | Private |  | String | 5 |
| `Op2` | var | Private |  | String | 6 |
| `Valid` | var | Private |  | String | 7 |
| `Mt` | var | Private |  | String | 8 |
| `Mt2` | var | Private |  | String | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-13 | Public | 1 | 2 | 0 | méthode spéciale |
| `Form_Show` | 15-22 | Public | 1 | 6 | 0 | handler GUI |
| `SetObservers` | 24-36 | Public | 4 | 10 | 0 | portée réductible ? |
| `Obs_Enter` | 38-42 | Public | 1 | 3 | 0 | handler GUI |
| `Obs_Leave` | 44-48 | Public | 1 | 3 | 0 | handler GUI |
| `zero_Click` | 50-54 | Public | 1 | 3 | 0 | handler GUI |
| `un_Click` | 56-60 | Public | 1 | 3 | 0 | handler GUI |
| `deux_Click` | 62-66 | Public | 1 | 3 | 0 | handler GUI |
| `trois_Click` | 68-72 | Public | 1 | 3 | 0 | handler GUI |
| `quatre_Click` | 74-78 | Public | 1 | 3 | 0 | handler GUI |
| `cinq_Click` | 80-84 | Public | 1 | 3 | 0 | handler GUI |
| `six_Click` | 86-90 | Public | 1 | 3 | 0 | handler GUI |
| `sept_Click` | 92-96 | Public | 1 | 3 | 0 | handler GUI |
| `huit_Click` | 98-102 | Public | 1 | 3 | 0 | handler GUI |
| `neuf_Click` | 104-108 | Public | 1 | 3 | 0 | handler GUI |
| `division_Click` | 110-115 | Public | 1 | 4 | 0 | portée réductible ? |
| `multiplication_Click` | 117-122 | Public | 1 | 4 | 0 | handler GUI |
| `soustraction_Click` | 124-129 | Public | 1 | 4 | 0 | handler GUI |
| `addition_Click` | 131-136 | Public | 1 | 4 | 0 | handler GUI |
| `pourcentage_Click` | 138-154 | Public | 4 | 15 | 0 | handler GUI |
| `egal_Click` | 156-160 | Public | 1 | 3 | 0 | handler GUI |
| `virgule_Click` | 162-167 | Public | 1 | 4 | 0 | handler GUI |
| `Raz_Click` | 169-175 | Public | 1 | 5 | 0 | handler GUI |
| `Box1_KeyPress` | 177-215 | Public | 14 | 32 | 0 | handler GUI |
| `calcul` | 217-260 | Public | 8 | 41 | 0 | portée réductible ? |
| `Oprt` | 262-274 | Public | 6 | 11 | 0 | portée réductible ? |
| `export_Click` | 276-283 | Public | 3 | 6 | 0 | handler GUI |
| `Rep` | 285-289 | Public | 1 | 3 | 0 | portée réductible ? |
| `prct` | 291-295 | Public | 1 | 3 | 0 | portée réductible ? |
| `Div` | 297-301 | Public | 1 | 3 | 0 | portée réductible ? |
| `Mlt` | 303-307 | Public | 1 | 3 | 0 | portée réductible ? |
| `ChkPrx` | 309-317 | Public | 12 | 7 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** : vide. **`Form_Show()`** : centre, rattache un `Observer` à chaque bouton
  (`SetObservers`), focus sur `Box1`.
- **`SetObservers(hClass, hCont)`** [portée : réductible] [nature : GUI]. Parcours récursif des
  conteneurs ; `hClass` est inutilisé. Doublon de `Utils.Observers`.
- **`Obs_Enter()` / `Obs_Leave()`** [handlers de l'observer `OBS`] : gras au survol.
- **`zero_Click()` … `neuf_Click()`** (10 handlers) : ajoutent un chiffre à `Box1`.
- **`division_Click()`, `multiplication_Click()`, `soustraction_Click()`, `addition_Click()`** :
  mémorisent `Op` et l'ajoutent à `Box1`.
- **`pourcentage_Click()`** [nature : mixte]. ⚠️ Utilise le membre `a`, **jamais affecté** (0) : le
  résultat vaut toujours `0` pour `+` et `-` ; la formule du `-` est identique à celle du `+`.
  Erreurs avalées par un `Catch` vide.
- **`egal_Click()`** → `Calcul()`. **`virgule_Click()`** : ajoute `,` et `Valid = ""`.
  **`Raz_Click()`** : remise à zéro.
- **`Box1_KeyPress()`** (CC 14) : filtre les touches (`ChkPrx`), remplace `.` par `,` ; Entrée/Tab →
  export si `Valid = "1"`, sinon calcul ; F5/Échap → ferme avec `Resultat = ""` ; les opérateurs
  tapés positionnent `Valid = ""`.
- **`calcul()`** (CC 9) [nature : mixte]. Analyse caractère par caractère : accumule les chiffres
  dans `Mt`, applique l'opérateur précédent (`Oprt`) au cumul `Mt2`. ⚠️ Le signe `-` initial est
  retiré de `Box1` puis **oublié** (`-2+3` donne 5). ⚠️ Selon `Valid`, le premier opérande est
  combiné avec `Mt2 = "0"` initial (`2*3` saisi aux boutons donne 0). `Catch` vide.
- **`Oprt(Op3)`** : applique `+ - * /` à `Mt2`/`Mt` (chaînes converties par `Val(Utils.cpoint())`).
- **`export_Click()`** : `Resultat = Format$(Val(cpoint(Box1)), "0.000")`, `"1"` en cas d'erreur,
  puis fermeture.
- **`Rep`, `prct`, `Div`, `Mlt`** : `Replace$` simples ; `Div` et `Mlt` ne sont jamais appelées.
- **`ChkPrx()`** : bloque les touches non numériques hors opérateurs et touches d'édition.

Toutes les étiquettes de portée sont sans objet : la classe entière est candidate à la suppression.

## État global utilisé

- `Static Public Resultat` (jamais lu à l'extérieur), `Utils.cpoint`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : supprimer `Calc.class` et `Calc.form`, et corriger le type de retour de
  `FCalc.GetParent` (lui-même mort, voir FCALC-002).

### Commonalisation avec d'autres fichiers

- Fonctionnalité couverte par [`FCalc`](../FCalc.class/architecture.md).
- `SetObservers` duplique `Utils.Observers`.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet (suppression).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
