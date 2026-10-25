# Visucmat — Architecture

> Source : `.src/Gestion/option/Visucmat.class`

## Vue d'ensemble

Écran **« Visualisation de la compta matière »** (option boissons) : liste filtrable et triable
des mouvements d'entrée (`E`) et de sortie (`S`) de `Fiches_ligregie` entre deux dates (`dtdeb`,
`dtfin`), affichée par le composant générique `TriGen` dans `Panel1`. Lecture seule. Ouvert par
le bouton « Visu » de [Caleditcmat](../Caleditcmat.class/architecture.md)
(`Caleditcmat.Visu_Click`, `Visucmat.Show`).

Colonnes (via `ObjProp`) : date, document, vignette, E/S, article, régie, quantité, volume,
degré, volume d'alcool pur, droits, sécurité sociale. `Fiches_ligregie` est créée à l'exécution
par [`modfichier.fichierboisson`](../modfichier.module/architecture.md) (hors `db_control.csv`,
hors `Cbase`). Aucune table `*M` du matériel n'est concernée.

Nature : **GUI** (requêtes de lecture seulement).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | String | 4 |
| `$tr` | var | Private |  | TriGen | 6 |
| `$col` | var | Private |  | New Collection | 7 |
| `$prop` | var | Private |  | ObjProp | 8 |
| `$res` | var | Private |  | Result | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-80 | Public | 2 | 54 | 0 | méthode spéciale |
| `Form_Open` | 82-91 | Public | 1 | 7 | 0 | handler GUI |
| `dte` | 93-100 | Private | 1 | 5 | 0 |  |
| `coltri_MajSel` | 102-106 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 108-112 | Public | 1 | 3 | 0 | handler GUI |
| `dtdeb_LostFocus` | 114-119 | Public | 1 | 4 | 0 | handler GUI |
| `dtfin_LostFocus` | 121-126 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] : chaînage de saisie
  `dtdeb` → `dtfin` → `Button1` ; `SELECT arrete FROM Fiches_Parametres` puis
  `dtdeb.Text = "01." & res!arrete` **sans test `Available` ni de valeur nulle** : si l'arrêté
  n'est pas renseigné (option boissons non paramétrée), la date de début est invalide (« 01. »,
  comportement de `TextReg` à confirmer). L'arrêté est stocké en `char(7)` ; `Einvmat` et
  `Ecomptamat` le lisent comme `MM?AAAA` (mois à gauche, année à droite) : le format exact du
  séparateur, et donc le résultat de `"01." & arrete`, est à confirmer. Ensuite
  `SELECT * FROM Fiches_ligregie LIMIT 1` sert uniquement à obtenir la description des champs
  pour les 12 `ObjProp` ; **si la table est vide, `_new` sort avant de définir les colonnes**
  (`TriGen` est alors créé avec une collection vide, comportement à confirmer).
  `LIMIT` n'est pas traduit pour SQLite, mais SQLite l'accepte nativement.
- **`Form_Open()`** [handler] [nature : mixte] : `New TriGen(Panel1, $col, $res,
  "SELECT * FROM Fiches_ligregie", 20, Me) As "coltri"`, filtre supplémentaire
  `(type='S' or type='E') AND dtmouv BETWEEN …` via `ExtraSel`, affichage.
- **`dte()`** [Private] [nature : calcul] : `Utils.db.Subst(" dtmouv BETWEEN &1 AND &2",
  dtdeb.dte.D, dtfin.dte.D)` ; à l'ouverture `dtfin` est vide (valeur produite par
  `LDate.D` vide à confirmer : liste probablement vide tant que la date de fin n'est pas saisie).
- **`coltri_MajSel(Bval)`** [handler de l'événement `MajSel` de `TriGen`] : `Stop Event` → la
  sélection d'une ligne ne ferme pas la vue (consultation seule).
- **`dtdeb_LostFocus()` / `dtfin_LostFocus()`** [handler] [nature : mixte] : recalculent le filtre
  et `$tr.Update` (corps identiques).
- **`Button1_Click()`** [handler] : « Quiter » → `Me.Close`.

Variables `Public` `Bsel` et `Bval` : écrites par `TriGen` via
`Object.SetProperty(Obj, "Bsel"/"Bval", …)` (`TriGen.class:228-232`) ; elles doivent rester
`Public` même si personne ne les lit ici.

## État global utilisé

- `Utils.db` (`Exec`, `Subst`) ; aucun `Start.*`.
- **Pas d'`Utils.Observers(Me)`** : écran non journalisé ; les saisies de dates ne sont pas
  rejouables en l'état (voir test.md).

## Propositions d'amélioration

### Réécriture / refactorisation

- `dtdeb_LostFocus` et `dtfin_LostFocus` : corps identiques → `Private Sub Filtre()` appelé par
  les deux handlers (et par `Form_Open`, qui contient la même expression).
- Colonnes : les 12 blocs `k = … ; New ObjProp ; AddChamp ; $Col.Add` peuvent être décrits par
  un tableau (champ, titre, alignement) parcouru en boucle.

### Commonalisation avec d'autres fichiers

- Écran « liste `TriGen` filtrée par période » : même schéma que d'autres consultations (grille
  filtrable relevée sur ~30 écrans dans les lots précédents) ; la saisie d'une période
  (`dtdeb`/`dtfin` + `LostFocus`) est l'idiome « calendrier/période » déjà proposé à la
  commonalisation (notes transverses, lot Gestion-1).
- La lecture de `Fiches_Parametres.arrete` et le calcul de l'exercice matières sont faits
  différemment ici (début = mois de l'arrêté) et dans [Einvmat](../Einvmat.class/architecture.md)
  / [Ecomptamat](../Ecomptamat.class/architecture.md) (début = mois suivant l'arrêté) : une
  fonction commune `DebutExerciceMatieres() As Date` trancherait (VISUCMAT-A02).

### Réduction de portée

Rien à réduire : `Bsel`/`Bval` sont écrits par `TriGen` (`Object.SetProperty`), les autres membres
`Public` sont des handlers ou le constructeur.

### Séparation traitement / GUI

`Filtre()` (ci-dessus) concentre la seule construction SQL ; elle lit les contrôles de dates,
qu'on peut passer en paramètres (`FiltrePeriode(dDeb, dFin) As String`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker l'arrêté de la comptabilité matières en `DATE` (au lieu de `char(7)`) supprimerait les
  conversions divergentes.
- Index `(type, dtmouv)` sur `Fiches_ligregie`.
