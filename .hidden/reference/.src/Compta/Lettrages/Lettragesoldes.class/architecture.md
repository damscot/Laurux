# Lettragesoldes — Architecture

> Source : `.src/Compta/Lettrages/Lettragesoldes.class`

## Vue d'ensemble

Traitement de masse « **lettrage des comptes soldés** » lancé depuis `Fmenu.Menu127_Click`. Pour
chaque compte client ou fournisseur dont `Fiches_Comptes.solde = 0`, il lettre les écritures non
lettrées de `Fiches_Mvt` avec un lot `"S" & Right$(lot, 9)` et recalcule le SHA1 de chaque ligne
parcourue. Le message final donne le nombre de comptes traités.

Le formulaire est la copie de [Lettragemontant](../Lettragemontant.class/architecture.md)
(mêmes contrôles, même `_New`, même `Btn_Click`, même `clear` mort).

Nature : **mixte**, tout le traitement est dans `Button2_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TT` | var | Private |  | Float | 28 |
| `TD` | var | Private |  | String | 29 |
| `TC` | var | Private |  | String | 30 |
| `type` | var | Private |  | String | 31 |
| `Tab2` | var | Private |  | String | 32 |
| `son` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-42 | Public | 1 | 5 | 0 | méthode spéciale |
| `Btn_Click` | 44-58 | Public | 4 | 10 | 0 | handler GUI |
| `clear` | 60-66 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 68-109 | Public | 7 | 39 | 0 | portée réductible ? |
| `Button1_Click` | 111-115 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers(Me)`, son, centrage.
- **`Btn_Click()`** [handler, groupe `Btn`] : tag 1 aide, 2 lancement, 3 fermeture.
- **`clear()`** [portée : réductible, **code mort**] : jamais appelée ; `TT`/`TD`/`TC` inutilisés.
- **`Button2_Click()`** (CC 7) [handler via tag 2] [nature : mixte].
  1. `type` = `C` si `Bclient`, sinon `F` ; curseur d'attente.
  2. `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 and solde = &2 order by cast(compte_cc AS char)` (0).
  3. Pour chaque compte : `SELECT * FROM Fiches_Mvt WHERE compte = &1 and lettree = &2 order by compte, numlot` (0).
     S'il y a des lignes : `num` = lot de la **première** ligne, `Snum = "S" & Right$(num, 9)`,
     `B` + 1, puis **pour chaque ligne** : `UPdate Fiches_Mvt SET numlot = &1, lettree = &2 where
     compte = &3 and numlot = &4` (Snum, 1, compte, num) et `Sha1Calc.CalcSha1("Fiches_Mvt", numero)`.
  4. Message « n compte(s) lettré(s) ».

  Conséquences : seules les lignes dont le lot vaut celui de la première ligne sont lettrées (les
  autres gardent `lettree = 0`) ; si ce lot est `NULL`, `numlot = NULL` n'est jamais vrai et rien
  n'est lettré, mais le compte est compté. Aucun filtre `validee`/`provisoire` (contrairement à
  `Lettragemontant`), aucun contrôle que les lignes non lettrées s'équilibrent : seul le solde global
  du compte est testé (égalité stricte sur un `solde` stocké).
- **`Button1_Click()`** [handler via tag 1] : `Doc.Open("Lettragemontant")` — page d'aide d'un
  autre écran ? (à confirmer avec la documentation HTML).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Sha1Calc.CalcSha1`, `Doc.Open`, `Start.Son`, `Start.Musique`.
- Tables en dur : `Fiches_Comptes` (colonne `solde`, maintenue par [Csolde](../../../Utils/Csolde.module/architecture.md)), `Fiches_Mvt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- UPDATE exécuté une seule fois par compte, puis `CalcSha1` par `numero` distinct des lignes
  parcourues : **SQL modifié, dump identique**.

### Commonalisation avec d'autres fichiers

- Structure identique à [Lettragemontant](../Lettragemontant.class/architecture.md) : module commun
  `Lettrages` (boucle sur les comptes d'un type, application d'un lot, comptage, message).
- La sélection « comptes d'un type par solde » recoupe [Fprepdus](../../../Communs/Fprepdus.class/architecture.md)
  (`type_cc = &1 AND solde <> &2`) : une fonction `Csolde.ComptesParType(sType, …)` partagée est
  proposée en phase 3 avec [Csolde](../../../Utils/Csolde.module/architecture.md), qui calcule
  justement `Fiches_Comptes.solde` dont dépend ce traitement.

### Réduction de portée

`clear` supprimée (code mort). Les handlers restent `Public`.

### Séparation traitement / GUI

`LettrerComptesSoldes(sType As String) As Integer` (SQL, renvoie le nombre de comptes) appelée par
`Button2_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(type_cc, solde)` sur `Fiches_Comptes` (déjà proposé pour Fprepdus) et `(compte, lettree)`
  sur `Fiches_Mvt`.
- Compteur de lots de lettrage (lot commun `"S"` aujourd'hui).
