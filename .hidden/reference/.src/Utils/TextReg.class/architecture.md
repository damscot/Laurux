# TextReg — Architecture

> Source : `.src/Utils/TextReg.class`

## Vue d'ensemble

`TextReg` est le **contrôle de saisie standard** de Laurux : un `ButtonBox` (zone de texte + bouton
« effacer ») déclaré `Export` et `Create Static`, utilisable dans l'IDE comme un contrôle natif
(`_Properties`, `_DrawWith = "TextBox"`). Il est posé dans **36 formulaires (239 contrôles)** et
créé dynamiquement par plusieurs écrans génériques (`TriGen`, `Sailig`, `SaiTableau`, `Caisse`,
`menuopt`, `Achat`).

Fonctions :

- **Filtrage par expression régulière** à chaque frappe (`reg`, constantes `chaine`, `num`,
  `code`, `compte`, `dts`, `dtst`, `mail`, `path`, `url`, `all`/`nofilter`) : le texte est remplacé
  par la partie qui correspond (`RegExp.Text`).
- **Types de données** (`Type`) : `EstText`, `EstNum` (valeur `Float` dans `Value`, virgule
  décimale, nombre de décimales `nbdec`), `EstDate` / `EstDateTime` (objet [`LDate`](../LDate.class/architecture.md)
  public `dte`, calendrier `LDateC` sur F2 ou double-clic, normalisation à la perte de focus).
- **Fenêtre de recherche** en base (`recherche`, `champs(table, champs…)`, `condition`, `lke`) :
  `CTRL + Haut`, liste `SELECT <champs> FROM <table> WHERE <champ1> LIKE &1 <condition>`.
- **Historique** des 10 dernières saisies (`CTRL + Bas`), persistant par fenêtre/contrôle via
  [`ObjProp`](../ObjProp.class/architecture.md) en mode `Param`.
- **Mode scanner** (F11) : après une lecture de code-barre, envoie un Retour.
- Échap restaure la valeur d'entrée.

Les événements du contrôle lui-même (`Observer(Me) As "butb"`), de la fenêtre de recherche
(`New Window … As "butb"`) et de sa grille (`New GridView … As "butb"`) arrivent **tous** dans les
handlers `butb_*` ; `Last` et `$grd.Tag` servent à distinguer l'émetteur.

