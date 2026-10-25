# numtostring — Architecture

> Source : `.src/Caisse/numtostring.module`

> **Identifiant** : le nom `NUMTOSTRING` est déjà pris par
> [`Utils/Numtostring.module`](../../Utils/Numtostring.module/architecture.md) (homonyme à la casse
> près). Pour garder des `rework_id` uniques, ce module utilise le préfixe **`NUMTOSTRING_CAISSE`**.

## Vue d'ensemble

Module de conversion d'un nombre entier (chaîne de 1 à 6 chiffres) en toutes lettres, destiné à
l'**impression des chèques** par la caisse (`Caisse.Imp_Cheque`, `Caisse.class:5064` et `5069` ;
`Caisse.Imp_Cheque1`, `5149` et `5154`). Algorithme « d'après une routine Java de GALA OUSSE
Brice » : `Calc_unite` (0-9), `Calc_Dizaine` (10-19 et dizaines), `nbtostring` (récursif par
découpage en chaîne).

**Ce module n'est probablement jamais exécuté** (anomalie NUMTOSTRING_CAISSE-A01) : Gambas range
les classes compilées sous un nom en majuscules (`.gambas/NUMTOSTRING`) et ne distingue pas
`Numtostring` de `numtostring`. Le fichier compilé présent dans les deux clones (`Laurux` et
`Laurux_reworked`) contient `Num2Text` et non `nbtostring` (vérifié par `strings
.gambas/NUMTOSTRING`) : c'est la version `Utils` qui gagne. À l'exécution, `numtostring.nbtostring`
de la caisse vise donc un module qui n'a pas ce symbole : l'impression d'un chèque en caisse
(réponse « Oui » à « Voulez-vous imprimer le chèque ? ») lève une erreur « Unknown symbol »
(erreur certaine d'après le binaire, comportement exact de la caisse à confirmer en phase 2).
Réciproquement, `FRelFacture.class:464` (`numtostring.Num2Text`, minuscule) vise bien le module
`Utils` : l'hypothèse inverse de la documentation de `Utils/Numtostring` est à corriger
(signalée au coordinateur).

Nature : **calcul pur**, sans base ni GUI.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Calc_unite` | 5-33 | Public | 11 | 26 | 0 | portée réductible ? |
| `Calc_Dizaine` | 35-79 | Public | 19 | 42 | 0 | portée réductible ? |
| `nbtostring` | 81-186 | Public | 62 | 98 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Calc_unite(nombre As Integer) As String`** [portée : réductible] [nature : calcul]. 0 à 9 →
  « zéro » … « neuf » ; `""` hors bornes. Appelée seulement par `nbtostring`.
- **`Calc_Dizaine(nombre As Integer) As String`** [portée : réductible] [nature : calcul]. 10 à 19,
  puis 20, 30 … 90 (« soixante-dix », « quatre-vingt », « quatre-vingt-dix ») ; `""` sinon.
  Appelée seulement par `nbtostring`.
- **`nbtostring(nombre As String) As String`** [portée : nécessaire, `Caisse`] [nature : calcul,
  CC 62].
  - Garde : plus de 9 caractères → `Return` (chaîne vide) ; `InStr("0123456789,.", nombre) = 1` →
    `Return` : ce test n'accepte pas « les chiffres » mais rejette toute chaîne qui est un
    **préfixe** de `"0123456789,."` (`"0"`, `"01"`, `"012"`…) ; ainsi les centimes `"01"` donnent
    `""` au lieu de « un » (NUMTOSTRING_CAISSE-A03).
  - `Len = 1` : unité. `Len = 2` : 10-19 direct ; 20-69 et 80-89 → dizaine + unité séparées par un
    espace (« vingt un », « quatre-vingt un ») ; 70-79 et 90-99 → dizaine précédente + 10-19
    (« soixante onze », « quatre-vingt dix-sept ») ; pas de « et », pas de traits d'union, pas de
    pluriel de « vingt » (NUMTOSTRING_CAISSE-A02).
  - `Len = 3` : centaines (« cent », « <n> cents », « <n> cent <reste> ») avec récursion sur le
    reste (« deux cents » correct, mais « deux cents mille » pour 200 000).
  - `Len = 4`, `5`, `6` : trois blocs **identiques** (milliers + reste, récursion) ; 7 à 9 chiffres
    → aucune branche, chaîne vide sans erreur.
  - Le quotient est obtenu par `nb2 / divisor`, puis `InStr(Str(quotient), ",")` : la découpe
    suppose que `Str()` rend une virgule décimale (locale française) ; en locale `C`, le quotient
    reste décimal et la récursion produit un texte faux (à confirmer).
  - Le paramètre `nombre` est une chaîne, mais la récursion lui passe des `Float` (`reste`,
    `quotient`) convertis implicitement.

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Si le module est conservé (décision A01) : fusionner les branches `Case 4`, `5`, `6`
  (`Case 4 To 6`), remplacer `Calc_unite`/`Calc_Dizaine` par des tableaux, calculer quotient et
  reste par arithmétique entière (`\` et `Mod`) au lieu de `Str()`/`InStr()`.

### Commonalisation avec d'autres fichiers

- [`Utils/Numtostring`](../../Utils/Numtostring.module/architecture.md) fournit déjà
  `Num2Text`/`Convertir` (orthographe différente, NUMTOSTRING-A04) ; `FRelFacture.Solde`
  (`FRelFacture.class:445-470`) contient la **même** séquence « entier + centimes, " et un ",
  " centime(s) " » que `Caisse.Imp_Cheque`/`Imp_Cheque1` mais appelle `Num2Text`. La correction la
  plus simple de A01 est de faire appeler `Numtostring.Num2Text` par la caisse (orthographe à
  valider), puis de supprimer ce module ; NUMTOSTRING-005 (fusion étudiée côté `Utils`) en dépend.

### Réduction de portée

- `Calc_unite`, `Calc_Dizaine` → `Private` (aucun appel hors du module, vérifié par
  `grep -rn "Calc_unite\|Calc_Dizaine" .src`).

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : le module n'accède pas à la base.
