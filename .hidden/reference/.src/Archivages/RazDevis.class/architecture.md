# RazDevis — Architecture

> Source : `.src/Archivages/RazDevis.class`

## Vue d'ensemble

`RazDevis` est l'écran **« Epuration des devis »** (sous-menu Epurations, `Fmenu.Menu290`, modal).
Il supprime les devis (`Fiches_Bl` avec `type = 'D'`, lignes `Fiches_Ligbl`) dont `datebl` est
strictement antérieure à la date choisie et, si la case « Effacement des devis entretien » est
cochée (visible seulement avec l'option `/Soc<XX>/Materiel`), les devis matériel (`Fiches_BlM` +
`Fiches_LigblM`). Un devis transformé en BL ou en facture a changé de `type` et n'est pas concerné.

C'est une **copie quasi exacte** de [`RazHistoFac`](../RazHistoFac.class/architecture.md) (même
`_new`, même `Button2_Click`, deux blocs en-tête + lignes) ; le `.form` en a gardé le titre
« Epuration des factures archivées. » et l'infobulle de `Button2` (« Quitte la saisie de la
facturation fin de mois »).

Opération destructive : question, sauvegarde `mysqldump` dans `~/Sauve/<Base>EffaceD.sql` — **même
fichier que [`RazClientd`](../RazClientd.class/architecture.md)** (écrasement mutuel) —, `ProgBar`
interruptible ; ni transaction ni garde-fou.

Tables liées **non purgées** : `Fiches_AdrlivBL` (adresse de livraison, clé `numbl`), `Fiches_EntMat`
(matériel du document, `numbl`), `Fiches_Suivis.numdev`, documents GED (`Docs_Ged`).

Écran non instrumenté (`Utils.Observers` absent). Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-8 | Public | 2 | 4 | 0 | méthode spéciale |
| `Button2_Click` | 10-15 | Public | 1 | 4 | 0 | handler GUI |
| `Button1_Click` | 18-61 | Public | 11 | 41 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre ; `CheckBox1` visible si
  `/Soc<XX>/Materiel`.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Décoche `CheckBox1` (sans
  effet probable, à confirmer) puis ferme.
- **`Button1_Click()`** (CC 9) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son, `Message.Question` ; rien si « Non ».
  2. `~/Sauve`, `Shell "mysqldump … > ~/Sauve/<Base>EffaceD.sql" Wait` (code retour ignoré).
  3. `SELECT * FROM <TabBl> where datebl < &1 and type = &2` (`"D"`) ; `ProgBar` ; pour chaque devis
     `delete FROM <TabLigbl> where num_ligbl = &1` puis `delete FROM <TabBl> where numbl = &1`
     (`numbl` clé primaire : suppression exacte).
  4. Si `CheckBox1` : même traitement sur `TabBlM`/`TabLigblM`.
  5. `Syntheses.Message` + `Message.Info` (« N devis ont été effacés »).
  - Borne `<` stricte sur `datebl` (`datetime`) : MySQL conserve les devis du jour choisi ; SQLite
    sans effet pour des dates en texte (A04, à confirmer).

## État global utilisé

- `Start.son`, `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/dbase/Host"]` ;
  `Utils.db` ; `Cbase.Table` ; `Syntheses.Message` ; `ProgBar` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les deux blocs (devis, devis entretien), SQL identique.

### Commonalisation avec d'autres fichiers

- Fusion de fait avec [`RazHistoFac`](../RazHistoFac.class/architecture.md) via
  `Epuration.PurgeEnteteLignes(...)` (filtre supplémentaire `type = 'D'`) ; module `Epuration`
  (RAZRLVB-006) et `Utils.DumpBase` (SAUVESAUTO-003).
- La suppression d'un devis (en-tête, lignes, adresse de livraison) existe aussi dans
  [`ObjFacB`](../../Gestion/option/ObjFacB.class/architecture.md) (`DELETE FROM Fiches_AdrlivBL`,
  `ObjFacB.class:1094`) et `OptFac` : une fonction commune `SupprimeDocument(numbl)` éviterait les
  orphelins (après décision sur A01).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite, bMateriel) As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `ON DELETE CASCADE` de `Fiches_Ligbl`, `Fiches_AdrlivBL`, `Fiches_EntMat` vers
  `Fiches_Bl` ; index `(type, datebl)` déjà présent sur `Fiches_Bl` (`idx_type_date`), absent sur
  `Fiches_BlM`.
