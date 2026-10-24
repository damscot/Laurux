# FLibelle — Architecture

> Source : `.src/Compta/Tables/FLibelle.class`

## Vue d'ensemble

Écran de la **table des libellés d'écritures** (`Fiches_Libelles` : `num` varchar(2) clé,
`intitule` varchar(30)), proposés à la saisie des écritures (`Saisecrit`, `Tresor` via
`Cbase.Table("TabLibel")`). Liste `colcol`, saisie numéro / intitulé, boutons Supprimer,
Enregistrer, Quitter, aide.

Ouvert par `Fmenu.Menu24_Click` (`Flibelle.Show`).

Nature : **GUI** avec SQL dans les handlers ; SQL paramétré.

### Contrôles en groupe

`Num` et `Intitule` sont dans le groupe `Lib` : `num_GotFocus`, `num_LostFocus`,
`intitule_GotFocus`, `intitule_LostFocus` ne sont **jamais déclenchés par Gambas** ; ils sont
appelés explicitement depuis `Lib_KeyPress`, `_New`, `Maj_Zones` et les boutons. La coloration du
fond et le passage par `Utils.Remplace` ne se produisent donc qu'au clavier (Entrée/Tab), pas à la
souris (comportement actuel, documenté, non classé en anomalie : `Button2_Click` applique
`Utils.Remplace` de toute façon).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-44 | Public | 1 | 12 | 0 | méthode spéciale |
| `Form_Open` | 46-60 | Public | 3 | 12 | 0 | handler GUI |
| `Maj_Zones` | 62-69 | Public | 1 | 6 | 0 | portée réductible ? |
| `CleanChamps` | 71-76 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 78-83 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 85-113 | Public | 10 | 24 | 0 | handler GUI |
| `Btn_Click` | 115-133 | Public | 5 | 12 | 0 | handler GUI |
| `num_GotFocus` | 135-139 | Public | 1 | 3 | 0 | portée réductible ? |
| `num_LostFocus` | 141-145 | Public | 1 | 3 | 0 | portée réductible ? |
| `intitule_GotFocus` | 147-151 | Public | 1 | 3 | 0 | portée réductible ? |
| `intitule_LostFocus` | 153-158 | Public | 1 | 4 | 0 | portée réductible ? |
| `Button1_Click` | 160-181 | Public | 4 | 19 | 0 | portée réductible ? |
| `Button2_Click` | 183-206 | Public | 3 | 21 | 0 | portée réductible ? |
| `Button4_Click` | 208-212 | Public | 1 | 3 | 0 | portée réductible ? |
| `colcol_Click` | 214-218 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : observateurs, son, colonnes, coloration et
  focus sur `num`.
- **`Form_Open()`** [handler] : `SELECT * FROM Fiches_Libelles order by num`.
- **`Maj_Zones()`**, **`CleanChamps()`**, **`Refresh()`** [portée : réductible] [nature : GUI].
- **`Lib_KeyPress()`** (CC 10) [handler, groupe `Lib`] : Entrée/Tab alterne `num` ↔ `intitule`
  (en appelant les `*_LostFocus`/`*_GotFocus`) ; F1 aide.
- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer, 4 fermer.
- **`num_GotFocus`, `num_LostFocus`, `intitule_GotFocus`** : fond `&HAAFF7F&` ou
  `Color.TextBackground` (appels explicites).
- **`intitule_LostFocus()`** : `Utils.Remplace` (guillemet → `''`, `&` → `et`, retours ligne
  supprimés) puis fond normal.
- **`Button1_Click()`** — suppression : si `num` n'est pas vide, confirmation puis
  `DELETE FROM Fiches_Libelles WHERE num = &1` avec **`colcol.Current[0]`** (ligne sélectionnée, pas
  le numéro saisi ; erreur si aucune sélection). Aucun contrôle d'usage (les écritures recopient le
  texte, pas le numéro : à confirmer).
- **`Button2_Click()`** — enregistrement : `Utils.Remplace` ; `SELECT … WHERE num = &1` ; INSERT ou
  UPDATE (`SET num = &1, intitule = &2 WHERE num = &1`). `Refresh()` est appelé deux fois après une
  insertion.
- **`Button4_Click()`** : `Doc.Open("Libelles")`. **`colcol_Click()`** : `Maj_Zones`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.Remplace` ; `Start.Son`, `Start.Musique`.
- Table en dur : `Fiches_Libelles`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Un seul `Refresh()` dans `Button2_Click` (SQL modifié : un `SELECT` de moins, dump identique).
- `Cbase.Table("TabLibel")`.

### Commonalisation avec d'autres fichiers

- Squelette « table code/intitulé » : [FCollectif](../FCollectif.class/architecture.md),
  [FPostes](../FPostes.class/architecture.md), [FJournaux](../FJournaux.class/architecture.md).
- Coloration manuelle `&HAAFF7F&` (aussi dans FTvac/FTvav) au lieu de `Utils.SetEditColor` utilisé
  ailleurs : à unifier en phase 3 (changement de couleur visible → hors rework autonome).

### Réduction de portée

`Maj_Zones`, `CleanChamps`, `Refresh` → `Private`. Les procédures `num_*`/`intitule_*` gardent leur
nom et leur portée (règle des handlers).

### Séparation traitement / GUI

`EnregistreLibelle(sNum, sLib)` et `SupprimeLibelle(sNum)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune nécessaire ; `intitule` varchar(30) alors que la saisie est limitée à 25 caractères (`.form`).
