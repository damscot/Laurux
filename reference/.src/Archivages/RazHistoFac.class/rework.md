# RazHistoFac — Rework

> Source : `.src/Archivages/RazHistoFac.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazHistoFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 49 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 11 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 49 | 14 | 11 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZHISTOFAC-001 — [documentation] En-tête en français : rôle (suppression de factures
  émises), tables purgées et tables liées non purgées, borne `<` stricte, option matériel ·
  appelants : aucun · tests : aucun · sources : [RazHistoFac.class:Button1_Click](../../../../.src/Archivages/RazHistoFac.class#L18-L61)
- [ ] RAZHISTOFAC-002 — [complexité] Factoriser les deux blocs factures / factures entretien
  (couples de tables, libellés de `ProgBar` conservés, SQL identique) · appelants : aucun ·
  tests : T01-T05 · sources : [RazHistoFac.class:30-55](../../../../.src/Archivages/RazHistoFac.class#L30-L55)
- [ ] RAZHISTOFAC-003 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite, bMateriel)
  As Integer` appelée par `Button1_Click` · appelants : aucun · tests : T01-T05 · sources : [RazHistoFac.class:Button1_Click](../../../../.src/Archivages/RazHistoFac.class#L18-L61)
- [ ] RAZHISTOFAC-004 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003) et
  squelette `Epuration`/`PurgeEnteteLignes` partagé avec `RazDevis`, `RazHistoTk`, `RazHistoFbl`
  (RAZRLVB-006, RAZHISTOTK-004) · prérequis : SAUVESAUTO-003, RAZRLVB-006 · appelants : aucun ·
  tests : T01-T06 · sources : [RazHistoFac.class:Button1_Click](../../../../.src/Archivages/RazHistoFac.class#L18-L61), [RazDevis.class:Button1_Click](../../../../.src/Archivages/RazDevis.class#L18-L61)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZHISTOFAC-A01 — [anomalie, décision utilisateur] Suppression de factures émises sans
  garde-fou : date du jour proposée par défaut (à confirmer), aucun contrôle de durée légale de
  conservation, d'exercice clos ni de factures non soldées ; une date postérieure au dernier
  inventaire fausse le recalcul de stock (`Cstock` somme `Fiches_HistoLigfac`). Correction proposée :
  date maximale = fin du dernier exercice clos et antérieure de N années · tests : T01 · sources :
  [RazHistoFac.class:30](../../../../.src/Archivages/RazHistoFac.class#L30), [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134)
- [ ] RAZHISTOFAC-A02 — [anomalie, à confirmer] Tables liées non purgées → orphelins :
  `Fiches_HisentMat`, `Fiches_Suivis`, `Fiches_Traites`, `Fiches_Lcr`, `Fiches_BordereauxC`,
  `Fiches_Bl.numfac`, `Fiches_ligcons`/`Fiches_ligregie`, `Docs_Ged` (fichiers PDF compris).
  Correction : purger (ou conserver volontairement) chaque table, décision par table · tests : T01 ·
  sources : [RazHistoFac.class:36-37](../../../../.src/Archivages/RazHistoFac.class#L36-L37), [RazHistoFac.class:49-50](../../../../.src/Archivages/RazHistoFac.class#L49-L50)
- [ ] RAZHISTOFAC-A03 — [anomalie] Sauvegarde non fiable : code retour de `mysqldump` ignoré, mot de
  passe en clair dans la ligne de commande, fichier écrasé à chaque purge · tests : T06 · sources :
  [RazHistoFac.class:29](../../../../.src/Archivages/RazHistoFac.class#L29)
- [ ] RAZHISTOFAC-A04 — [anomalie, à confirmer] SQLite : `datefac < 'AAAAMMJJ'` (affinité NUMERIC)
  ne sélectionne pas les dates stockées en texte → purge sans effet · tests : T06 · sources : [RazHistoFac.class:30](../../../../.src/Archivages/RazHistoFac.class#L30), [RazHistoFac.class:43](../../../../.src/Archivages/RazHistoFac.class#L43)
