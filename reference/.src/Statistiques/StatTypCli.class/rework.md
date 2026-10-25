# StatTypCli — Rework

> Source : `.src/Statistiques/StatTypCli.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatTypCli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 208 |
| Lignes de commentaire | 33 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 25 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 208 | 50 | 25 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATTYPCLI-001 — [documentation] En-tête en français : rôle, structure de `Total`
  partagée avec `VisStatTypCli`, sources (factures archivées), calcul N-1 · appelants : aucun ·
  tests : T01-T05 · sources : [StatTypCli.class:Traitement](../../../../.src/Statistiques/StatTypCli.class#L161-L277)
- [ ] STATTYPCLI-002 — [code mort] Supprimer `Tot`, `Frmt`, `If IsNull(TotA)`, `TotA = TotA + 0`
  et l'argument inutilisé `rResult!pnmclifac` (`&3`) de l'`UPdate` (texte SQL identique après
  substitution) · appelants : aucun · tests : T01-T03 · sources : [StatTypCli.class:_New](../../../../.src/Statistiques/StatTypCli.class#L34-L57), [StatTypCli.class:232](../../../../.src/Statistiques/StatTypCli.class#L232), [StatTypCli.class:243](../../../../.src/Statistiques/StatTypCli.class#L243)
- [ ] STATTYPCLI-003 — [complexité] Noms de tables en dur → `Cbase.Table(…)` ; test de saisie des
  dates simplifié (même valeur) · appelants : aucun · tests : T01, T05 · sources : [StatTypCli.class:Traitement](../../../../.src/Statistiques/StatTypCli.class#L161-L277), [StatTypCli.class:197](../../../../.src/Statistiques/StatTypCli.class#L197)
- [ ] STATTYPCLI-004 — [réduction de portée] `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` →
  `Private` · appelants : aucun · tests : T01, T05 · sources : [StatTypCli.class:dateN1](../../../../.src/Statistiques/StatTypCli.class#L82-L89), [StatTypCli.class:dteN0_LF](../../../../.src/Statistiques/StatTypCli.class#L119-L133), [StatTypCli.class:dteN1_LF](../../../../.src/Statistiques/StatTypCli.class#L138-L159), [StatTypCli.class:Traitement](../../../../.src/Statistiques/StatTypCli.class#L161-L277)
- [ ] STATTYPCLI-005 — [commonalisation] Déléguer dates, création de `Total`, sélection des
  factures et calcul des remises à `StatCommun.module` (créé par STATCOMM-005, + `RemisesFacture`
  partagé avec `StatComm`) ; même SQL · appelants : aucun · tests : T01-T06 · sources : [StatTypCli.class:dateN1](../../../../.src/Statistiques/StatTypCli.class#L82-L89), [StatTypCli.class:dteN0_LF](../../../../.src/Statistiques/StatTypCli.class#L119-L133), [StatTypCli.class:188](../../../../.src/Statistiques/StatTypCli.class#L188), [StatTypCli.class:212](../../../../.src/Statistiques/StatTypCli.class#L212), [StatComm.class:203](../../../../.src/Statistiques/StatComm.class#L203)
- [ ] STATTYPCLI-006 — [séparation traitement/GUI] Extraire `CalculTotal(sDeb, sFin, sDebN1,
  sFinN1, iSource)` sans accès aux contrôles · appelants : aucun · tests : T01-T04, T07 · sources : [StatTypCli.class:Traitement](../../../../.src/Statistiques/StatTypCli.class#L161-L277)
- [ ] STATTYPCLI-007 — [complexité] Cumul en mémoire puis `INSERT` (SQL modifié, dump
  identique), **après** STATTYPCLI-A01 (la multiplication du N-1 dépend de la boucle actuelle)
  (CC 25 → ≤ 10 visé) · appelants : aucun · tests : T01-T03, T07 · sources : [StatTypCli.class:Traitement](../../../../.src/Statistiques/StatTypCli.class#L161-L277)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATTYPCLI-A01 — [anomalie] N-1 calculé dans la boucle des factures N : le N-1 d'un client
  est ajouté autant de fois qu'il a de factures en N ; clients sans facture N absents du N-1 ;
  colonne « Net N-1 » et « % N/N-1 » de `VisStatTypCli` faussées · tests : T03 · sources : [StatTypCli.class:239](../../../../.src/Statistiques/StatTypCli.class#L239), [StatTypCli.class:251](../../../../.src/Statistiques/StatTypCli.class#L251)
- [ ] STATTYPCLI-A02 — [anomalie] Le N-1 lit toujours `Fiches_HistoFac`, même pour les sources
  « Factures entretien » ou « Toutes » (incohérent avec N et avec `StatComm`) · tests : T02 · sources : [StatTypCli.class:239](../../../../.src/Statistiques/StatTypCli.class#L239), [StatComm.class:249](../../../../.src/Statistiques/StatComm.class#L249)
- [ ] STATTYPCLI-A03 — [anomalie] `CliResult!cli_typec` et `TypResult!code` lus sans test
  `Available` : facture d'un client supprimé ou client d'un type supprimé → erreur d'exécution,
  traitement interrompu · tests : T04 · sources : [StatTypCli.class:203](../../../../.src/Statistiques/StatTypCli.class#L203), [StatTypCli.class:206](../../../../.src/Statistiques/StatTypCli.class#L206)
- [ ] STATTYPCLI-A04 — [anomalie] Table de travail `Total` partagée entre postes et écrans de
  structures différentes (= STATCOMM-A05, STATCAI-A04) · tests : T01 · sources : [StatTypCli.class:188](../../../../.src/Statistiques/StatTypCli.class#L188), [StatTypCli.class:189](../../../../.src/Statistiques/StatTypCli.class#L189)
