# ObjProp — Architecture

> Source : `.src/Utils/ObjProp.class`

## Vue d'ensemble

`ObjProp` est un **descripteur de contrôle** : une liste ordonnée de couples
(nom de propriété, valeur, format) qu'on applique à un objet par réflexion
(`Object.SetProperty`). Il sert à deux usages distincts :

1. **Description de colonnes/champs** pour les écrans génériques : `TriGen` et ses dérivés
   (`TriArticles`, `TriCpt`, `TriFacture`, `Pointage`, `FClient`, `FFournisseur`, `Articles`,
   `ValidBR1`, `commande1`…), `SaiTableau`/`Sailig`, `Achat`, `GesTar`, `Parametre`. Le
   constructeur reçoit la clé (nom de champ ou `ResultField`), le nom du contrôle et le type de
   contrôle à créer (`ObjProp.TextReg`, `TextBox`, `Button`, `Label`, `TextLabel`, `CheckBox`,
   `ComboBox`) ; les drapeaux publics `tri` et `cle` pilotent le tri initial et la valeur renvoyée
   par la recherche ; `filter`/`CondFilter` décrivent la `TextReg` de filtre associée.
2. **Paramètres persistants d'une [`TextReg`](../TextReg.class/architecture.md)** (type
   `ObjProp.Param`) : lecture/écriture dans `~/.config/gambas3/Laurux-AutoParams-<société>.conf`
   du mode de recherche (`Choirech`) et de l'**historique** des 10 dernières saisies.

La classe est déclarée `Create Static` mais l'auto-instance n'est utilisée que pour l'énumération
(`ObjProp.Param`, `ObjProp.TextReg`…).

