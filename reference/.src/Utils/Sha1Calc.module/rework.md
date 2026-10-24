# Sha1Calc — Rework

> Source : `.src/Utils/Sha1Calc.module` · Message de commit (phase 4) : `reference/.src/Utils/Sha1Calc.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 115 |
| Lignes de commentaire | 15 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 15 (`CalcSha1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 115 | 31 | 15 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SHA1CALC-001 — [documentation] En-tête : finalité (inaltérabilité), règles de chaînage
  (écriture précédente, table `M`, deux dernières modifications), liste des champs hachés **figée** ·
  appelants : aucun · tests : aucun · sources : [Sha1Calc.module:3](../../../../.src/Utils/Sha1Calc.module#L3), [Sha1Calc.module:CalcSha1](../../../../.src/Utils/Sha1Calc.module#L6-L75)
- [ ] SHA1CALC-002 — [code mort] Supprimer `s2Result` (`CalcSha1_all`, `CalcSha1_Verify`) et `$cle2`
  (`CalcSha1_Verify`) · appelants : aucun · tests : T01, T04 · sources : [Sha1Calc.module:CalcSha1_all](../../../../.src/Utils/Sha1Calc.module#L77-L94), [Sha1Calc.module:CalcSha1_Verify](../../../../.src/Utils/Sha1Calc.module#L96-L119)
- [ ] SHA1CALC-003 — [complexité] Extraire `ClePrecedente(Tab, TabM, numecr)`, `TableModif(Tab)` et
  `CleEcriture(cle2, ligne)` de `CalcSha1` (CC 15 → ≤ 6), mêmes requêtes et même concaténation ·
  appelants : aucun · tests : T01 à T05, T07 · sources : [Sha1Calc.module:CalcSha1](../../../../.src/Utils/Sha1Calc.module#L6-L75)
- [ ] SHA1CALC-004 — [séparation traitement/GUI] `CalcSha1_all` : boucle de recalcul séparée de la
  `ProgBar` (même affichage, même interruption) · appelants : `LauruxMaj`, `Prgm`, `FClotureAn`
  (inchangés) · tests : T01, T07 · sources : [Sha1Calc.module:CalcSha1_all](../../../../.src/Utils/Sha1Calc.module#L77-L94)
- [ ] SHA1CALC-005 — [complexité] `CalcSha1T` : `CleTicket(ticket, clePrec)` pure et lecture du ticket
  précédent sortie de la boucle (même résultat, une requête de moins par ligne) · appelants : aucun ·
  tests : T06 · sources : [Sha1Calc.module:CalcSha1T](../../../../.src/Utils/Sha1Calc.module#L122-L156)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SHA1CALC-A01 — [anomalie] Clé dépendante de la conversion texte des types renvoyés par le
  pilote (dates, décimaux) : clés potentiellement différentes entre MySQL et SQLite (à confirmer
  par T05) ; toute correction impose un recalcul complet des clés en production · tests : T05 · sources : [Sha1Calc.module:65](../../../../.src/Utils/Sha1Calc.module#L65), [Sha1Calc.module:131-132](../../../../.src/Utils/Sha1Calc.module#L131-L132)
- [ ] SHA1CALC-A02 — [anomalie] `CalcSha1_Verify` considère valide une ligne dont `control` est
  `NULL` (écriture jamais scellée non signalée) · tests : T04 · sources : [Sha1Calc.module:111](../../../../.src/Utils/Sha1Calc.module#L111)
