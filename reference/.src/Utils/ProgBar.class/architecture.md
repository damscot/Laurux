# ProgBar — Architecture

> Source : `.src/Utils/ProgBar.class` · Formulaire : `.src/Utils/ProgBar.form`

## Vue d'ensemble

`ProgBar` est la **fenêtre de progression** commune de Laurux : titre (`Title`), barre
(`ProgressionBar`), compteur « n / total » (`elemdone`), journal optionnel (`DetailLog`) et boutons
`Pause`/`Stop`. Les traitements longs (migrations `LauruxMaj`, clôtures, purges `Raz*`,
moulinage, GED, `DB_Sanity`…) l'instancient, l'affichent, puis appellent `Avancement()` à chaque
élément ; la valeur renvoyée indique que l'utilisateur a demandé l'arrêt.

Constructeur (vérifié par une expérience `gbx3` 3.19 sur une classe héritée) : les arguments
obligatoires `Titre`, `nbelem` vont à `ProgBar._New`, le **troisième argument** va au
constructeur de `Window` (fenêtre parente, `Null` ou `Windows[…]`), puis les optionnels
`Stopable`, `unit`, `detail`. D'où la forme d'appel `New ProgBar("titre", n, Null, True, "", True)`.

Nature : **GUI** (aucun SQL) ; `Avancement` contient une petite logique de cadence et de pause.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$nbelem` | var | Private |  | Integer | 3 |
| `$curelem` | var | Private |  | Integer | 4 |
| `$refresh` | var | Private |  | Integer | 5 |
| `$unit` | var | Private |  | String | 6 |
| `$paused` | var | Private |  | Boolean | 7 |
| `$stopped` | var | Private |  | Boolean | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 11-23 | Public | 1 | 10 | 0 | méthode spéciale |
| `Form_Open` | 25-30 | Public | 1 | 4 | 0 | handler GUI |
| `Form_Close` | 32-42 | Public | 4 | 9 | 0 | handler GUI |
| `Enable_Detail` | 44-48 | Public | 1 | 3 | 1 |  |
| `Disable_Detail` | 50-54 | Public | 1 | 3 | 0 | portée réductible ? |
| `IsStoppable` | 56-60 | Public | 1 | 3 | 1 |  |
| `Avancement` | 63-81 | Public | 4 | 15 | 24 |  |
| `Pause_Click` | 83-93 | Public | 2 | 9 | 0 | handler GUI |
| `Stop_Click` | 95-101 | Public | 1 | 5 | 0 | handler GUI |
| `Finalize` | 103-110 | Public | 1 | 6 | 3 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Titre, nbelem, Stopable, unit, detail)`** [portée : nécessaire] [GUI]. Fixe le titre,
  le total, la visibilité du journal et du bouton Stop, réinitialise pause/arrêt et rend la fenêtre
  `Persistent` (elle survit à `Close` pour que l'arrêt soit lu par `Avancement`).
  ⚠️ Le paramètre `unit` n'est **jamais recopié** dans `$unit` : l'unité n'est jamais affichée
  (sans effet aujourd'hui, tous les appelants passent `""` ou rien).
- **`Form_Open()`** [handler] [GUI]. `Utils.Observers(Me)` et compteur initial.
- **`Form_Close()`** [handler] [GUI]. Si Stop est visible : marque l'arrêt (`$stopped`). Sinon,
  empêche la fermeture tant que le traitement n'est pas terminé (`Stop Event` si
  `$nbelem <> 0` et `$curelem <> $nbelem`).
- **`Enable_Detail()` / `Disable_Detail()`** [Public ; `Enable_Detail` utilisé par `Anomalies`,
  `Disable_Detail` **sans appelant**] [GUI]. Affiche/masque le journal.
- **`IsStoppable(Val)`** [Public, utilisé par `Anomalies`] [GUI]. Affiche/masque Stop.
- **`Avancement(Info, refresh_increment) As Boolean`** [portée : nécessaire, 25 appelants]
  [nature : mixte]. Incrémente le compteur ; tous les `refresh_increment` appels, met à jour la
  barre (`$curelem / $nbelem`), ajoute `"<pourcentage>% :  <Info>"` au journal s'il est visible,
  met à jour le compteur, attend tant que la pause est active (`Wait 0.1`) puis `Wait 0.05`
  (rafraîchissement de l'interface). Renvoie `$stopped`.
  ⚠️ Le test `$refresh = refresh_increment` (et non `>=`) ne rafraîchit plus jamais si l'appelant
  diminue l'incrément en cours de route ; ⚠️ `$nbelem = 0` provoque une division par zéro si
  `Avancement` est appelé (les appelants à 0 n'appellent pas `Avancement`, vérifié).
- **`Pause_Click()`** [handler] [GUI]. Bascule pause/reprise et le libellé.
- **`Stop_Click()`** [handler] [GUI]. Demande l'arrêt, lève la pause.
- **`Finalize()`** [Public, utilisé par `LauruxMaj`, `FClotureAn`, `Sha1Calc`] [GUI]. Marque le
  traitement terminé (`$curelem = $nbelem`) : la fenêtre peut alors être fermée.

## Événements gérés

`Form_Open`, `Form_Close`, `Pause_Click`, `Stop_Click` (noms intouchables).

## État global utilisé

- `Utils.Observers`. Aucun autre état global.

## Propositions d'amélioration

### Réécriture / refactorisation

- Recopier `unit` dans `$unit` (comportement identique pour tous les appelants actuels, qui passent
  `""`).
- Helper privé `MajCompteur()` pour le texte `elemdone` (dupliqué dans `Form_Open` et
  `Avancement`).

### Commonalisation avec d'autres fichiers

- Aucun autre composant de progression dans le dépôt : `ProgBar` est déjà le point commun. Les
  appelants répètent l'idiome `PB = New ProgBar(…)` / `PB.Show` / `If PB.Avancement() Then …` /
  `PB.Close` ; une méthode statique `ProgBar.Lance(titre, n, …) As ProgBar` (création + `Show`)
  réduirait ce code, mais toucherait 27 appelants : à arbitrer en phase 3.

### Réduction de portée

- `Disable_Detail` : aucun appelant (vérifié par `grep -rn Disable_Detail`) → suppression (code
  mort) plutôt que `Private`.
- Les autres membres `Public` sont utilisés.

### Séparation traitement / GUI

- Le calcul de la cadence et du pourcentage peut devenir une fonction pure
  (`Pourcentage(cur, nb) As Integer`), testable en gb.test ; le reste est purement GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