Nature : **GUI** avec une requête SQL de recherche (lecture) et des E/S de configuration (via
`ObjProp`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `commence_par` | enum | Public | oui |  | 7 |
| `fini_par` | enum | Public | oui |  | 7 |
| `contient` | enum | Public | oui |  | 7 |
| `Rien` | enum | Public | oui |  | 8 |
| `EstRecherche` | enum | Public | oui |  | 8 |
| `EstHisto` | enum | Public | oui |  | 8 |
| `EstText` | enum | Public | oui |  | 9 |
| `EstNum` | enum | Public | oui |  | 9 |
| `EstDate` | enum | Public | oui |  | 9 |
| `EstDateTime` | enum | Public | oui |  | 9 |
| `dte` | var | Public |  | New LDate As "" | 11 |
| `lke` | var | Public |  | Integer | 12 |
| `$value` | var | Private |  | Float | 14 |
| `$text` | var | Private |  | String | 15 |
| `$textesc` | var | Private |  | String | 16 |
| `$nbdec` | var | Private |  | String | 17 |
| `$reg` | var | Private |  | String | 18 |
| `$typedonne` | var | Private |  | Integer | 19 |
| `$regp` | var | Private |  | Boolean | 20 |
| `$regex` | var | Private |  | New RegExp | 21 |
| `$win` | var | Private |  | Window | 22 |
| `$grd` | var | Private |  | GridView | 23 |
| `$champ` | var | Private |  | String[] | 24 |
| `$fichier` | var | Private |  | String | 25 |
| `$rech` | var | Private |  | Boolean | 26 |
| `$choirech` | var | Private |  | Integer | 27 |
| `$y` | var | Private |  | Float | 28 |
| `$x` | var | Private |  | Float | 29 |
| `$objp` | var | Private |  | Object | 30 |
| `$cond` | var | Private |  | String | 31 |
| `$prop` | var | Private |  | ObjProp | 32 |
| `$sca` | var | Private |  | Boolean | 33 |
| `$actsca` | var | Private |  | Boolean | 34 |
| `$F11` | var | Private |  | Boolean | 35 |
| `all` | const | Public |  |  | 37 |
| `path` | const | Public |  |  | 38 |
| `url` | const | Public |  |  | 39 |
| `code` | const | Public |  |  | 40 |
| `compte` | const | Public |  |  | 41 |
| `num` | const | Public |  |  | 42 |
| `chaine` | const | Public |  |  | 43 |
| `mail` | const | Public |  |  | 44 |
| `dts` | const | Public |  |  | 45 |
| `dtst` | const | Public |  |  | 46 |
| `nofilter` | const | Public |  |  | 47 |
| `_Properties` | const | Public |  |  | 53 |
| `_DrawWith` | const | Public |  |  | 54 |
| `Value` | property | Public |  | Float | 56 |
| `Type` | property | Public |  | Integer | 59 |
| `nbdec` | property | Public |  | String | 60 |
| `reg` | property | Public |  | String | 61 |
| `MaxLength` | property | Public |  | Integer | 62 |
| `Text` | property | Public |  | String | 63 |
| `recherche` | property | Public |  | Boolean | 64 |
| `conteneur` | property | Public |  | Object | 65 |
| `condition` | property | Public |  | String | 66 |
| `RechX` | property | Public |  | Float | 67 |
| `RechY` | property | Public |  | Float | 68 |
| `Champ` | property | Public |  | String[] | 69 |
| `Choirech` | property | Public |  | Integer | 70 |
| `Name` | property | Public |  | String | 71 |
| `AddTooltip` | property | Public |  | String | 72 |
| `scanner` | property | Public |  | Boolean | 73 |
| `activescan` | property | Public |  | Boolean | 74 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 76-87 | Public | 2 | 9 | 0 | méthode spéciale |
| `_ready` | 89-93 | Public | 1 | 3 | 0 | méthode spéciale |
| `butb_click` | 96-110 | Public | 8 | 12 | 0 | handler GUI |
| `butb_keypress` | 112-177 | Public | 31 | 56 | 0 | handler GUI |
| `butb_KeyRelease` | 179-194 | Public | 7 | 12 | 0 | handler GUI |
| `butb_DblClick` | 196-206 | Public | 7 | 9 | 0 | handler GUI |
| `butb_change` | 208-229 | Public | 8 | 19 | 0 | handler GUI |
| `butb_gotfocus` | 231-244 | Public | 3 | 11 | 0 | handler GUI |
| `butb_lostfocus` | 246-281 | Public | 11 | 34 | 0 | handler GUI |
| `dte_change` | 284-292 | Public | 3 | 7 | 0 | handler GUI |
| `Value_Read` | 294-302 | Private | 2 | 7 | 0 |  |
| `Value_Write` | 304-312 | Private | 4 | 7 | 0 |  |
| `Text_Read` | 314-318 | Private | 1 | 3 | 0 |  |
| `Text_Write` | 320-349 | Private | 7 | 27 | 0 |  |
| `nbdec_Read` | 352-356 | Private | 1 | 3 | 0 |  |
| `nbdec_Write` | 358-367 | Private | 4 | 8 | 0 |  |
| `reg_Read` | 370-374 | Private | 1 | 3 | 0 |  |
| `reg_Write` | 376-382 | Private | 1 | 5 | 0 |  |
| `MaxLength_Read` | 384-388 | Private | 1 | 3 | 0 |  |
| `MaxLength_Write` | 390-394 | Private | 1 | 3 | 0 |  |
| `recherche_Read` | 396-400 | Private | 1 | 3 | 0 |  |
| `recherche_Write` | 402-407 | Private | 2 | 4 | 0 |  |
| `RechX_Read` | 409-413 | Private | 1 | 3 | 0 |  |
| `RechX_Write` | 415-419 | Private | 1 | 3 | 0 |  |
| `RechY_Read` | 421-425 | Private | 1 | 3 | 0 |  |
| `RechY_Write` | 427-431 | Private | 1 | 3 | 0 |  |
| `conteneur_Read` | 433-437 | Private | 1 | 3 | 0 |  |
| `conteneur_Write` | 439-443 | Private | 1 | 3 | 0 |  |
| `condition_Read` | 445-449 | Private | 1 | 3 | 0 |  |
| `condition_Write` | 451-455 | Private | 1 | 3 | 0 |  |
| `butb_Mousewheel` | 457-461 | Public | 1 | 3 | 0 | handler GUI |
| `Select` | 464-473 | Public | 3 | 7 | 17 |  |
| `Unselect` | 475-479 | Public | 1 | 3 | 0 | portée réductible ? |
| `champs` | 481-488 | Public | 1 | 5 | 6 |  |
| `Delete` | 490-496 | Public | 1 | 5 | 1 |  |
| `frm` | 499-510 | Private | 3 | 10 | 0 |  |
| `affwin` | 512-559 | Private | 11 | 45 | 0 |  |
| `affgrd` | 561-601 | Private | 10 | 36 | 0 |  |
| `Champ_Read` | 603-615 | Private | 3 | 10 | 0 |  |
| `Champ_Write` | 617-627 | Private | 2 | 8 | 0 |  |
| `Choirech_Read` | 629-633 | Private | 1 | 3 | 0 |  |
| `Choirech_Write` | 635-639 | Private | 1 | 3 | 0 |  |
| `Name_Read` | 641-645 | Private | 1 | 3 | 0 |  |
| `Name_Write` | 647-653 | Private | 1 | 5 | 0 |  |
| `Type_Read` | 655-659 | Private | 1 | 3 | 0 |  |
| `Type_Write` | 661-695 | Private | 13 | 33 | 0 |  |
| `AddTooltip_Read` | 697-701 | Private | 1 | 3 | 0 |  |
| `AddTooltip_Write` | 703-707 | Private | 1 | 3 | 0 |  |
| `scanner_Read` | 709-713 | Private | 1 | 3 | 0 |  |
| `scanner_Write` | 715-722 | Private | 3 | 6 | 0 |  |
| `activescan_Read` | 724-728 | Private | 1 | 3 | 0 |  |
| `activescan_Write` | 730-735 | Private | 1 | 4 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Cycle de vie

- **`_new()`** [spéciale] [GUI]. Observer `butb` sur soi, icône « effacer », ajoute
  « CTRL + Down Fenêtre historique » à l'infobulle, regex par défaut `chaine`.
- **`_ready()`** [spéciale] [GUI]. Mémorise le texte initial pour Échap.
- **`Delete()`** [Public, surcharge] [GUI]. Libère `$objp` et `$prop` puis `Super.Delete`.

### Handlers `butb_*` (contrôle, fenêtre et grille de recherche)

- **`butb_click()`** [GUI]. Ignoré si désactivé ou lecture seule. Clic dans la grille de recherche
  (`Last.tag = $grd.Tag`) : recopie la 1ʳᵉ colonne et envoie Retour (`Utils.de.SendKey`). Sinon
  (bouton effacer) : vide le texte et la valeur, rafraîchit la recherche.
- **`butb_keypress()`** [GUI, CC 31, max du fichier]. Avec CTRL : Haut bascule la fenêtre de
  recherche (si `recherche`), Bas bascule l'historique. Sans CTRL : Échap restaure ; F2 ouvre le
  calendrier (types date) ; Entrée/Retour/Tab recopie la ligne choisie de l'historique (Tab
  seulement) ou de la recherche puis ferme la fenêtre ; Haut/Bas déplacent la sélection de la
  grille. ⚠️ Entrée en mode recherche lit `$grd.Row` sans tester `Object.IsValid($grd)` ; Tab en
  mode historique lit `$grd[$grd.Row, 0]` même si `Row = -1` (à confirmer).
