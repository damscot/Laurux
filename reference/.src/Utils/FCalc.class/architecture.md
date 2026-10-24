# FCalc — Architecture

> Source : `.src/Utils/FCalc.class`

## Vue d'ensemble

`FCalc` est la **calculette** de Laurux (formulaire « Calculette Laurux », dérivé d'un exemple
Gambasforge), ouverte en modal par la touche F5 dans les zones de montant ou de quantité de 7 écrans :
`Caisse`, `Saisecrit`, `Tresor`, `Abont`, `Facture` (×2), `TresorFac`, `Saisiedecons`. Le résultat
est renvoyé dans la variable **statique** `FCalc.Resultat`, que l'appelant lit après `ShowModal`.

La formule saisie (`$sFormula`) est évaluée par `Eval()` Gambas (après remplacement de `%` par
`/100`) ; le résultat (`$sResult`) est dessiné dans une `DrawingArea`.

Nature : **mixte** — la logique de saisie (`ManageKeys`) est pure sur deux chaînes et facilement
extractible ; l'affichage et l'export sont GUI.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$sFormula` | var | Private |  | String | 9 |
| `$sResult` | var | Private |  | String | 10 |
| `$iBracketCount` | var | Private |  | Integer | 11 |
| `Value` | property | Public |  | Float | 12 |
| `Resultat` | var | Public | oui | String | 13 |
| `$Export` | var | Private |  | Boolean | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-20 | Public | 1 | 3 | 0 | méthode spéciale |
| `DrawingArea1_Draw` | 23-35 | Public | 1 | 10 | 0 | handler GUI |
| `buttons_enter` | 37-41 | Public | 1 | 3 | 0 | handler GUI |
| `buttons_leave` | 43-47 | Public | 1 | 3 | 0 | handler GUI |
| `Export_enter` | 49-53 | Public | 1 | 3 | 0 | handler GUI |
| `Export_leave` | 55-59 | Public | 1 | 3 | 0 | handler GUI |
| `buttons_Click` | 61-66 | Public | 1 | 4 | 0 | handler GUI |
| `form_keypress` | 68-99 | Public | 8 | 27 | 0 | handler GUI |
| `GetParent` | 101-105 | Public | 1 | 3 | 0 | portée réductible ? |
| `ManageKeys` | 107-157 | Private | 20 | 44 | 0 |  |
| `Value_Read` | 159-163 | Private | 1 | 3 | 0 |  |
| `Export_Click` | 165-178 | Public | 2 | 12 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`.
- **`DrawingArea1_Draw()`** [portée : nécessaire, handler] [nature : GUI]. Dessine la formule puis le
  résultat en gras ; redonne le focus au formulaire.
- **`buttons_enter()` / `buttons_leave()`** [portée : nécessaire, handlers du groupe `buttons`]
  [nature : GUI]. Police grasse/italique au survol. **`Export_enter()` / `Export_leave()`** : idem
  pour le bouton `Export`.
- **`buttons_Click()`** [portée : nécessaire, handler] [nature : GUI]. Transmet le texte du bouton à
  `ManageKeys` (`X` → `*`), rafraîchit.
- **`form_keypress()`** [portée : nécessaire, handler] [nature : GUI]. Retour arrière → `"B"` ;
  Entrée/Retour : premier appui = calcul (`"="`), appui suivant = `Export_Click` ; autre touche →
  `ManageKeys(Key.Text)`. Les branches `Key.Return` et `Key.Enter` sont identiques, et la gestion de
  `$Export` est alambiquée (équivaut à : exporter si `$Export`, sinon calculer ; puis
  `$Export = True`).
- **`GetParent() As Calc`** [portée : réductible] [nature : GUI] — **code mort** : jamais appelée ;
  renvoie `Me.Parent` typé en `Calc` (classe morte, voir [`Calc`](../Calc.class/architecture.md)).
- **`ManageKeys(sKey)`** (CC 20, max du fichier) [privé] [nature : calcul].
  - `"="` : `Try $sResult = Eval(Replace($sFormula, "%", "/100"))` ; en erreur `$sResult = "1"`
    (valeur arbitraire), sinon la formule est vidée.
  - `"B"` : retire le dernier caractère. `"C"` : `$sResult = "0."`, formule vide, `$Export = False`.
    Seul le bouton `C` déclenche ce cas (la touche `c` minuscule est ignorée).
  - chiffres, `.` et `,` ajoutés tels quels. ⚠️ La virgule est acceptée mais `Eval` attend un point :
    une formule avec virgule part en erreur et donne `1` (à confirmer). Le test `If skey <> ")"`
    dans cette branche est toujours vrai.
  - opérateurs : `(` seulement après un opérateur, `)` seulement si une parenthèse est ouverte,
    `%` et `* / + -` seulement après un chiffre ou `)`.
- **`Value_Read()`** [privé, propriété `Value`] : renvoie `$sResult` converti en Float ; propriété
  jamais lue à l'extérieur (grep).
- **`Export_Click()`** [portée : nécessaire, handler] [nature : mixte]. Formate `$sResult` en
  `"0.00000"` (format **localisé**, ex. `12,50000`), le copie dans `Resultat` et ferme. La branche
  `Else` (`$sResult = "0"`) est morte en pratique : le format produit `0,00000`, jamais `"0"`.

## État global utilisé

- `Static Public Resultat As String` : canal de retour vers les 7 appelants. **Jamais remis à zéro** :
  si l'utilisateur ferme la calculette sans exporter, l'appelant relit la valeur du calcul
  précédent (même d'un autre écran).
- `Utils.Observers`, `Utils.cpoint`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `form_keypress` : fusionner `Key.Return`/`Key.Enter` et simplifier `$Export` (comportement
  identique).
- `ManageKeys` : sortir le cas « opérateurs » dans une fonction privée ; retirer la condition
  toujours vraie.

### Commonalisation avec d'autres fichiers

- Les 7 appelants répètent le même idiome (`New FCalc`, `ShowModal`, `If Not IsNull(FCalc.Resultat)`,
  `Format$(Val(…))`). Proposition : une méthode statique `FCalc.Saisir(sFormat As String) As String`
  qui encapsule ouverture, lecture et formatage ; les appelants (`Caisse:1647`, `Saisecrit:1339`,
  `Tresor:1057`, `Abont:127`, `Facture:3318,5574`, `TresorFac:469`, `Saisiedecons:131`) passent
  d'un bloc de 3-4 lignes à une ligne. Attention : `Caisse` passe par `Utils.cpoint` avant `Val`, les
  autres non : conserver chaque variante.
- `buttons_enter/leave` et `Export_enter/leave` recoupent `Calc.Obs_Enter/Leave` (classe morte).

### Réduction de portée

- `GetParent` : suppression (code mort). Les autres membres publics sont des handlers.
- `Resultat` doit rester `Static Public` (lu par 7 fichiers).

### Séparation traitement / GUI

- `ManageKeys` est déjà pur sur `$sFormula`/`$sResult` : l'exposer sous forme d'une fonction
  statique testable `Saisie(formule, resultat, touche)` (ou d'une petite classe d'état) permettrait
  des tests gb.test sans affichage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
