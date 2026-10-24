# FCollectif — Architecture

> Source : `.src/Compta/Tables/FCollectif.class`

## Vue d'ensemble

Écran des **comptes collectifs** : liste des comptes `Fiches_Comptes` avec `coll = 1`, saisie code
/ intitulé / type, enregistrement et suppression. Un collectif doit commencer par `401`, `411` ou
`453` ; il est créé avec `coll = 1`, `cent_cc = 1` et `solde = 0`. Le type est forcé à `B` en
saisie (`typeco` en lecture seule) ; `Maj_Zones` affiche le type réel du compte sélectionné.

Ouvert par `Fmenu.Menu111_Click` (`Fcollectif.show`).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `n` | var | Private |  | Integer | 25 |
| `son` | var | Private |  | Integer | 26 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-42 | Public | 1 | 13 | 0 | méthode spéciale |
| `Form_Open` | 44-62 | Public | 3 | 16 | 0 | handler GUI |
| `Maj_Zones` | 64-71 | Public | 1 | 6 | 0 | portée réductible ? |
| `CleanChamps` | 73-79 | Public | 1 | 5 | 0 | portée réductible ? |
| `Refresh` | 81-86 | Public | 1 | 4 | 0 | portée réductible ? |
| `Col_KeyPress` | 88-110 | Public | 8 | 20 | 0 | handler GUI |
| `Col_GotFocus` | 115-121 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 123-136 | Public | 5 | 12 | 0 | handler GUI |
| `Colcol_Click` | 138-145 | Public | 2 | 6 | 0 | handler GUI |
| `cptman` | 147-160 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 162-195 | Public | 7 | 31 | 0 | portée réductible ? |
| `Button2_Click` | 197-237 | Public | 10 | 38 | 0 | portée réductible ? |
| `Button4_Click` | 239-243 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : observateurs, son, 8 colonnes déclarées dont
  3 utilisées.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_Comptes where coll = '1'
  order by cast(compte_cc AS char)` ; compte les lignes dans `n` (jamais remis à zéro par `Refresh`,
  ne sert qu'à savoir si la liste a été remplie au moins une fois) ; type `B` en lecture seule.
- **`Maj_Zones()`**, **`CleanChamps()`**, **`Refresh()`** [portée : réductible] [nature : GUI] :
  recopie de la ligne courante, effacement des zones (type remis à `B`), rechargement.
- **`Col_KeyPress()`** [handler, groupe `Col`] : Entrée/Tab code → `cptman` + intitulé → type →
  enregistrement ; F1 aide.
- **`Col_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer, 4 fermer.
- **`Colcol_Click()`** [handler] : `Maj_Zones` si `n > 0`.
- **`cptman()`** [portée : réductible] [nature : mixte] : `SELECT * FROM Fiches_Comptes where
  compte_cc = &1` ; recopie intitulé et type si le compte existe (quel que soit son type).
- **`Button1_Click()`** [nature : mixte] — suppression après confirmation : refus si le compte a des
  lignes dans `Fiches_Mvt` (« mouvementé ») ou si des comptes y sont rattachés (`coll_cc = &1`,
  « compte utilisé ») ; sinon `DELETE FROM Fiches_Comptes WHERE compte_cc = &1`. Aucun contrôle que
  le compte saisi est un collectif, ni sur `Fiches_Mvt1-5`.
- **`Button2_Click()`** (CC 10) [nature : mixte] — enregistrement :
  - préfixe différent de 401/411/453 → avertissement (le texte cite aussi `456`, refusé) ;
  - compte absent → `INSERT (compte_cc, intitule_cc, type_cc, coll, cent_cc, solde)` paramétré
    (`"1"`, `"1"`, 0) ;
  - compte collectif existant **dont l'intitulé change** → `UPdate` **par concaténation** de tous les
    champs avec `solde = '0,00'` (remise à zéro du solde) ; un changement de type seul est ignoré ;
  - compte existant non collectif → « Ce compte est déjà utilisé par un compte client ! ».
  `Finally` remet le focus sur le code ; `Catch` affiche `Error.Text` et `Error.Where`.
- **`Button4_Click()`** : `Doc.Open("Collectif")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor` ; `Start.Son`, `Start.Musique`.
- Tables en dur : `Fiches_Comptes`, `Fiches_Mvt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabComptes")`/`Cbase.Table("TabMvt")` ; extraire la règle des préfixes autorisés
  dans une fonction `PrefixeCollectif(sCode) As Boolean`.

### Commonalisation avec d'autres fichiers

- Squelette identique à [FPostes](../FPostes.class/architecture.md) (même formulaire `colcol`/`Cdcol`/
  `Libelcol`, mêmes `Maj_Zones`, `CleanChamps`, `Refresh`, `Col_KeyPress`, `Btn_Click`, `Catch`) et
  proche de [FLibelle](../FLibelle.class/architecture.md) et [FJournaux](../FJournaux.class/architecture.md) :
  helper commun « table code/intitulé » en phase 3.
- Le contrôle « compte mouvementé » existe en version complète (Mvt, Mvt1-5, MvtM*) dans
  [FComptes.Button1_Click](../FComptes.class/architecture.md) : une fonction partagée
  `CompteMouvemente(sCompte)` servirait aux deux écrans (la reprise par FCollectif changerait le
  comportement → anomalie A03).
- Les règles de collectif (préfixes 40/41/453) sont aussi codées dans `FComptes.collman`.

### Réduction de portée

`Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` → `Private`.

### Séparation traitement / GUI

`EnregistreCollectif(sCode, sLib, sType) As Integer` (code retour : créé, modifié, inchangé, compte
non collectif) et `SupprimeCollectif(sCode) As Integer` (supprimé, mouvementé, utilisé).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère `Fiches_Comptes.coll_cc → Fiches_Comptes.compte_cc`.
- `coll`/`cent_cc` en booléens réels plutôt que des chaînes `'1'`.
