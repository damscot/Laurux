# Identite — Architecture

> Source : `.src/Gestion/Tables/Identite.class`

## Vue d'ensemble

Écran de la **table des formes juridiques et civilités** (`Fiches_Identite` : `code` char(2) clé
primaire, `libelle` char(9) ; `Laurux01.sql` fournit SARL, EURL, M., Mme…). Ouvert en modal par
`Fmenu.class:1817` (`Identite.ShowModal()`). Les libellés alimentent les listes de civilité
(`Fsoc.Init_Civilite`, `Utils.module:1611`, combo générique par `Object.Call(obj, "Add", …)`).

Variante du squelette « table code/libellé à observateurs » de
[Centrales](../Centrales.class/architecture.md) (similarité 0,87 à 0,92 avec Centrales, Statut et
Typec). Différences propres à Identite :
- nom de table **en dur** (`Tab = "Fiches_Identite"`) au lieu de `Cbase.Table("TabIdentite")` (la
  clé existe dans `Cbase`) ;
- suppression **corrigée** : `DELETE … WHERE code = &1` avec le code saisi (`CdType.Text`), l'ancienne
  version avec `Coltype.Current[0]` est en commentaire ;
- `Quitte_Cdtype` **non vide** : relit le libellé du code saisi ;
- `Maj_Zones` place le focus sur le libellé ; `Form_Open` le place sur le code ;
- `Button1_Click` ouvre l'aide **`Doc.Open("Familles")`** (page d'aide d'un autre écran).

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

Remarque : `CoulZns`, `CoulFoc` et `son` (lignes 28-30, déclarées sans mot-clé, donc `Private`)
ne figurent pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-58 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 60-76 | Public | 3 | 14 | 0 | handler GUI |
| `Coltype_Click` | 78-82 | Public | 1 | 3 | 0 | handler GUI |
| `Refresh` | 84-91 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 93-100 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 102-118 | Public | 4 | 13 | 0 | handler GUI |
| `Button3_Click` | 120-141 | Public | 3 | 19 | 0 | handler GUI |
| `Button3_KeyPress` | 143-147 | Public | 1 | 3 | 0 | handler GUI |
| `OBS_GotFocus` | 149-159 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 161-169 | Public | 4 | 7 | 0 | handler GUI |
| `IsValidKey` | 171-176 | Public | 6 | 4 | 0 | portée réductible ? |
| `SetObservers` | 178-190 | Public | 4 | 10 | 0 | portée réductible ? |
| `Cdtype_LostFocus` | 192-196 | Public | 2 | 3 | 0 | handler GUI |
| `Cdtype_KeyPress` | 198-205 | Public | 2 | 6 | 0 | handler GUI |
| `Quitte_Cdtype` | 207-223 | Public | 2 | 14 | 0 | portée réductible ? |
| `Libeltype_LostFocus` | 225-229 | Public | 2 | 3 | 0 | handler GUI |
| `Libeltype_KeyPress` | 231-237 | Public | 2 | 5 | 0 | handler GUI |
| `Quitte_Libeltype` | 239-241 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button4_Click` | 243-247 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 252-256 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et affichage

- **`_New()`** [portée : nécessaire] [nature : GUI] : couleurs `/Coul/Focus`, `/Coul/Znss`,
  `Utils.Observers`, `Music.Load`, observateurs `OBS`, colonnes.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_Identite` (sans tri), remplit
  `Coltype`, focus sur `Cdtype`.
- **`Coltype_Click()`** [handler] : `Maj_Zones`. Rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide liste et zones, rappelle `Form_Open`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : ligne courante → zones, focus libellé.

### Enregistrement et suppression

- **`Button2_Click()`** [handler] [nature : mixte] : si code saisi, son (`son`), confirmation,
  `DELETE FROM Fiches_Identite WHERE code = &1` (code saisi), `Refresh`. Aucun contrôle d'usage
  (les libellés sont recopiés comme texte dans les fiches : pas d'orphelin en base, à confirmer).
- **`Button3_Click()`** [handler] [nature : mixte] : `SELECT … WHERE code = '<code>'` **concaténé**
  (ligne 128), puis `UPdate … SET code = &1, libelle = &2 WHERE code = &1` ou `INSERT`.
- **`Button3_KeyPress()`** [handler] : toute touche sur le bouton Enregistrer enregistre.
- **`Button4_Click()`** [handler] : ferme.
- **`Button1_Click()`** [handler] : `Doc.Open("Familles")` (aide d'un autre écran, anomalie A02).

### Saisie et focus

- **`OBS_GotFocus()` / `OBS_LostFocus()`** [handlers `OBS`] : couleurs de focus (identiques à
  Centrales).
- **`IsValidKey()`** [portée : réductible] : F1 → aide ; touches de validation ou `$bForceKey`
  (jamais affecté).
- **`SetObservers(hClass, hCont)`** [portée : réductible] : observateurs `OBS` récursifs
  (`hClass` inutilisé).
- **`Cdtype_KeyPress()` / `Libeltype_KeyPress()`** [handlers] : navigation code → libellé → bouton.
- **`Cdtype_LostFocus()` / `Libeltype_LostFocus()`** [handlers] : appellent `Quitte_*`.
- **`Quitte_Cdtype()`** [portée : réductible] [nature : mixte] : `SELECT … WHERE code = '<code>'`
  **concaténé** (ligne 214) ; recopie le libellé ou vide la zone, focus libellé.
- **`Quitte_Libeltype()`** [portée : réductible] : vide (code mort).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.FColr` ; `Start.LocalSettings` (`/Coul/*`, `/Soc<XX>/Coul_fen`),
  `Start.Societe`, `Start.Son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabIdentite")` au lieu du nom en dur (même table, SQL identique).
- Supprimer `$bForceKey`, `Quitte_Libeltype`, le `With utils` inutile ; `UPdate` sans réécriture de clé.

### Commonalisation avec d'autres fichiers

- Socle « table code/libellé » commun avec [Centrales](../Centrales.class/architecture.md),
  [Statut](../Statut.class/architecture.md) et [Typec](../Typec.class/architecture.md) (voir
  Centrales). `Quitte_Cdtype` correspond à une fonction `Libelle(sTable, sCode)` du socle.
- La lecture « liste des civilités » est dupliquée dans `Fsoc.Init_Civilite` et `Utils.module:1611`.

### Réduction de portée

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype` → `Private`.

### Séparation traitement / GUI

`EnregistreIdentite(sCode, sLib)`, `SupprimeIdentite(sCode)`, `LibelleIdentite(sCode) As String`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `libelle` char(9) est très court (« Mme et M. » remplit la colonne) : élargir.
- Stocker le code (et non le libellé) dans les fiches qui utilisent la civilité.
