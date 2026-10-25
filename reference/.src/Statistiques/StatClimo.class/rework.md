# StatClimo — Rework

> Source : `.src/Statistiques/StatClimo.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatClimo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 235 |
| Lignes de commentaire | 37 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 37 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 235 | 62 | 37 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATCLIMO-001 — [documentation] En-tête en français : sources (archivées + en cours),
  rôle de la case `Bl`, structure de `Total` ; corriger les commentaires inversés « Sans/avec
  les BL » · appelants : aucun · tests : T01-T06 · sources : [StatClimo.class:245](../../../../.src/Statistiques/StatClimo.class#L245), [StatClimo.class:251](../../../../.src/Statistiques/StatClimo.class#L251), [StatClimo.class:Traitement](../../../../.src/Statistiques/StatClimo.class#L161-L308)
- [ ] STATCLIMO-002 — [code mort] Supprimer `dte1`, `dte2`, `dateN1` et ses appels (jamais lus),
  `Tot`, `Frmt`, les lignes commentées · appelants : aucun · tests : T01-T06 · sources : [StatClimo.class:dateN1](../../../../.src/Statistiques/StatClimo.class#L82-L89), [StatClimo.class:_New](../../../../.src/Statistiques/StatClimo.class#L33-L57), [StatClimo.class:258](../../../../.src/Statistiques/StatClimo.class#L258)
- [ ] STATCLIMO-003 — [complexité] Noms de tables en dur → `Cbase.Table(…)` ; test de saisie des
  dates simplifié (même valeur) · appelants : aucun · tests : T01, T06 · sources : [StatClimo.class:Traitement](../../../../.src/Statistiques/StatClimo.class#L161-L308), [StatClimo.class:205](../../../../.src/Statistiques/StatClimo.class#L205)
- [ ] STATCLIMO-004 — [réduction de portée] `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private`
  (`dateN1` supprimée par 002) · appelants : aucun · tests : T01, T06 · sources : [StatClimo.class:dteN0_LF](../../../../.src/Statistiques/StatClimo.class#L119-L133), [StatClimo.class:dteN1_LF](../../../../.src/Statistiques/StatClimo.class#L138-L159), [StatClimo.class:Traitement](../../../../.src/Statistiques/StatClimo.class#L161-L308)
- [ ] STATCLIMO-005 — [commonalisation] Déléguer dates, `TotalCree`, sélection des entêtes et des
  lignes (factures et BL) à `StatCommun.module` (STATCOMM-005) ; même SQL · appelants : aucun ·
  tests : T01-T07 · sources : [StatClimo.class:191](../../../../.src/Statistiques/StatClimo.class#L191), [StatClimo.class:207](../../../../.src/Statistiques/StatClimo.class#L207), [StatClimo.class:212](../../../../.src/Statistiques/StatClimo.class#L212), [StatClimo.class:247](../../../../.src/Statistiques/StatClimo.class#L247)
- [ ] STATCLIMO-006 — [séparation traitement/GUI] Extraire `CalculTotal(sDeb, sFin, iSource,
  bAvecBl)` sans contrôles · appelants : aucun · tests : T01-T05, T08 · sources : [StatClimo.class:Traitement](../../../../.src/Statistiques/StatClimo.class#L161-L308)
- [ ] STATCLIMO-007 — [complexité] Calcul A/M d'un jeu de lignes et cumul client factorisés
  (`CumulLignes`, utilisé pour factures et BL, conversion `M` des factures sans `cpoint`
  conservée) ; cumul en mémoire puis `INSERT` (SQL modifié, dump identique) (CC 37 → ≤ 12 visé) ·
  appelants : aucun · tests : T01-T05, T08 · sources : [StatClimo.class:216](../../../../.src/Statistiques/StatClimo.class#L216), [StatClimo.class:264](../../../../.src/Statistiques/StatClimo.class#L264), [StatClimo.class:228](../../../../.src/Statistiques/StatClimo.class#L228), [StatClimo.class:276](../../../../.src/Statistiques/StatClimo.class#L276)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATCLIMO-A01 — [anomalie] « Inclure les BL » : `… AND type = &3 OR type = &4` sans
  parenthèses → tous les BL de type `B`, quelle que soit leur date, sont ajoutés · tests : T02 · sources : [StatClimo.class:247](../../../../.src/Statistiques/StatClimo.class#L247), [StatClimo.class:248](../../../../.src/Statistiques/StatClimo.class#L248), [StatClimo.class:249](../../../../.src/Statistiques/StatClimo.class#L249)
- [ ] STATCLIMO-A02 — [anomalie] Factures en cours (`Fiches_Bl` type `F`) toujours incluses, sans
  contrôle de recouvrement avec les factures archivées (double comptage possible, à confirmer),
  alors que les autres écrans se limitent aux factures archivées · tests : T01 · sources : [StatClimo.class:252](../../../../.src/Statistiques/StatClimo.class#L252), [StatClimo.class:207](../../../../.src/Statistiques/StatClimo.class#L207)
- [ ] STATCLIMO-A03 — [anomalie] Source « Toutes » : lignes lues par `union` de `HistoLigfac` et
  `HistoLigfacM` (et `Ligbl`/`LigblM`) sur le **même numéro** → lignes d'une autre facture de même
  numéro ajoutées, et lignes identiques fusionnées par `UNION` · tests : T03 · sources : [StatClimo.class:214](../../../../.src/Statistiques/StatClimo.class#L214), [StatClimo.class:262](../../../../.src/Statistiques/StatClimo.class#L262)
- [ ] STATCLIMO-A04 — [anomalie] Lignes `M` des factures archivées converties par `Val()` sans
  `cpoint` : un montant au format `"12.50"` provoque « Type mismatch » et interrompt le
  traitement (la branche BL utilise `cpoint`) · tests : T04 · sources : [StatClimo.class:222](../../../../.src/Statistiques/StatClimo.class#L222), [StatClimo.class:223](../../../../.src/Statistiques/StatClimo.class#L223), [StatClimo.class:270](../../../../.src/Statistiques/StatClimo.class#L270)
- [ ] STATCLIMO-A05 — [anomalie] Table de travail `Total` partagée entre postes et écrans de
  structures différentes (= STATCOMM-A05, STATCAI-A04) · tests : T01 · sources : [StatClimo.class:191](../../../../.src/Statistiques/StatClimo.class#L191), [StatClimo.class:192](../../../../.src/Statistiques/StatClimo.class#L192)
