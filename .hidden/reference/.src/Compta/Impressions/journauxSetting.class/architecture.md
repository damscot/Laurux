# journauxSetting — Architecture

> Source : `.src/Compta/Impressions/journauxSetting.class`

## Vue d'ensemble

`journauxSetting` est la boîte modale **« Colonnes d'export »** ouverte depuis l'écran
[`Journaux`](../Journaux.class/architecture.md) (bouton « Préférences Colonnes export »,
`journauxSetting.ShowModal`). Elle configure l'ordre des colonnes du fichier
`~/tmp/journaux.txt` produit par `Journaux.Button4_Click`.

- `ListBox1` : les 12 champs disponibles (« Code journal », « Compte », « Libellé du compte »,
  « Numéro document », « Date de l'écriture », « Numéro écriture (provisoire) », « Libellé de
  l'écriture », « Debit », « Credit », « Solde ligne », « Observation », « Colonne Vide »).
- `ListBox2` : les colonnes retenues, dans l'ordre ; ajout par double-clic ou glisser-déposer,
  retrait par double-clic.
- « Valider » écrit, pour chaque position `i` de `ListBox2`, `Start.LocalSettings`
  `/ExportJournal<société>/Entete<i>` = indice du champ (0 à 11, celui du tableau `p[]` de
  `Journaux`) et `/Titre<i>` = libellé ; les positions suivantes jusqu'à 15 reçoivent `" "`.

Le contrat avec `Journaux` est donc : **libellé ↔ indice** (12 couples, définis en double ici :
liste de `Form_Open` et `Select Case` de `BtnValider_Click`) et la valeur `" "` pour « absent ».

Nature globale : **GUI** ; seul traitement : l'écriture de la configuration locale.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dragText` | var | Private |  | Variant | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `BtnValider_Click` | 5-56 | Public | 16 | 46 | 0 | handler GUI |
| `ListBox1_MouseDrag` | 59-66 | Public | 2 | 6 | 0 | handler GUI |
| `ListBox2_MouseDrag` | 68-75 | Public | 2 | 5 | 0 | handler GUI |
| `ListBox1_Drop` | 78-82 | Public | 1 | 3 | 0 | handler GUI |
| `listbox2_Drop` | 84-88 | Public | 1 | 3 | 0 | handler GUI |
| `ListBox1_DblClick` | 90-94 | Public | 1 | 3 | 0 | handler GUI |
| `ListBox2_DblClick` | 96-100 | Public | 1 | 3 | 0 | handler GUI |
| `testColonne` | 102-131 | Public | 6 | 26 | 0 | portée réductible ? |
| `Form_Open` | 133-162 | Public | 4 | 24 | 0 | handler GUI |
| `BtnAnnuler_Click` | 164-168 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. Observateurs, son,
  centrage ; remplit `ListBox1` avec les 12 libellés et `ListBox2` avec les titres configurés
  (`/Titre0..15` différents de `" "` et de `Null`).
- **`BtnValider_Click()`** (CC 16, max du fichier) [portée : nécessaire] [nature : mixte].
  Si `ListBox2` n'est pas vide : pour chaque ligne, `Select Case` libellé → indice, écriture de
  `Entete<i>` et `Titre<i>` ; positions restantes jusqu'à 15 à `" "`. Puis
  `Start.LocalSettings.Save` et fermeture. Si `ListBox2` est vide, **rien n'est écrit** mais la
  sauvegarde a lieu (A01). Variables `trouver` et `dragText` (réutilisée comme compteur)
  inutiles.
- **`ListBox1_MouseDrag()` / `ListBox2_MouseDrag()`** [nature : GUI]. Démarre un glisser du
  texte sélectionné (bouton gauche).
- **`ListBox1_Drop()`** [nature : GUI]. Ajoute le texte déposé à `ListBox1` sans contrôle
  (doublons possibles, A02). **`listbox2_Drop()`** : `testColonne(Drag.data)`.
- **`ListBox1_DblClick()`** : `testColonne` du libellé cliqué. **`ListBox2_DblClick()`** :
  retire la ligne.
- **`testColonne(textinclus)`** [portée : réductible] [nature : GUI]. Ajoute à `ListBox2` si le
  libellé n'y est pas déjà (sinon « colonne déjà utilisée ») et si `ListBox2.Count < 13` (sinon
  « Le maximum de colonnes est atteint » : inatteignable avec 12 libellés distincts). Déclarée
  `Function` sans type ni valeur de retour.
- **`BtnAnnuler_Click()`** [nature : GUI]. Ferme sans enregistrer.

## État global utilisé

- `Start.LocalSettings["/ExportJournal" & Start.Societe & "/Entete<i>"|"/Titre<i>"]`, `Save`.
- `Start.Musique` (`Music.Load`), `Utils.Observers`, `Drag`, `Mouse`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Un tableau constant privé des 12 libellés, dont l'indice est la valeur `Entete` : remplit
  `ListBox1` et remplace le `Select Case` (mêmes clés et valeurs écrites).
- Supprimer `trouver`, `listtext` inutiles ; variable locale entière pour le compteur au lieu de
  `dragText`.

### Commonalisation avec d'autres fichiers

- Les clés `/ExportJournal<soc>/…` sont lues par `Journaux.Colonnes` et
  `Journaux.Button4_Click` : un helper partagé (par exemple `ImpCompta.ColonnesExport() As
  Integer[]` et `ImpCompta.TitresExport() As String[]`) garantirait le même contrat des deux
  côtés (voir [Journaux](../Journaux.class/architecture.md), JOURNAUX-006).
- Le motif « deux listes avec glisser-déposer » n'a pas d'équivalent factorisable trouvé.

### Réduction de portée

- `testColonne` → `Private` (aucun appelant externe).

### Séparation traitement / GUI

- `EnregistreColonnes(sTitres As String[])` sans accès aux contrôles, appelée par
  `BtnValider_Click` avec le contenu de `ListBox2`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Configuration stockée dans le fichier local du poste : la partager par société via le blob
  `conf` de `Fiches_Parametres`.
