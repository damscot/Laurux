# FPostes — Architecture

> Source : `.src/Compta/Tables/FPostes.class`

## Vue d'ensemble

Écran de la **table des postes analytiques** (`Fiches_Postes` : `lind` clé auto-incrémentée,
`code` char(3), `intitulep` char(35)). Les postes servent à la répartition analytique des comptes
(`FComptes`, table `Fiches_Analytiques`) et aux écritures analytiques (`Analytique`, `JournauxA`).

Le fichier est une copie de [FCollectif](../FCollectif.class/architecture.md) (son en-tête porte
encore « Fcollectif.class ») ; il utilise `Cbase.Table("TabPostes")` et un SQL paramétré.

Ouvert par `Fmenu.Menu294_Click` (`FPostes.show()`).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `n` | var | Private |  | Integer | 12 |
| `son` | var | Private |  | Integer | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 15-26 | Public | 1 | 10 | 0 | méthode spéciale |
| `Form_Open` | 28-43 | Public | 6 | 13 | 0 | handler GUI |
| `Maj_Zones` | 45-51 | Public | 1 | 5 | 0 | portée réductible ? |
| `CleanChamps` | 53-58 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 60-65 | Public | 1 | 4 | 0 | portée réductible ? |
| `Col_KeyPress` | 67-87 | Public | 7 | 17 | 0 | handler GUI |
| `Col_GotFocus` | 92-98 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 100-113 | Public | 5 | 12 | 0 | handler GUI |
| `Colcol_Click` | 115-122 | Public | 2 | 6 | 0 | handler GUI |
| `cptman` | 124-134 | Public | 2 | 8 | 0 | portée réductible ? |
| `Button1_Click` | 136-148 | Public | 3 | 10 | 0 | portée réductible ? |
| `Button2_Click` | 150-170 | Public | 4 | 18 | 0 | portée réductible ? |
| `Button4_Click` | 172-176 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : observateurs, son, 2 colonnes.
- **`Form_Open()`** [handler] (CC 6) : `SELECT * FROM <TabPostes> order by cast(code AS char)` ;
  chaque instruction est protégée par `Try` : un code en double fait échouer l'ajout et ses
  `Item[…]` réécrivent alors la ligne précédente ; `n` compte les lignes.
- **`Maj_Zones()`**, **`CleanChamps()`**, **`Refresh()`** [portée : réductible] [nature : GUI].
- **`Col_KeyPress()`** [handler, groupe `Col`] : Entrée/Tab code → `cptman` + intitulé → enregistrement ; F1 aide.
- **`Col_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer, 4 fermer.
- **`Colcol_Click()`** [handler] : `Maj_Zones` si `n > 0`.
- **`cptman()`** [portée : réductible] : relit le poste saisi et recopie l'intitulé.
- **`Button1_Click()`** — suppression : confirmation puis `DELETE … WHERE code = &1` (code saisi) ;
  aucun contrôle d'usage dans `Fiches_Analytiques` ni dans les écritures analytiques.
- **`Button2_Click()`** — enregistrement : `SELECT … WHERE code = &1` ; INSERT `(code, intitulep)`
  ou UPDATE `intitulep` ; `Catch` → `Message.Error(Error.Text & Error.Where)`. La zone code accepte
  8 caractères (`.form`) pour une colonne `char(3)`.
- **`Button4_Click()`** : `Doc.Open("Analytique")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Cbase.Table("TabPostes")` ; `Start.Son`,
  `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- En-tête du fichier à corriger. Les `Try` du remplissage ne sont pas inutiles : en cas de code en
  double, l'ajout échoue et les `Item[…]` réécrivent la ligne précédente (comportement à conserver).

### Commonalisation avec d'autres fichiers

- Copie de [FCollectif](../FCollectif.class/architecture.md) : candidat principal au helper
  « table code/intitulé » (avec [FLibelle](../FLibelle.class/architecture.md)).
- La liste des postes est aussi chargée par [FComptes.ToggleButton4_Click](../FComptes.class/architecture.md),
  `Analytique` et `JournauxA`.

### Réduction de portée

`Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` → `Private`.

### Séparation traitement / GUI

`EnregistrePoste(sCode, sLib)` et `SupprimePoste(sCode)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `Fiches_Postes.code` (aujourd'hui seule `lind` est clé : doublons possibles).
- Clé étrangère `Fiches_Analytiques.code → Fiches_Postes.code`.
