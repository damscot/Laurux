# Ligext — Architecture

> Source : `.src/Compta/Relances/Ligext.class`

## Vue d'ensemble

`Ligext` est un **formulaire embarqué** (une ligne graphique) qui représente **une ligne d'extrait de
compte** client dans l'écran de préparation des relances [`FEditrel`](../FEditrel.class/architecture.md).
Les lignes sont créées par [`Ligcli.visext`](../Ligcli.class/architecture.md) dans `ScrollView2`
de `FEditrel`, une par écriture renvoyée par `Listextcpt.resext`.

La case `CheckBox1` indique si l'écriture figure dans la table de travail `Fiches_relances`
(relance à envoyer). La cocher insère la ligne dans `Fiches_relances` ; la décocher la supprime.

Construction : `New Ligext(rescli, resext, ind, $scr)` — les trois premiers arguments vont à
`_new`, le dernier (`ScrollView` parent) au constructeur hérité du formulaire.

Nature globale : **mixte** (affichage + écriture SQL sur la table de travail).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `selection` | property | Public |  | Boolean | 3 |
| `$rescli` | var | Private |  | Result | 5 |
| `$resext` | var | Private |  | Result | 6 |
| `$ind` | var | Private |  | Integer | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-36 | Public | 3 | 18 | 0 | méthode spéciale |
| `CheckBox1_Click` | 38-70 | Public | 3 | 30 | 0 | handler GUI |
| `selection_Read` | 72-76 | Private | 1 | 3 | 0 |  |
| `selection_Write` | 78-86 | Private | 2 | 6 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(rescli, resext, ind)`** [spéciale] [mixte]. Mémorise les deux `Result` (fiche client
  `Fiches_Cli` et extrait de compte) et l'index de la ligne, se place sur la ligne (`MoveTo`) et
  remplit les libellés : dates (`dte`, `dateech` sous `Try`), libellé, document, lot, débit/crédit
  (`Format "0.00"`), numéro d'écriture, journal. Puis `SELECT * FROM Fiches_relances WHERE lind=&1` :
  si la ligne existe, `CheckBox1.Value = True`. Si l'affectation programmatique lève `Click`
  (comportement Gambas à confirmer), `CheckBox1_Click` tenterait de réinsérer une ligne déjà
  présente (clé `(compte, lind)`) ; aucun symptôme n'est connu, ce qui laisse penser que ce
  n'est pas le cas.
- **`CheckBox1_Click()`** [handler] [mixte]. `Utils.db.Begin` ; se replace sur la ligne de l'extrait ;
  - cochée : `Utils.db.Create9("Fiches_relances")` puis recopie champ par champ (compte, raison
    sociale, nom, adresse, date, document, lot, libellé, montants, numéro, journal,
    `niveau = relance`, `lind`) et `Update` ;
  - décochée : `DELETE FROM Fiches_relances WHERE lind=&1`.
  `Utils.db.Commit`. Pas de gestion d'erreur : une erreur laisse la transaction ouverte.
  Différences avec l'insertion faite par `FEditrel.Button1_Click` : `intitule` = `cli_nom` seul (et
  non `cli_nom & " " & cli_pnm`), `niveau` = `relance` brut (et non `relance + 1` borné à 3).
- **`selection_Read()` / `selection_Write(Value)`** [propriété `selection`] [GUI]. Lecture/écriture
  de `CheckBox1.Value`. Dans `selection_Write`, `av` reçoit `Value` puis est comparé à `Value` :
  le test `av <> Value` est toujours faux, l'appel explicite à `CheckBox1_Click` est du code mort.
  L'écriture SQL dépend donc uniquement de l'événement `Click` levé (ou non) par l'affectation
  (à confirmer). Utilisée par `FEditrel.CheckBox2_Click` (« tout cocher » les lignes d'extrait).

Portée : `_new`, `CheckBox1_Click` et la propriété `selection` [portée : nécessaire] (la propriété
est lue via un `Variant` dans `FEditrel`).

## État global utilisé

- `Utils.db` (`Exec`, `Create9`, `Begin`, `Commit`).
- Table de travail `Fiches_relances`, créée par `FEditrel.Button1_Click` (et `FPrepRel2`), absente de
  `db_control.csv` et de `Laurux01.sql`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la variable `av` et le test mort de `selection_Write` (comportement identique).
- Supprimer le bloc de commentaires mort de `_new` (lignes 17-22).
- `CheckBox1_Click` : `Catch` avec `Utils.db.Rollback` (anomalie, car cela change le comportement en
  cas d'erreur).

### Commonalisation avec d'autres fichiers

- L'insertion d'une ligne dans `Fiches_relances` existe en trois variantes :
  [`FEditrel.Button1_Click`](../FEditrel.class/architecture.md) (INSERT paramétré),
  [`FPrepRel2.Button1_Click`](../FPrepRel2.class/architecture.md) (mort) et ici (`Create9`). Une
  fonction commune `AjouteRelance(rescli, resext, niveau)` (module de relances à créer) fixerait les
  règles (`intitule`, `niveau`) ; l'harmonisation change les données écrites : voir LIGEXT-A02.
- Remplissage des libellés identique au pattern d'affichage d'extrait de
  [`Listextcpt`](../../Utils/Listextcpt.class/architecture.md).

### Réduction de portée

- Rien.

### Séparation traitement / GUI

- `_new` : extraire `EstRelancee(lind) As Boolean` ; `CheckBox1_Click` : extraire
  `Inscrit(rescli, resext)` / `Desinscrit(lind)` sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_relances` est une table de travail recréée à chaque génération (`DROP`/`CREATE`) ; une
  table permanente déclarée dans le schéma (avec `user`/`machine` pour le multi-poste) éviterait
  les collisions entre deux utilisateurs qui préparent des relances en même temps.
