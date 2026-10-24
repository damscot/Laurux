# Intjdv — Architecture

> Source : `.src/Compta/Utils/Intjdv.class` · Form : `Intjdv.form`

## Vue d'ensemble

Fenêtre « Integration des écritures de ventes » (2007) : choix d'un journal de ventes (type `VE`),
d'une période et d'un fichier texte à positions fixes, puis lecture du fichier pour cumuler les
montants par date et par compte dans une table de travail `centralisation`.

**Code mort** : aucun appelant (`grep -rniw Intjdv .src` ne trouve que le fichier ; pas d'entrée
dans `Fmenu.form`). De plus le traitement est **inopérant** : les `INSERT`/`UPDATE` de
`Button2_Click` sont commentés, la table `centralisation` est seulement supprimée puis recréée vide,
et les dates saisies ne sont jamais utilisées. La fonction a été remplacée par le couple
[`ExportJdv`](../ExportJdv.class/architecture.md) / [`ImpJdv`](../ImpJdv.class/architecture.md).
Suppression proposée en anomalie INTJDV-A01.

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `B` | var | Private |  | Integer | 28 |
| `type_jour` | var | Private |  | String | 29 |
| `jours` | var | Private |  | String | 30 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 35-52 | Public | 4 | 14 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 54-58 | Public | 1 | 3 | 0 | handler GUI |
| `Svs_Click` | 63-71 | Public | 2 | 7 | 0 | handler GUI |
| `Cmpt_GotFocus` | 76-82 | Public | 1 | 5 | 0 | handler GUI |
| `Cmpt_KeyPress` | 87-138 | Public | 11 | 46 | 0 | handler GUI |
| `journauxman` | 143-180 | Public | 5 | 35 | 0 | portée réductible ? |
| `journaux` | 186-221 | Public | 4 | 33 | 0 | portée réductible ? |
| `jour_KeyPress` | 226-241 | Public | 5 | 14 | 0 | handler GUI |
| `jour_Click` | 246-261 | Public | 1 | 13 | 0 | handler GUI |
| `journal_LostFocus` | 266-277 | Public | 3 | 10 | 0 | portée réductible ? |
| `date1_LostFocus` | 282-296 | Public | 3 | 13 | 0 | portée réductible ? |
| `date2_LostFocus` | 301-324 | Public | 6 | 22 | 0 | portée réductible ? |
| `Button2_Click` | 329-419 | Public | 11 | 83 | 0 | handler GUI |
| `Button3_Click` | 424-431 | Public | 1 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Saisie (GUI)

- **`_new()`** [constructeur] [nature : GUI]. Dates du jour (construites par découpage de la conversion
  implicite de `Now` en chaîne `MM/JJ/AAAA`), fichier `/Rep_Jdv` et journal `/Jdv` (code sur 2 caractères +
  libellé) lus dans les réglages **globaux** (pas par société).
- **`ToggleButton1_Click()`** → `journaux()`.
- **`Svs_Click()`** [handler] : `Dialog.OpenFile` (filtres csv/txt), chemin dans `Jdv`.
- **`Cmpt_GotFocus()`** [handler du groupe `Cmpt`] : `Utils.SetEditColor`.
- **`Cmpt_KeyPress()`** [handler] (CC 11) : Entrée/Tab sur journal (tag 1), date 1 (tag 2),
  date 2 (tag 3) ; valide le champ via `journal_LostFocus`/`journauxman`, `date1_LostFocus`,
  `date2_LostFocus` et passe au suivant ; le drapeau membre `B` signale l'erreur.
- **`journauxman()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Journaux WHERE
  code_jo = &1` : refuse un journal inexistant ou non `VE` (`Balloon.Warning`), sinon affiche le
  libellé.
- **`journaux()`** [portée : réductible (appel interne seulement, vérifié par `grep`)] [nature :
  mixte]. Remplit la ColumnView `jour` avec `SELECT * FROM Fiches_Journaux WHERE type_jo = 'VE'
  ORDER BY code_jo` (littéral SQL).
- **`jour_KeyPress()` / `jour_Click()`** [handlers] : sélection d'un journal dans la liste.
- **`journal_LostFocus()`** [handler nominal ; `Journal` appartient au groupe `Cmpt`, il n'est donc
  appelé qu'explicitement] : avertit si le journal est vide.
- **`date1_LostFocus()` / `date2_LostFocus()`** [handlers nominaux, même remarque] :
  `Utils.Cdate_calc` puis `Cdate_aff` ; contrôle date 2 ≥ date 1.

### Traitement

- **`Button2_Click()`** [handler] [nature : mixte, CC 11]. Ouvre le fichier, `DROP TABLE IF EXISTS
  centralisation` puis `CREATE TABLE centralisation (...)` (table de travail portant **le même nom**
  que celle de [`Jourcent`](../../Impressions/Jourcent.class/architecture.md), avec une structure
  différente) ; vérifie que les 2 premiers caractères de la 1re ligne valent `Start.Societe` ; lit
  chaque ligne (type en 106, date en 4-9, compte en 13-18, client/numéro/montant à positions fixes)
  et cumule `montantd`/`montantc`/`montantTD`/`montantTC` **sans les utiliser** ; un `SELECT` par
  ligne sur `centralisation` (vide) dont les deux branches sont commentées. Message « Importation
  terminée ». Variable `Tab = "Fiches_Rubriques"` inutilisée.
- **`Button3_Click()`** [handler] : enregistre `/Rep_Jdv` et `/Jdv`, ferme.

## État global utilisé

- `Start.LocalSettings` (`/Rep_Jdv`, `/Jdv`), `Start.Societe`, `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_calc`, `Utils.Cdate_aff`, `Utils.SetEditColor`,
  `Utils.Observers`.
- Tables : `Fiches_Journaux` (lecture), `centralisation` (DDL).

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet si INTJDV-A01 est acceptée. Sinon : supprimer la boucle sans effet de
  `Button2_Click`, les variables inutilisées (`Tab`, `montantTD`, `montantTC`, `numero`,
  `rResult`) et `intitule` de `journauxman`.

### Commonalisation avec d'autres fichiers

- Liste des journaux (`journaux`, `jour_Click`, `jour_KeyPress`) : même code dans
  [`ExportJdv`](../ExportJdv.class/architecture.md) et [`ImpJdv`](../ImpJdv.class/architecture.md)
  (`ToggleButton3_Click`, `coljour_*`) → helper `RemplitJournaux(hVue, Optional sType)`.
- `Svs_Click` : choix de fichier du socle `ImpExp` proposé dans
  [`Impclient`](../../../Utils/Exports-Imports/Impclient.class/architecture.md).

### Réduction de portée

- `journauxman`, `journaux` → `Private` (aucun appelant externe).

### Séparation traitement / GUI

- Sans objet (traitement inopérant).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de travail `centralisation` (Intjdv, Jourcent) et `centralisations` (ExportJdv) sont
  créées à la volée hors `LauruxMaj` ; des tables temporaires (`CREATE TEMPORARY TABLE`) ou un
  traitement en mémoire éviteraient ces DDL et les collisions de nom.