- **`butb_KeyRelease()`** [GUI]. Mode scanner : un relâchement de Maj puis d'une touche normale
  avec F11 actif envoie Retour ; F11 bascule le mode si `scanner`. ⚠️ Utilise
  `Utils.de.SendKeys` (méthode héritée de `Desktop`) et non `Utils.de.SendKey` : la gestion Wayland
  (`ydotool`) de [`DB_Desktop`](../DB_Desktop.class/architecture.md) est contournée.
- **`butb_DblClick()`** [GUI]. Calendrier (types date) — code identique à la branche F2.
- **`butb_change()`** [GUI]. Applique la regex (`$regex.Exec`) ; si erreur, restaure le texte
  précédent. Pour `EstNum`, remplace `.` par `,` (le test `Match "."` est toujours vrai sur un texte
  non vide). Rafraîchit la recherche si une fenêtre est ouverte ; conserve la position du curseur.
- **`butb_gotfocus()`** [mixte]. Recrée `$prop = New ObjProp(Null, "<Fenêtre>/<Nom>",
  ObjProp.Param)` (relecture du fichier de paramètres **à chaque focus**), l'applique, affiche la
  valeur numérique brute (`Str($value)`), mémorise le texte, ouvre la fenêtre de recherche ou
  d'historique si `Choirech` le demande.
