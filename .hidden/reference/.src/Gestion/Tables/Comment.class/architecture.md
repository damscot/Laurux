# Comment — Architecture

> Source : `.src/Gestion/Tables/Comment.class`

## Vue d'ensemble

Écran de la **table des commentaires de facturation** (`Fiches_Commentaires` : `numcom` varchar(2)
clé primaire, `intitule` mediumtext). Les commentaires sont insérés dans les documents de vente
(`Facture.class:7739`, `:7776`) et dupliqués entre sociétés par `Dup`. Ouvert par
`Fmenu.class:887` (`Comment.Show`) et en modal depuis la saisie de facture
(`Facture.com_KeyPress`, touche F4, `Facture.class:7818`).

Squelette « table code/texte » partagé avec [ComMail](../ComMail.class/architecture.md)
(similarité 0,89 ; ComMail y ajoute un mode « Choisir ») et proche des écrans Compta
[FPostes](../../../Compta/Tables/FPostes.class/architecture.md) et
[FLibelle](../../../Compta/Tables/FLibelle.class/architecture.md) (similarité 0,53-0,56 : mêmes
`Maj_Zones`, `CleanChamps`, `Refresh`, `Btn_Click`, groupes `Lib`/`Btn`). Contrôles : `ColumnView`
`colcol` (code, première ligne du texte), `Numcom` (2 caractères, groupe `Lib`, tag 1), `Intitule`
(`TextArea` **sans groupe**), boutons du groupe `Btn` (tags 1 aide, 2 supprimer, 3 enregistrer,
4 quitter).

Nature : **GUI** avec SQL dans les handlers. Lecture par `Cbase.Table("TabCom")`, écriture par le
nom en dur `Fiches_Commentaires` (même table).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-41 | Public | 1 | 12 | 0 | méthode spéciale |
| `Form_Open` | 43-61 | Public | 6 | 16 | 0 | handler GUI |
| `Maj_Zones` | 63-73 | Public | 1 | 8 | 0 | portée réductible ? |
| `CleanChamps` | 75-80 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 82-87 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 89-112 | Public | 7 | 18 | 0 | handler GUI |
| `Btn_KeyPress` | 114-123 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 125-143 | Public | 5 | 12 | 0 | handler GUI |
| `Lib_GotFocus` | 153-157 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 159-172 | Public | 3 | 11 | 0 | portée réductible ? |
| `Button2_Click` | 174-198 | Public | 3 | 22 | 0 | portée réductible ? |
| `Button3_Click` | 200-204 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 206-210 | Public | 1 | 3 | 0 | portée réductible ? |
| `colcol_Click` | 212-216 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : centre, `Utils.Observers`, deux colonnes
  (code 60, intitulé 560), focus sur `numcom`.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabCom> order by numcom` ; pour
  chaque ligne, `Try Colcol.add(numcom, numcom)` puis, si l'ajout a réussi, seule la **première
  ligne** du texte (`Split(…, "\n")` + `Break`) est affichée en colonne 1.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : relit le commentaire de
  `Colcol.Current[0]` (`SELECT … where numcom = &1`) et l'affiche ; **aucun test `Available`**
  (erreur si la ligne a disparu entre-temps).
- **`CleanChamps()`**, **`Refresh()`** [portée : réductible] [nature : GUI] : vide les zones ;
  vide la liste puis `Form_Open`.
- **`Lib_KeyPress()`** [handler du groupe `Lib`] [nature : GUI] : Entrée/Tab sur le code → focus
  texte ; la branche `Case 2` (texte : `Utils.ReplaceLb` puis focus Enregistrer) est **inatteignable**
  car `Intitule` n'appartient pas au groupe `Lib` ; F1 → aide.
- **`Lib_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : **toute** touche sur le bouton Enregistrer
  (tag 3) enregistre.
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 aide, 2 `Button1_Click` (supprimer),
  3 `Button2_Click` (enregistrer), 4 fermeture.
- **`Button1_Click()`** [portée : réductible] [nature : mixte] — suppression : si `numcom` n'est
  pas vide, confirmation puis `DELETE FROM Fiches_Commentaires WHERE numcom = &1` avec
  **`colcol.Current[0]`** (ligne 166) et non le code saisi ; erreur sans sélection.
  Pseudo-handler : `Button1` est dans le groupe `Btn`, Gambas ne lève jamais `Button1_Click`.
- **`Button2_Click()`** [portée : réductible] [nature : mixte] — enregistrement :
  `Utils.ReplaceLb` sur le texte (`"` → `''`, `&` → `et`, héritage du SQL concaténé), puis
  `SELECT`/`INSERT` ou `Update … SET numcom = &1, intitule = &2 WHERE numcom = &1`, `Refresh`,
  `Cleanchamps`, puis repositionnement par `Colcol.MoveTo(sKey)`. En mise à jour,
  `sKey = Colcol.Current.Key` (ligne 189) : si l'utilisateur a saisi un code existant sans le
  sélectionner dans la liste, `Current` vaut `Null` → erreur. Pseudo-handler (groupe `Btn`).
- **`Button3_Click()`** [handler inactif] : `Me.Close()`, jamais appelé (`Button3` est dans le
  groupe `Btn`, la fermeture passe par `Btn_Click` tag 4) : **code mort** (`handlers_inactifs`).
- **`Button4_Click()`** [portée : réductible] : `Doc.Open("Commentaires")` (appelé par `Btn_Click`
  et F1).
- **`colcol_Click()`** [handler] : `Maj_Zones`. Rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.ReplaceLb`, `Cbase.Table("TabCom")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabCom")` aussi pour `DELETE`/`INSERT`/`UPDATE` (SQL identique).
- `Update … SET intitule = &2 WHERE numcom = &1` (la clé n'est plus réécrite) : SQL modifié, dump
  identique.
- Supprimer la branche `Case 2` inatteignable de `Lib_KeyPress` et `Button3_Click`.

### Commonalisation avec d'autres fichiers

- [ComMail](../ComMail.class/architecture.md) : 114 lignes communes sur 125/130. Une classe
  commune n'est pas possible sans toucher aux `.form` ; proposition : module partagé
  `TableTexte` (`Charger(hCol, sTable)`, `Lire(sTable, sCode)`, `Enregistrer(sTable, sCode, sTexte)`,
  `Supprimer(sTable, sCode)`) utilisé par les deux écrans, avec le socle « table code/libellé »
  proposé dans [Centrales](../Centrales.class/architecture.md) et les écrans Compta
  [FPostes](../../../Compta/Tables/FPostes.class/architecture.md) /
  [FLibelle](../../../Compta/Tables/FLibelle.class/architecture.md).
- La liste des commentaires est rechargée à l'identique dans `Facture.class:7739` : la fonction
  `Charger` du socle servirait aussi à Facture.

### Réduction de portée

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button4_Click` →
`Private` (pseudo-handlers et fonctions internes, aucun appelant externe). `Button3_Click` est
supprimé (code mort).

### Séparation traitement / GUI

`EnregistreCommentaire(sCode, sTexte)`, `SupprimeCommentaire(sCode)`, `LitCommentaire(sCode)`
sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `numcom` varchar(2) : 100 commentaires au plus avec des codes numériques ; élargir si besoin.
- Fusion possible avec `Fiches_ComMail` (même structure) avec une colonne de type.
