# RazHistoFac — Architecture

> Source : `.src/Archivages/RazHistoFac.class`

## Vue d'ensemble

`RazHistoFac` est l'écran **« Epuration des factures archivées »** (sous-menu Epurations,
`Fmenu.Menu259`, modal ; aussi `Prgm` avec le nom `eff`, non modal). Il supprime les **factures
clients** (`Fiches_HistoFac` + lignes `Fiches_HistoLigfac`) dont `datefac` est strictement antérieure
à la date choisie et, si la case « Effacement des factures entretien » est cochée (visible seulement
avec l'option `/Soc<XX>/Materiel`), les factures matériel/entretien (`Fiches_HistoFacM` +
`Fiches_HistoLigfacM`).

Dans Laurux, `Fiches_HistoFac` **est** la table des factures émises (consultée par
[`Archives`](../Archives.class/architecture.md), réimprimée par `OptFac`/`ObjFacB`, utilisée par les
statistiques et le recalcul de stock). Purger revient donc à supprimer des pièces comptables
justificatives.

Opération destructive : question, sauvegarde `mysqldump` dans `~/Sauve/<Base>EffaceF.sql`,
`ProgBar` interruptible ; ni transaction, ni garde-fou (date du jour par défaut, à confirmer ; pas de
contrôle d'exercice clos, de durée légale de conservation, ni de factures non soldées).

Tables liées **non purgées** (orphelins) : `Fiches_HisentMat` (matériel de la facture),
`Fiches_Suivis.numfac`, `Fiches_Traites.numfac`, `Fiches_Lcr.numfac`, `Fiches_BordereauxC.nfacture`,
`Fiches_Bl.numfac`/`Fiches_BlM.numfac` (BL facturés), `Fiches_ligcons`/`Fiches_ligregie` (`num`,
option boissons, à confirmer) et les documents de la GED (`Docs_Ged`, PDF archivés par
[`LGed`](../../Utils/LGed.class/architecture.md)).

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

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre ; rend visible
  `CheckBox1` si `Start.LocalSettings["/Soc" & Start.Societe & "/Materiel"]`.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Décoche `CheckBox1` puis
  ferme. La remise à `False` est probablement sans effet (la fenêtre, auto-instance, est détruite à
  la fermeture ; à confirmer).
- **`Button1_Click()`** (CC 9) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son, `Message.Question` ; rien si « Non ».
  2. `~/Sauve`, `Shell "mysqldump … > ~/Sauve/<Base>EffaceF.sql" Wait` (code retour ignoré).
  3. `SELECT * FROM <TabHisFac> where datefac < &1` ; `ProgBar` ; pour chaque facture
     `delete FROM <TabHisLigFac> where num_ligfac = &1` puis `delete FROM <TabHisFac> where numfac = &1`
     (`numfac` est la clé primaire : suppression exacte).
  4. Si `CheckBox1` : même traitement sur `TabHisFacm`/`TabHisLigFacm` (deuxième `ProgBar`).
  5. `Syntheses.Message` + `Message.Info` (« N factures ont été effacées », total des deux familles).
  - Borne `<` stricte sur `datefac` (`datetime`) : sous MySQL, les factures du jour choisi sont
    conservées. Sous SQLite : purge sans effet pour des dates stockées en texte (A04, à confirmer).
  - Le bouton d'arrêt de la `ProgBar` interrompt la famille en cours mais pas la suivante (la
    purge matériel démarre quand même si la case est cochée).

## État global utilisé

- `Start.son`, `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/dbase/Host"]` ;
  `Utils.db` ; `Cbase.Table` ; `Syntheses.Message` ; `ProgBar` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les deux blocs (factures, factures entretien) dans une boucle sur deux couples de
  tables, ou via `PurgeEnteteLignes` (voir ci-dessous) : SQL identique.
- Supprimer `CheckBox1.value = False` de `Button2_Click` seulement si l'absence d'effet est
  confirmée (auto-instance détruite à la fermeture).

### Commonalisation avec d'autres fichiers

- [`RazDevis`](../RazDevis.class/architecture.md) est une copie quasi exacte (même `_new`, même
  `Button2_Click`, deux blocs en-tête + lignes) ; [`RazHistoTk`](../RazHistoTk.class/architecture.md)
  et [`RazHistoFbl`](../RazHistoFbl.class/architecture.md) suivent le même schéma : module `Epuration`
  avec `PurgeEnteteLignes(...)` (RAZRLVB-006, RAZHISTOTK-004) et `Utils.DumpBase` (SAUVESAUTO-003).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite, bMateriel) As Integer`, la case à cocher étant lue par le
  handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `ON DELETE CASCADE` (ou indicateur « archivée ») entre `Fiches_HistoFac` et ses
  tables liées (`Fiches_HistoLigfac`, `Fiches_HisentMat`, `Fiches_Suivis`, `Fiches_Traites`,
  `Fiches_Lcr`, `Docs_Ged`).
- Archivage froid (base d'archives) plutôt que suppression, pour respecter la durée légale de
  conservation des factures.
