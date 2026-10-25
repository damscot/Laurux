# RazHistoFbl — Rework

> Source : `.src/Archivages/RazHistoFbl.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazHistoFbl.class/rework.md <REWORK_ID>`

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

- [ ] RAZHISTOFBL-001 — [documentation] En-tête en français : rôle, tables, clé `(four, numrecpt)`,
  borne `<` stricte, effet sur `Cstock` et sur les réceptions non validées, défaut A01 ·
  appelants : aucun · tests : aucun · sources : [RazHistoFbl.class:Button1_Click](../../../../.src/Archivages/RazHistoFbl.class#L16-L45)
- [ ] RAZHISTOFBL-002 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite) As Integer`
  (SQL identique) appelée par `Button1_Click` · appelants : aucun · tests : T01-T04 · sources : [RazHistoFbl.class:Button1_Click](../../../../.src/Archivages/RazHistoFbl.class#L16-L45)
- [ ] RAZHISTOFBL-003 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003) et
  squelette commun `Epuration` (RAZRLVB-006) ; la boucle reste locale tant que A01 n'est pas
  tranchée · prérequis : SAUVESAUTO-003, RAZRLVB-006 · appelants : aucun · tests : T01, T02, T06 · sources : [RazHistoFbl.class:27](../../../../.src/Archivages/RazHistoFbl.class#L27), [RazHistoFbl.class:Button1_Click](../../../../.src/Archivages/RazHistoFbl.class#L16-L45)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZHISTOFBL-A01 — [anomalie] **Perte de données hors période** : `DELETE … where numrecpt = &1`
  sans `four` → la réception d'un autre fournisseur de même numéro (n° de BL fournisseur) est
  supprimée avec ses lignes, quelle que soit sa date. Correction : `where four = &1 and numrecpt = &2`
  (famille EDREGUL-A01) · tests : T03 · sources : [RazHistoFbl.class:34-35](../../../../.src/Archivages/RazHistoFbl.class#L34-L35)
- [ ] RAZHISTOFBL-A02 — [anomalie] Sauvegarde non fiable : code retour de `mysqldump` ignoré, mot de
  passe en clair, fichier écrasé ; libellés incohérents des messages de fin (« Bons de réception » /
  « BL fournisseurs ») · tests : T06 · sources : [RazHistoFbl.class:27](../../../../.src/Archivages/RazHistoFbl.class#L27), [RazHistoFbl.class:41-42](../../../../.src/Archivages/RazHistoFbl.class#L41-L42)
- [ ] RAZHISTOFBL-A03 — [anomalie, à confirmer] Aucun garde-fou : les réceptions non validées
  (`validee = 0`, pas encore rapprochées d'une facture) sont purgées, et une date postérieure au
  dernier inventaire fausse le recalcul de stock (`Cstock` somme `Fiches_Ligrecpt` depuis
  l'inventaire). Correction proposée : exclure `validee = 0` et refuser une date postérieure au
  dernier inventaire · tests : T04, T05 · sources : [RazHistoFbl.class:28](../../../../.src/Archivages/RazHistoFbl.class#L28), [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134)
- [ ] RAZHISTOFBL-A04 — [anomalie, à confirmer] SQLite : `ddate < 'AAAAMMJJ'` (affinité NUMERIC) ne
  sélectionne pas les dates stockées en texte → purge sans effet · tests : T06 · sources : [RazHistoFbl.class:28](../../../../.src/Archivages/RazHistoFbl.class#L28)
