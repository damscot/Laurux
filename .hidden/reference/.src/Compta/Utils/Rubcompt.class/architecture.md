# Rubcompt — Architecture

> Source : `.src/Compta/Utils/Rubcompt.class`

## Vue d'ensemble

`Rubcompt` est l'écran de **saisie des plages de comptes** rattachées aux rubriques des éditions
comptables (bilan, compte de résultat, SIG) : table `Fiches_RubCompt` (clé `numrub, compte1`,
colonnes `compte2` et `amortissement`). Il est ouvert par le menu
Comptabilité > Compte de résultat > Gestion des comptes (`Fmenu.Menu123_Click`, `Rubcompt.Show`).

Une plage `compte1`…`compte2` affecte à la rubrique `numrub` tous les comptes du plan dont le
numéro est compris dans l'intervalle (comparaison de chaînes, voir
[Imp_Bilan](../../Impressions/Imp_Bilan.module/architecture.md)). Le drapeau `amortissement`
range les soldes en colonne « Amortissements/Provisions » du bilan.

L'écran contient :
- `colcol` (ColumnView, 5 colonnes : rubrique, intitulé de la rubrique, début, fin, drapeau
  amortissement) ;
- les champs `Numrub`, `Intitule` (lecture), `Cpt1`, `Cpt2`, la case `Amortissement` ;
- `Rublist` (ColumnView masquée), liste des rubriques de type `L` ouverte par `ToggleButton1` ou F2 ;
- les boutons du groupe `Btn` : `Button4` (aide, tag 1), `Button1` (supprimer, tag 2),
  `Button2` (enregistrer, tag 3), `Button3` (quitter, tag 4).

Les champs de saisie sont dans le groupe `Lib` (tags 1 à 3) : `Lib_KeyPress` enchaîne la saisie
au clavier. Le fichier est presque identique à [Rubresult](../Rubresult.class/architecture.md)
(même squelette, même gestion du focus et des boutons).

Nature globale : **GUI avec SQL direct dans les handlers** (aucune fonction de calcul isolée).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Rubs` | var | Private |  | Result | 28 |
| `rResult` | var | Private |  | Result | 29 |
| `b` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-54 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 56-75 | Public | 6 | 17 | 0 | handler GUI |
| `Maj_Zones` | 77-91 | Public | 2 | 13 | 0 | portée réductible ? |
| `CleanChamps` | 93-101 | Public | 1 | 5 | 0 | portée réductible ? |
| `Refresh` | 103-108 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 110-170 | Public | 14 | 53 | 0 | handler GUI |
| `Btn_KeyPress` | 172-181 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 183-201 | Public | 5 | 12 | 0 | handler GUI |
| `Lib_GotFocus` | 206-212 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 214-230 | Public | 4 | 14 | 0 | portée réductible ? |
| `Button2_Click` | 232-262 | Public | 9 | 28 | 0 | portée réductible ? |
| `Button3_Click` | 264-268 | Public | 1 | 3 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 273-303 | Public | 4 | 28 | 0 | handler GUI |
| `RubList_Click` | 308-317 | Public | 1 | 8 | 0 | handler GUI |
| `RubList_KeyPress` | 322-342 | Public | 6 | 17 | 0 | handler GUI |
| `Rubman` | 347-368 | Public | 4 | 19 | 0 | portée réductible ? |
| `Rubman2` | 373-383 | Public | 2 | 8 | 0 | portée réductible ? |
| `Button4_Click` | 385-389 | Public | 1 | 3 | 0 | portée réductible ? |
| `colcol_Click` | 391-395 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et liste

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Enregistre les observateurs de
  replay (`Utils.Observers`), centre la fenêtre, configure les 5 colonnes de `colcol` et place le
  focus sur `Numrub`. Remet à 0 le drapeau `b`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. `SELECT * FROM
  Fiches_RubCompt order by numrub`, puis une ligne par plage avec la clé `numrub & compte1`
  (l'ajout est protégé par `Try` : une clé en double est ignorée silencieusement). Pour chaque
  ligne, `Rubman2` lit l'intitulé de la rubrique : **une requête par ligne** (N+1, 364 plages dans
  `Laurux01.sql`). Le drapeau `amortissement` est recopié tel quel dans la colonne 4 (texte `T`
  pour un booléen vrai sous MySQL ; valeur `1`/`0` probable sous SQLite, à confirmer).
  Partie extractible : la lecture des plages et des intitulés (une jointure).
- **`Refresh()`** [portée : réductible, voir réserve] [nature : GUI]. Vide `colcol` et rappelle
  `Form_Open`. ⚠️ Le nom masque la méthode `Refresh` héritée de `Form` : un passage en `Private`
  doit être vérifié par `gbc3` (redéfinition d'une méthode héritée), un renommage est plus sûr.
- **`Rubman2()`** [portée : réductible] [nature : calcul + écriture dans la grille]. Lit
  `Fiches_Rubriques` pour `rResult!numrub` (variable **de classe** partagée avec `Form_Open`) et écrit
  l'intitulé dans `Colcol.Item[1]`.

### Saisie

- **`colcol_Click()`** [portée : nécessaire (handler)] [nature : GUI] → `Maj_Zones`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI]. Recopie la ligne courante dans les
  champs. ⚠️ La case `Amortissement` est lue dans `Colcol.Item[4]` (curseur interne de la grille,
  positionné sur la dernière ligne ajoutée ou sur la dernière cible de `MoveTo`) et non dans
  `Colcol.Current[4]` : l'état affiché est probablement celui d'une autre ligne (anomalie
  RUBCOMPT-A01, à confirmer à l'exécution).
- **`CleanChamps()`** [portée : réductible] [nature : GUI]. Vide `Cpt1`, `Cpt2` et décoche la case
  (le numéro et l'intitulé de rubrique sont conservés, lignes commentées).
- **`Lib_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée/Retour/Tab :
  - tag 1 (`Numrub`) : `Rubman` contrôle la rubrique ; si elle existe, focus sur `Cpt1`, sinon
    retour sur `Numrub` (`b` remis à 0) ;
  - tag 2 (`Cpt1`) : `Cpt2 = Cpt1 & String$(8 - Len(Cpt1), "9")` (fin de plage proposée : `601`
    → `60199999`) ; un `Cpt1` de plus de 8 caractères donne un nombre négatif à `String$` (erreur
    probable, à confirmer) ;
  - tag 3 (`Cpt2`) : focus sur `Button2`.
  F1 ouvre l'aide (`Button4_Click`), F2 sur `Numrub` ouvre la liste des rubriques.
