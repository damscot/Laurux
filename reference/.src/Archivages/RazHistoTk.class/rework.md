# RazHistoTk — Rework

> Source : `.src/Archivages/RazHistoTk.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazHistoTk.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 33 | 9 | 7 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZHISTOTK-001 — [documentation] En-tête en français : rôle (purge des tickets archivés par
  le moulinage), tables, borne `<` stricte, lecteurs des données purgées, défaut A01 · appelants :
  aucun · tests : aucun · sources : [RazHistoTk.class:Button1_Click](../../../../.src/Archivages/RazHistoTk.class#L16-L45)
- [ ] RAZHISTOTK-002 — [réarchitecture] Clés `Cbase` `TabHisEntTck`/`TabHisLigTck` à la place des
  doublons `TabHEntTck`/`TabHLigTck` (même table physique, SQL identique) · appelants : aucun ·
  tests : T01 · sources : [RazHistoTk.class:28](../../../../.src/Archivages/RazHistoTk.class#L28), [RazHistoTk.class:34-35](../../../../.src/Archivages/RazHistoTk.class#L34-L35)
- [ ] RAZHISTOTK-003 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite) As Integer`
  (SQL identique, `ProgBar` conservée) appelée par `Button1_Click` · appelants : aucun · tests :
  T01-T04 · sources : [RazHistoTk.class:Button1_Click](../../../../.src/Archivages/RazHistoTk.class#L16-L45)
- [ ] RAZHISTOTK-004 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003) et
  squelette commun `Epuration` (RAZRLVB-006), dont `PurgeEnteteLignes` partagée avec `RazHistoFac`,
  `RazHistoFbl`, `RazDevis` (SQL identique) · prérequis : SAUVESAUTO-003, RAZRLVB-006 · appelants :
  aucun · tests : T01-T05 · sources : [RazHistoTk.class:Button1_Click](../../../../.src/Archivages/RazHistoTk.class#L16-L45), [RazHistoFac.class:Button1_Click](../../../../.src/Archivages/RazHistoFac.class#L18-L61)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZHISTOTK-A01 — [anomalie, à confirmer] Suppression **par numéro seul** (`numero` non
  unique) : un ticket de même numéro postérieur à la date (autre caisse, doublon) et ses lignes sont
  supprimés aussi (famille MOULINAGE-A10). Correction : supprimer l'en-tête par `lInd` et les lignes
  par `numero` + `date` · tests : T03 · sources : [RazHistoTk.class:34-35](../../../../.src/Archivages/RazHistoTk.class#L34-L35)
- [ ] RAZHISTOTK-A02 — [anomalie, décision utilisateur] Aucun garde-fou : date du jour proposée par
  défaut (à confirmer), pas de borne liée à la durée légale de conservation des justificatifs de
  caisse ni au dernier moulinage ; la chaîne d'intégrité `control`/`prev_numero` perd son début.
  Correction proposée : refuser une date plus récente que N années (paramètre) · tests : T01 ·
  sources : [RazHistoTk.class:28](../../../../.src/Archivages/RazHistoTk.class#L28)
- [ ] RAZHISTOTK-A03 — [anomalie] Sauvegarde non fiable : code retour de `mysqldump` ignoré, mot de
  passe en clair dans la ligne de commande, fichier écrasé à chaque purge · tests : T05 · sources :
  [RazHistoTk.class:27](../../../../.src/Archivages/RazHistoTk.class#L27)
- [ ] RAZHISTOTK-A04 — [anomalie, à confirmer] SQLite : `date < 'AAAAMMJJ'` (affinité NUMERIC) ne
  sélectionne pas les dates stockées en texte → purge sans effet · tests : T06 · sources : [RazHistoTk.class:28](../../../../.src/Archivages/RazHistoTk.class#L28)
