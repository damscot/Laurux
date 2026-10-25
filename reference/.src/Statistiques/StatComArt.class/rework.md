# StatComArt — Rework

> Source : `.src/Statistiques/StatComArt.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatComArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 30 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 41 |
| Complexité max (fonction) | 16 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 162 | 41 | 16 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATCOMART-001 — [documentation] Corriger l'en-tête (nom `StatComArt.class`, titre « CA
  articles par commercial »), décrire la structure de `Total` et les sources · appelants : aucun
  · tests : T01-T05 · sources : [StatComArt.class:21](../../../../.src/Statistiques/StatComArt.class#L21), [StatComArt.class:Traitement](../../../../.src/Statistiques/StatComArt.class#L160-L229)
- [ ] STATCOMART-002 — [code mort] Supprimer `dte1`, `dte2`, `dateN1` et ses appels (valeurs
  jamais lues), `Tot`, `Frmt`, `Tab5`, `netht = 0` · appelants : aucun · tests : T01-T05 · sources : [StatComArt.class:dateN1](../../../../.src/Statistiques/StatComArt.class#L81-L88), [StatComArt.class:_New](../../../../.src/Statistiques/StatComArt.class#L33-L56), [StatComArt.class:206](../../../../.src/Statistiques/StatComArt.class#L206)
- [ ] STATCOMART-003 — [complexité] Noms de tables en dur → `Cbase.Table(…)` ; test de saisie des
  dates simplifié (même valeur) · appelants : aucun · tests : T01, T05 · sources : [StatComArt.class:Traitement](../../../../.src/Statistiques/StatComArt.class#L160-L229), [StatComArt.class:185](../../../../.src/Statistiques/StatComArt.class#L185)
- [ ] STATCOMART-004 — [réduction de portée] `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private`
  (`dateN1` supprimée par 002) · appelants : aucun · tests : T01, T05 · sources : [StatComArt.class:dteN0_LF](../../../../.src/Statistiques/StatComArt.class#L118-L132), [StatComArt.class:dteN1_LF](../../../../.src/Statistiques/StatComArt.class#L137-L158), [StatComArt.class:Traitement](../../../../.src/Statistiques/StatComArt.class#L160-L229)
- [ ] STATCOMART-005 — [commonalisation] Déléguer dates, création de `Total` et sélection des
  factures/lignes à `StatCommun.module` (STATCOMM-005) ; `LignesFacture` commun avec `StatClimo`
  ; même SQL · appelants : aucun · tests : T01-T06 · sources : [StatComArt.class:dteN0_LF](../../../../.src/Statistiques/StatComArt.class#L118-L132), [StatComArt.class:176](../../../../.src/Statistiques/StatComArt.class#L176), [StatComArt.class:186](../../../../.src/Statistiques/StatComArt.class#L186), [StatClimo.class:212](../../../../.src/Statistiques/StatClimo.class#L212)
- [ ] STATCOMART-006 — [séparation traitement/GUI] Extraire `CalculTotal(sDeb, sFin, iSource)`
  sans contrôles · appelants : aucun · tests : T01-T04, T07 · sources : [StatComArt.class:Traitement](../../../../.src/Statistiques/StatComArt.class#L160-L229)
- [ ] STATCOMART-007 — [complexité] Cumul en mémoire puis `INSERT` (SQL modifié, dump identique)
  **après** STATCOMART-A01 · appelants : aucun · tests : T01-T03, T07 · sources : [StatComArt.class:Traitement](../../../../.src/Statistiques/StatComArt.class#L160-L229)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATCOMART-A01 — [anomalie] `UPdate` du cumul : `qte = &4` reçoit le code du commercial au
  lieu de la quantité cumulée (`&5` jamais utilisé) → la colonne « Quantité » est fausse pour
  tout article vendu plus d'une fois au même commercial · tests : T02 · sources : [StatComArt.class:202](../../../../.src/Statistiques/StatComArt.class#L202)
- [ ] STATCOMART-A02 — [anomalie] Factures d'entretien (`Face`/`Fact`) : leurs lignes sont
  cherchées dans `Fiches_HistoLigfac` au lieu de `Fiches_HistoLigfacM` → lignes absentes ou
  lignes d'une autre facture de même numéro · tests : T03 · sources : [StatComArt.class:193](../../../../.src/Statistiques/StatComArt.class#L193), [StatComArt.class:173](../../../../.src/Statistiques/StatComArt.class#L173)
- [ ] STATCOMART-A03 — [anomalie] Table de travail `Total` partagée entre postes et écrans de
  structures différentes (= STATCOMM-A05, STATCAI-A04) · tests : T01 · sources : [StatComArt.class:176](../../../../.src/Statistiques/StatComArt.class#L176), [StatComArt.class:177](../../../../.src/Statistiques/StatComArt.class#L177)
- [ ] STATCOMART-A04 — [anomalie] `cliResult!cli_comm` lu sans test `Available` : facture d'un
  client supprimé → erreur d'exécution, traitement interrompu · tests : T04 · sources : [StatComArt.class:191](../../../../.src/Statistiques/StatComArt.class#L191), [StatComArt.class:192](../../../../.src/Statistiques/StatComArt.class#L192)