- **`Rubman()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Rubriques where
  numrub = &1` ; si trouvée, recopie numéro et intitulé (la variable locale `typeL` est affectée
  mais inutilisée) ; sinon son + `Message.Warning("Cette rubrique n'existe pas !!!")` et `b = 1`.
  Le résultat est rangé dans la variable de classe `Rubs`.
- **`ToggleButton1_Click()`** [portée : nécessaire (handler, appelé aussi par F2)] [nature : mixte].
  Bascule l'affichage de `Rublist` ; à l'ouverture, `SELECT * FROM Fiches_Rubriques where type =
  'L' order by numrub` et remplissage (boucle `Do … Loop Until`). Partie extractible : la requête.
- **`RubList_Click()` / `RubList_KeyPress()`** [portée : nécessaire (handlers)] [nature : GUI].
  Sélection d'une rubrique (clic ou Entrée) → champs remplis, liste fermée, focus sur `Cpt1` ;
  Échap/F2 ferment la liste ; F1 ouvre l'aide.

### Boutons

- **`Btn_Click()`** [portée : nécessaire (handler de groupe)] [nature : GUI]. Tag 1 → aide, 2 →
  `Button1_Click`, 3 → `Button2_Click`, 4 → `Me.Close`.
- **`Btn_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. **Toute** touche pressée sur
  le bouton de tag 3 (`Button2`) enregistre, y compris Tab ou Échap (anomalie RUBCOMPT-A05).
- **`Button1_Click()`** (supprimer) [portée : nécessaire (appelé par `Btn_Click`)] [nature : mixte].
  Si `Numrub` est renseigné : son, `Message.Question` puis `DELETE FROM Fiches_RubCompt WHERE numrub
  = &1 and compte1 = &2` avec **la rubrique de la ligne sélectionnée** (`colcol.Current[0]`) et **le
  compte saisi** (`Cpt1.Text`) ; erreur si aucune ligne n'est sélectionnée (anomalie RUBCOMPT-A02).
- **`Button2_Click()`** (enregistrer) [portée : nécessaire] [nature : mixte]. Si `Numrub` est
  renseigné : `SELECT` sur la clé ; absent → `Try INSERT` (en cas d'erreur, `Message.Info("Veuillez
  saisir les données…")`) ; présent → `UPdate … SET numrub, compte1, compte2, amortissement WHERE
  numrub = &1 and compte1 = &2`. Puis rafraîchit la liste et repositionne la sélection (`Try MoveTo`).
  Sans numéro : `Message.Warning`. Partie extractible : `EnregistrePlage(numrub, cpt1, cpt2, amort)`.
- **`Button3_Click()`** [portée : handler nominal inactif] — **code mort** : `Button3` appartient au
  groupe `Btn` du `.form` (`{ Button3 Button Btn`, tag 4) ; Gambas n'envoie l'événement qu'au
  groupe (`Btn_Click`, cas 4 → `Me.Close`). Aucun appel explicite (`grep -rn Button3_Click` : aucune
  occurrence hors définition dans ce fichier) ; `ReplayObserver.Replay_Click` déclenche un bouton
  par `ctx.Value = True` (événement de groupe) et n'utilise `Object.Call(… & "_Click")` que pour
  les grilles et listes. Suppression sans effet de bord.
- **`Button4_Click()`** [portée : nécessaire] [nature : GUI]. `Doc.Open("Rubscpts")`.
- **`Lib_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor`.

### SQL émis (récapitulatif)

| Fonction | Requête | Table |
|---|---|---|
| `Form_Open` | `SELECT * … order by numrub` | `Fiches_RubCompt` |
| `Rubman2` (par ligne), `Rubman` | `SELECT * … where numrub = &1` | `Fiches_Rubriques` |
| `ToggleButton1_Click` | `SELECT * … where type = 'L' order by numrub` | `Fiches_Rubriques` |
| `Button1_Click` | `DELETE … WHERE numrub = &1 and compte1 = &2` | `Fiches_RubCompt` |
| `Button2_Click` | `SELECT` / `INSERT` / `UPdate` sur la clé | `Fiches_RubCompt` |

Les noms de tables sont écrits en dur (`Tab = "Fiches_RubCompt"`) : `Cbase` ne définit pas de clé
pour `Fiches_RubCompt` ni `Fiches_Rubriques`.

## État global utilisé

- `Start.Son` (initialiseur `son`), `Music` (son d'alerte ; `Music.Load` n'est **pas** appelé
  ici, contrairement à `Rubresult` : le son joué est celui chargé par le dernier écran).
- `Utils.Observers`, `Utils.SetEditColor`, `Utils.db`.
- Variables de classe `Rubs`, `rResult` (résultats partagés entre `Form_Open`, `Rubman2`,
  `Rubman`, `Button2_Click`, `ToggleButton1_Click`) et `b` (drapeau « rubrique inconnue »).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la boucle `Form_Open` + `Rubman2` par une seule requête `SELECT c.*, r.intitule FROM
  Fiches_RubCompt c LEFT JOIN Fiches_Rubriques r ON r.numrub = c.numrub ORDER BY c.numrub`
  (lecture seule ; l'ordre secondaire des plages d'une même rubrique est à fixer pour rester
  identique à l'ordre actuel, qui dépend du moteur : ajouter `c.compte1` seulement si le replay le
  confirme).
- `rResult` et `Rubs` deviennent des variables locales ; `Rubman2` reçoit `numrub` en paramètre.
- `Lib_KeyPress` : extraire la fin de plage proposée dans une fonction pure `FinPlage(sCpt1)`.

### Commonalisation avec d'autres fichiers

- [Rubresult](../Rubresult.class/architecture.md) : même squelette (`_New`, `Lib_GotFocus`,
  `Btn_Click`, `Btn_KeyPress`, `Refresh`, `CleanChamps`, `Rubman`, enregistrement
  `SELECT`/`INSERT`/`UPdate`). Une fonction commune `LitRubrique(numrub) As Result` (lecture
  `Fiches_Rubriques`) sert à `Rubman`, `Rubman2` et `Rubresult.Rubman`.
- Ajouter deux clés `Cbase` (`TabRubriques`, `TabRubCompt`) utilisées aussi par
  [Rubresult](../Rubresult.class/architecture.md), [Exprub](../Exprub.class/architecture.md),
  [Imp_Bilan](../../Impressions/Imp_Bilan.module/architecture.md),
  [Imp_Sig](../../Impressions/Imp_Sig.module/architecture.md) et
  [RubImp](../../Impressions/RubImp.class/architecture.md) (SQL émis identique).

### Réduction de portée

- `Maj_Zones`, `CleanChamps`, `Rubman`, `Rubman2` : aucun appelant externe (vérifié par `grep`),
  passage en `Private`. `Refresh` : voir la réserve ci-dessus. Les handlers (`Form_Open`,
  `Btn_*`, `Lib_*`, `Button*_Click`, `RubList_*`, `ToggleButton1_Click`, `colcol_Click`) restent
  `Public`.

### Séparation traitement / GUI

- `EnregistrePlage(sRub, sCpt1, sCpt2, bAmort) As Boolean` (SELECT + INSERT/UPdate, renvoie faux
  si l'INSERT échoue), `SupprimePlage(sRub, sCpt1)`, `ListePlages() As Result`,
  `RubriquesLignes() As Result` : sans accès aux contrôles, appelées par les handlers, qui gardent
  messages, son et focus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Contrainte de clé étrangère `Fiches_RubCompt.numrub` → `Fiches_Rubriques.numrub` (aujourd'hui,
  supprimer une rubrique laisse ses plages orphelines, voir RUBRESULT-A04).
- Stocker `compte1`/`compte2` sur une longueur fixe ou en numérique pour que la comparaison de
  plage ne dépende pas de l'ordre des chaînes.