Nature : **mixte** : réflexion sur des contrôles (GUI), formatage de texte (calcul) et fichier de
configuration (E/S). Aucun accès à la base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `nom` | var | Private |  | String | 6 |
| `propriete` | var | Private |  | Variant | 7 |
| `frm` | var | Private |  | String | 8 |
| `$elem` | var | Private |  | New Elements[] | 11 |
| `$clef` | var | Private |  | String | 12 |
| `$nom` | var | Private |  | String | 13 |
| `$name` | var | Private |  | String | 14 |
| `$CondFilter` | var | Private |  | ObjProp | 15 |
| `$filter` | var | Private |  | TextReg | 16 |
| `$type` | var | Private |  | Integer | 17 |
| `$h` | var | Private |  | Integer | 18 |
| `$w` | var | Private |  | Integer | 19 |
| `$conf` | var | Private |  | Settings | 20 |
| `historique` | var | Public |  | New String[10] | 22 |
| `tri` | var | Public |  | Boolean | 23 |
| `cle` | var | Public |  | Boolean | 24 |
| `TextReg` | enum | Public | oui |  | 26 |
| `TextBox` | enum | Public | oui |  | 26 |
| `Button` | enum | Public | oui |  | 26 |
| `Label` | enum | Public | oui |  | 26 |
| `TextLabel` | enum | Public | oui |  | 26 |
| `CheckBox` | enum | Public | oui |  | 26 |
| `ComboBox` | enum | Public | oui |  | 26 |
| `Param` | enum | Public | oui |  | 26 |
| `filter` | property | Public |  | TextReg | 28 |
| `name` | property | Public |  | String | 29 |
| `NomControl` | property | Public |  | String | 30 |
| `TypeClass` | property | Public |  | Integer | 31 |
| `Height` | property | Public |  | Integer | 32 |
| `Width` | property | Public |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 35-58 | Public | 6 | 22 | 0 | méthode spéciale |
| `AddChamp` | 60-70 | Public | 3 | 8 | 11 |  |
| `ModChamp` | 72-86 | Public | 5 | 12 | 0 | portée réductible ? |
| `AppProp` | 88-99 | Public | 3 | 9 | 2 |  |
| `AjoutCondfilter` | 101-105 | Public | 1 | 3 | 0 | portée réductible ? |
| `CondFilter` | 107-111 | Public | 1 | 3 | 0 | portée réductible ? |
| `EcriParam` | 113-131 | Public | 4 | 16 | 1 |  |
| `LecParam` | 133-143 | Public | 2 | 8 | 0 | portée réductible ? |
| `frmt` | 145-164 | Private | 9 | 16 | 0 |  |
| `name_Read` | 168-172 | Private | 1 | 3 | 0 |  |
| `CondFilter_Read` | 174-178 | Private | 1 | 3 | 0 |  |
| `filter_Read` | 180-184 | Private | 1 | 3 | 0 |  |
| `filter_Write` | 186-196 | Private | 2 | 9 | 0 |  |
| `NomControl_Read` | 198-202 | Private | 1 | 3 | 0 |  |
| `TypeClass_Read` | 204-208 | Private | 1 | 3 | 0 |  |
| `Height_Read` | 210-215 | Private | 1 | 3 | 0 |  |
| `Height_Write` | 217-222 | Private | 1 | 4 | 0 |  |
| `Width_Read` | 224-228 | Private | 1 | 3 | 0 |  |
| `Width_Write` | 230-235 | Private | 1 | 4 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Clef, Nom, TypeClass)`** [portée : nécessaire] [nature : mixte]. `Clef` peut être une
  chaîne ou un `ResultField` (son nom) ; tout autre type → `Message.Error("Object property non
  supporté")`. Mémorise `Nom` (nom du contrôle) et le type ; pour `Param`, appelle `LecParam(Nom)`.
- **`AddChamp(nom, propriete, frm)`** [portée : nécessaire, 10 appelants] [calcul]. Ajoute un
  élément ; si la valeur est un tableau, elle est d'abord jointe (`propriete.Join`, sous `Try`).
  `frm` est un format de nombre ou de date.
- **`ModChamp(nom, propriete, frm)`** [portée : nécessaire, `Achat:463` et interne] [calcul].
  Remplace l'élément de même nom (même jonction) ou l'ajoute.
- **`AppProp(obj)`** [portée : nécessaire, `TextReg`, `Achat`, `Sailig`] [GUI].
  `Object.SetProperty(obj, nom, valeur)` pour chaque élément, puis `frmt` si un format est donné.
- **`AjoutCondfilter()`** [portée : réductible — aucun appelant, vérifié par `grep`] : crée
  `$CondFilter = New ObjProp($clef, $nom)`.
- **`CondFilter(nom, propriete)`** [portée : réductible — aucun appelant externe] : ajoute un
  élément à `$CondFilter` (erreur si `$CondFilter` n'existe pas).
- **`EcriParam(Nom, txt)`** [portée : nécessaire, `TextReg.butb_lostfocus`] [E/S]. Écrit chaque
  propriété décrite (`Object.GetProperty(txt, nom)`) sous `/<Nom>/<propriété>` ; si la `TextReg`
  n'est pas vide, met à jour l'historique (suppression du doublon, insertion en tête, troncature à
  10) et **enregistre** le fichier. ⚠️ Si l'objet n'est pas de type `Param`, `$conf` est `Null` :
  erreur (masquée par le `Try` de l'appelant).
- **`LecParam(Nom)`** [portée : réductible, appelée seulement par `_new`] [E/S]. Ouvre le fichier
  `Laurux-AutoParams-<Start.Societe>.conf`, ajoute l'élément `Choirech` (0 par défaut) et charge
  l'historique s'il existe. Variable `e` inutilisée. ⚠️ L'historique par défaut est
  `New String[10]` : 10 chaînes vides, visibles dans la fenêtre d'historique tant que l'utilisateur
  n'a pas saisi 10 valeurs (à confirmer à l'écran).
- **`frmt(frm, obj)`** [privé] [calcul + GUI, CC 9]. Si le format contient `dd`/`mm`/`yy`,
  reformate `obj.text` comme date (`LDate(obj.text).G`) ; sinon remplace `.` par `,` et applique
  `Format(Val(texte), frm)`. La branche `Utils.CDec` est **inatteignable** (`TypeOf(frm)` vaut
  toujours `gb.String`). Toute erreur écrit `"#Error"` dans le contrôle.
- **Propriétés** : `filter` (écriture : crée `$CondFilter` si besoin, lui ajoute
  `Text`/`Tag` = nom, `Alignment` centré, `Tooltip`, puis l'applique à la `TextReg` de filtre),
  `name` (clé), `NomControl` (`$nom`), `TypeClass`, `Height`/`Width` (écriture : `ModChamp("H"/"W")`
  + mémorisation). `CondFilter_Read` est un accesseur **sans propriété déclarée** (code mort, et
  homonyme de la méthode `CondFilter`).

## État global utilisé

- `Start.Societe` (nom du fichier de paramètres), `User.Home`, `Application.Name`.
- Fichier `~/.config/gambas3/Laurux-AutoParams-<société>.conf` (hors `Laurux.conf`).
- `LDate`, `Utils.CDec` (branche morte), `Message.Error`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `ValeurElement(propriete As Variant) As Variant` pour la jonction des tableaux
  (dupliquée dans `AddChamp` et `ModChamp`) ; `ModChamp` peut réutiliser une recherche
  `IndexElement(nom)`.
- Supprimer le code mort : `CondFilter_Read`, la branche `Utils.CDec` de `frmt`, `Dim e` de
  `LecParam`.
- Remplacer les trois `Match` de date par un seul motif `"dd|mm|yy"` (même résultat ;
  `yyyy` est déjà couvert par `yy`).

### Commonalisation avec d'autres fichiers

- Formatage numérique : `frmt` (format donné), [`TextReg.frm`](../TextReg.class/architecture.md)
  (format construit à partir d'un nombre de décimales) et `Utils.Find_nbdec` (`"0"`, `"0.00"`,
  `"0.000"`) produisent les mêmes chaînes `"0.00…"` ; un helper `Utils.FormatDecimales(n)`
  servirait à `TextReg` et `Utils`.
- Formatage de date via `LDate` : cohérent avec [`LDate`](../LDate.class/architecture.md).

### Réduction de portée

- `AjoutCondfilter`, `CondFilter` : aucun appelant (`grep -rniE 'AjoutCondfilter|\.CondFilter'`) →
  `Private` ou suppression ; `LecParam` → `Private` (appel interne uniquement). Couverture : via
  `_new` (type `Param`) et la propriété `filter`.

### Séparation traitement / GUI

- `frmt` : fonction pure `FormatTexte(frm, texte) As String` (renvoie `"#Error"` en cas
  d'erreur) ; l'affectation `obj.text = …` reste dans `AppProp`.
- Historique : fonction pure `MajHistorique(historique, valeur) As String[]` (dédoublonnage,
  insertion, troncature), testable en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune côté base. Les historiques de saisie sont locaux au poste et par société ; un stockage
  en base par utilisateur permettrait de les partager entre postes.