- **`butb_lostfocus()`** [mixte]. `EstNum` : valeur 0 si vide, sinon `Val` + format `nbdec` ;
  dates : normalisation par `dte.L`/`dte.LT`. Écrit les paramètres et l'historique
  (`$prop.EcriParam`, sous `Try`), ferme la fenêtre.
- **`butb_Mousewheel()`** [GUI]. Donne le focus à l'éditeur.
- **`dte_change(dt)`** [GUI]. Événement `change` de `LDate` : réaffiche la date.

### Propriétés (accesseurs privés)

| Propriété | Lecture | Écriture |
|---|---|---|
| `Value` (Float) | `$value` si `EstNum`, sinon 0 | `EstNum` seulement : valeur + texte formaté |
| `Text` | texte de l'éditeur | `EstNum` : `Val` (virgule) + format ; dates : `LDate(v).L/.LT` ; sinon texte brut |
| `Type` | `$typedonne` | change la regex par défaut (si `reg` non forcé), convertit le texte ; ⚠️ passer en `EstText`/`EstNum` met `dte = Null` (un retour ultérieur vers une date échoue) ; ⚠️ en `EstDate`, `Me.value = 0` est exécuté avant la mise à jour du type |
| `nbdec` | `$nbdec` | reformate la valeur si `EstNum` |
| `reg` | `$reg` | compile la regex, marque `reg` comme forcé |
| `MaxLength` | ⚠️ `Me.Editor.Value` (propriété inexistante d'un `TextBox` : erreur en lecture) | `Editor.MaxLength` |
| `recherche` | `$rech` | ajoute « CTRL + Up » à l'infobulle (à chaque affectation à `True`) |
| `RechX`, `RechY`, `conteneur`, `condition`, `Choirech` | membres | membres |
| `Champ` (String[]) | `[table, champs…]` ou `Null` | table + champs (utilisée par `ObjProp` via `AddChamp("champ", …)`) |
| `Name` | `Super.Name` | `Super.Name` + création/application de `$prop` |
| `AddTooltip` | infobulle | concatène |
| `scanner` | `$sca` | active F11, complète l'infobulle |
| `activescan` | `$F11` | `scanner` + mode actif |

### Méthodes publiques

- **`Select(start, length)`** [nécessaire, `Parametre:487,560,569`] : sélectionne tout (0, 0) ou une
  plage.
- **`Unselect()`** [réductible : aucun appelant identifié, `Last.Unselect` de `facopt` vise des
  `TextBox`].
- **`champs(fichier, …)`** [nécessaire : `Facture:270,276`, `SaiReg:49`, `TarTypeCli:25`,
  `Articles:111`, `Saisecrit:89`, `Tresor:88` — faux positif de `deps.py`]. Mémorise la table et les
  champs de recherche (noms de tables **en dur** chez les appelants, ex. `"Fiches_Cli"`). Variable
  `ch` inutilisée.

### Fonctions privées

- **`frm()`** [calcul pur]. Format `"0"`, `"0.0"`, `"0.00"`… selon `nbdec`.
- **`affwin(change)`** [GUI, CC 11]. Crée (ou recrée) la fenêtre sans bordure et sa grille, dans
  `conteneur` à (`RechX`, `RechY`) ou sous le contrôle ; une colonne pour l'historique, une par champ
  pour la recherche ; remplit (`affgrd`) et sélectionne la 1ʳᵉ ligne. Ferme la fenêtre si
  `Choirech = Rien`.
- **`affgrd()`** [mixte, CC 10]. Historique : lignes de `$prop.historique`. Recherche : motif
  `LIKE` selon `lke` (`commence_par`, `fini_par`, `contient` par défaut) puis
  `Utils.db.Exec("SELECT " & champs & " FROM " & table & " WHERE " & champ1 & " LIKE &1 " & condition, motif)`
  (valeur paramétrée, noms et condition concaténés) ; remplit la grille ; rend le focus au contrôle.

## Événements gérés

`butb_*` (contrôle, fenêtre et grille de recherche), `dte_change` (objet `LDate`). Les
formulaires utilisateurs reçoivent les événements hérités du `ButtonBox` sous le nom du contrôle
(ex. `Code_LostFocus`) : ces noms et les noms de contrôles des 36 `.form` sont intouchables.

## État global utilisé

- `Utils.db` (recherche), `Utils.de` (`DB_Desktop`, envoi de touches).
- `ObjProp` (paramètres persistants, fichier `Laurux-AutoParams-<société>.conf`), `LDate`,
  `LDateC` (calendrier).
- `Last` dans `butb_click`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `butb_keypress` : scinder en `ToucheCtrl()` et `ToucheNormale()` privés (CC 31 → ≤ 12 chacun).
- `butb_DblClick` et la branche F2 : helper privé `ChoisirDate()`.
- `butb_change` : remplacer `If Me.Editor.Text Match "." And …` par le seul test du type (même
  résultat, le remplacement sur une chaîne vide étant neutre).
- Supprimer `Dim i` (`butb_gotfocus`), `Dim ch` (`champs`).
- `butb_gotfocus` : ne recréer `$prop` que si la clé `<Fenêtre>/<Nom>` a changé depuis `Name_Write`
  (évite la relecture du fichier à chaque focus) — à valider par replay, car l'historique d'un
  autre contrôle de même clé ne serait plus relu.

### Commonalisation avec d'autres fichiers

- `frm()` ↔ `Utils.Find_nbdec` (`"0"`, `"0.00"`, `"0.000"`) ↔ formats de
  [`ObjProp.frmt`](../ObjProp.class/architecture.md) : helper unique `Utils.FormatDecimales(n)`.
- Recherche `LIKE` paramétrée : même besoin que la recherche de
  [`RichDataGrid`](../RichDataGrid.class/architecture.md), qui elle concatène la valeur
  (RICHDATAGRID-A01) ; un helper commun `Utils.LikeMotif(texte, mode)` servirait aux deux.
- Les appelants de `champs` passent des noms de tables en dur (`"Fiches_Cli"`, `"Fiches_Art"`,
  `"Fiches_Comptes"`, `"Fiches_Marques"`) : à remplacer chez eux par `Cbase.Table(...)` (hors de ce
  fichier).

### Réduction de portée

- `Unselect` : `Private` ou suppression (aucun appelant). Attention : `TextReg` est `Export` ; un
  usage par `Last.Unselect` sur un `TextReg` n'est pas détectable statiquement — vérifier par
  replay des écrans à saisie.
- `lke` et `champs` (proposés par `deps.py`) : **utilisés** (`Facture:280`, `TarTypeCli:26` pour
  `lke`), à conserver `Public`.

### Séparation traitement / GUI

- `affgrd` : construction et exécution de la requête dans une fonction `Recherche(texte) As Result`
  (motif `LIKE` pur + SQL), le remplissage de la grille restant GUI.
- `Text_Write` (`EstNum`) et `butb_lostfocus` : conversion texte → `Float` dans une fonction pure
  `LitNombre(texte) As Float` ; `frm()` est déjà pure (passer `Public` pour gb.test ou la déplacer
  dans `Utils`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La recherche `LIKE '%texte%'` (mode `contient` par défaut) ne peut pas utiliser d'index : un
  index plein texte sur `art_design`, `cli_nom`… ou des colonnes normalisées (majuscules sans
  accents) accéléreraient les grosses tables.
