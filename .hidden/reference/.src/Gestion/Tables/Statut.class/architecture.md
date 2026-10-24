# Statut — Architecture

> Source : `.src/Gestion/Tables/Statut.class`

## Vue d'ensemble

Écran de la **table des statuts clients** (`Fiches_Statut` : `code` char(2) clé primaire,
`libelle` varchar(25)). Ouvert par `Fmenu.class:1915` (`Statut.Show()`) et **affiché/masqué** par
`EmailingCarte.bstatut_Click` (`EmailingCarte.class:649-652`, `Statut.Visible = …` : aucun contrôle
`Statut` n'existe dans `EmailingCarte.form`, c'est donc l'auto-instance de ce formulaire qui est
manipulée). La table est lue par `FClient` (`:105`, `:767`), `Emailing`, `EdClient` et `Expcontact`.

Copie quasi exacte de [Centrales](../Centrales.class/architecture.md) (similarité 0,94) : seules
diffèrent la clé `Cbase.Table("TabStatut")`, la variable `son` (au lieu de `Start.son`) et le
commentaire d'aide (`Doc.Open("Statut")` commenté).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$bForceKey` | var | Private |  | Boolean | 27 |
| `CoulZns` | var | Private |  | Integer | 28 |
| `CoulFoc` | var | Private |  | Integer | 29 |
| `son` | var | Private |  | Integer | 30 |
<!-- /AUTO:declarations -->

Remarque : `CoulZns`, `CoulFoc` et `son` (lignes 28-30, sans mot-clé, donc `Private`) ne figurent
pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-58 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 60-73 | Public | 3 | 11 | 0 | handler GUI |
| `Coltype_Click` | 75-79 | Public | 1 | 3 | 0 | handler GUI |
| `Refresh` | 81-88 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 90-96 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 98-110 | Public | 4 | 11 | 0 | handler GUI |
| `Button3_Click` | 112-131 | Public | 3 | 17 | 0 | handler GUI |
| `Button3_KeyPress` | 133-137 | Public | 1 | 3 | 0 | handler GUI |
| `OBS_GotFocus` | 139-149 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 151-159 | Public | 4 | 7 | 0 | handler GUI |
| `IsValidKey` | 161-166 | Public | 6 | 4 | 0 | portée réductible ? |
| `SetObservers` | 168-180 | Public | 4 | 10 | 0 | portée réductible ? |
| `Cdtype_LostFocus` | 182-186 | Public | 2 | 3 | 0 | handler GUI |
| `Cdtype_KeyPress` | 188-195 | Public | 2 | 6 | 0 | handler GUI |
| `Quitte_Cdtype` | 197-199 | Public | 1 | 2 | 0 | portée réductible ? |
| `Libeltype_LostFocus` | 201-205 | Public | 2 | 3 | 0 | handler GUI |
| `Libeltype_KeyPress` | 207-213 | Public | 2 | 5 | 0 | handler GUI |
| `Quitte_Libeltype` | 215-217 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button4_Click` | 219-223 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 228-231 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Le comportement est celui de Centrales ; seuls les points propres sont détaillés.

- **`_New()`** [portée : nécessaire] [nature : GUI] : couleurs, observateurs `OBS`, colonnes.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabStatut>` (sans tri), remplit `Coltype`.
- **`Coltype_Click()`** [handler] : `Maj_Zones` ; rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.
- **`Refresh()`**, **`Maj_Zones()`** [portée : réductible] [nature : GUI].
- **`Button2_Click()`** [handler] [nature : mixte] : `DELETE … WHERE code = &1` avec
  `Coltype.Current[0]` (ligne 105) et non le code saisi ; erreur sans sélection (anomalie A02,
  comme Centrales).
- **`Button3_Click()`** [handler] [nature : mixte] : `SELECT` **concaténé** (ligne 118) puis
  `UPdate … SET code = &1, libelle = &2 WHERE code = &1` ou `INSERT`.
- **`Button3_KeyPress()`** [handler] : toute touche sur le bouton Enregistrer enregistre.
- **`Button4_Click()`** [handler] : ferme ; **`Button1_Click()`** [handler] : vide (aide commentée).
- **`OBS_GotFocus()` / `OBS_LostFocus()`** [handlers `OBS`] : couleurs de focus.
- **`IsValidKey()`**, **`SetObservers()`** [portée : réductible] : identiques à Centrales
  (`$bForceKey` jamais affecté, `hClass` inutilisé).
- **`Cdtype_KeyPress()`**, **`Libeltype_KeyPress()`**, **`Cdtype_LostFocus()`**,
  **`Libeltype_LostFocus()`** [handlers] : navigation ; appels de `Quitte_*`.
- **`Quitte_Cdtype()` / `Quitte_Libeltype()`** [portée : réductible] : vides (code mort).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Cbase.Table("TabStatut")` ; `Start.LocalSettings`,
  `Start.Societe`, `Start.Son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Mêmes nettoyages que Centrales : `$bForceKey`, `Quitte_*` vides, `With utils`, UPDATE sans clé.

### Commonalisation avec d'autres fichiers

- Socle « table code/libellé » avec [Centrales](../Centrales.class/architecture.md),
  [Identite](../Identite.class/architecture.md) et [Typec](../Typec.class/architecture.md).

### Réduction de portée

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype` →
`Private`. L'usage externe par `EmailingCarte` porte sur la propriété héritée `Visible`, pas sur
ces membres.

### Séparation traitement / GUI

`EnregistreStatut(sCode, sLib)`, `SupprimeStatut(sCode)` (ou fonctions du socle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère des fiches clients vers `Fiches_Statut.code`.
