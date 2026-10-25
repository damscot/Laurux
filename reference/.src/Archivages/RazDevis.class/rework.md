# RazDevis — Rework

> Source : `.src/Archivages/RazDevis.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazDevis.class/rework.md <REWORK_ID>`

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

- [ ] RAZDEVIS-001 — [documentation] En-tête en français : rôle (devis `type = 'D'`), tables purgées
  et non purgées, option matériel, sauvegarde partagée avec `RazClientd` · appelants : aucun ·
  tests : aucun · sources : [RazDevis.class:Button1_Click](../../../../.src/Archivages/RazDevis.class#L18-L61)
- [ ] RAZDEVIS-002 — [complexité] Factoriser les deux blocs devis / devis entretien (SQL et libellés
  identiques) · appelants : aucun · tests : T01-T03 · sources : [RazDevis.class:30-55](../../../../.src/Archivages/RazDevis.class#L30-L55)
- [ ] RAZDEVIS-003 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite, bMateriel)
  As Integer` appelée par `Button1_Click` · appelants : aucun · tests : T01-T03 · sources : [RazDevis.class:Button1_Click](../../../../.src/Archivages/RazDevis.class#L18-L61)
- [ ] RAZDEVIS-004 — [commonalisation] `Utils.DumpBase` (SAUVESAUTO-003) et
  `Epuration.PurgeEnteteLignes` partagée avec `RazHistoFac` (RAZHISTOFAC-004) · prérequis :
  SAUVESAUTO-003, RAZRLVB-006 · appelants : aucun · tests : T01-T04 · sources : [RazDevis.class:Button1_Click](../../../../.src/Archivages/RazDevis.class#L18-L61), [RazHistoFac.class:Button1_Click](../../../../.src/Archivages/RazHistoFac.class#L18-L61)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZDEVIS-A01 — [anomalie, à confirmer] Tables liées non purgées → orphelins :
  `Fiches_AdrlivBL`, `Fiches_EntMat`, `Fiches_Suivis.numdev`, `Docs_Ged`. Correction : supprimer
  aussi ces lignes (comme `ObjFacB` pour l'adresse de livraison) · tests : T01 · sources : [RazDevis.class:36-37](../../../../.src/Archivages/RazDevis.class#L36-L37), [ObjFacB.class:1094](../../../../.src/Gestion/option/ObjFacB.class#L1094)
- [ ] RAZDEVIS-A02 — [anomalie] Sauvegarde : fichier `EffaceD.sql` partagé avec `RazClientd`
  (écrasement mutuel), code retour de `mysqldump` ignoré, mot de passe en clair · tests : T04 ·
  sources : [RazDevis.class:29](../../../../.src/Archivages/RazDevis.class#L29)
- [ ] RAZDEVIS-A03 — [anomalie] Libellés du `.form` copiés de `RazHistoFac` : titre « Epuration des
  factures archivées. » et infobulle « Quitte la saisie de la facturation fin de mois » (correction
  dans le `.form`, validation requise) · tests : aucun · sources : [RazDevis.class:_new](../../../../.src/Archivages/RazDevis.class#L3-L8)
- [ ] RAZDEVIS-A04 — [anomalie, à confirmer] SQLite : `datebl < 'AAAAMMJJ'` (affinité NUMERIC) ne
  sélectionne pas les dates stockées en texte → purge sans effet ; aucun garde-fou sur la date (date
  du jour par défaut, à confirmer) · tests : T05 · sources : [RazDevis.class:30](../../../../.src/Archivages/RazDevis.class#L30), [RazDevis.class:43](../../../../.src/Archivages/RazDevis.class#L43)
