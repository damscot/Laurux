# HitCarte — Rework

> Source : `.src/Statistiques/HitCarte.class` · Message de commit (phase 4) : `reference/.src/Statistiques/HitCarte.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 159 |
| Lignes de commentaire | 30 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 44 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 159 | 44 | 16 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HITCARTE-001 — [documentation] En-tête en français : rôle, enchaînement avec `VisHitCartes`,
  structure et durée de vie de la table `Total`, critères de tri (« CA » = points) · appelants : aucun ·
  tests : aucun · sources : [HitCarte.class:_New](../../../../.src/Statistiques/HitCarte.class#L32-L46), [HitCarte.class:Traitement](../../../../.src/Statistiques/HitCarte.class#L157-L229)
- [ ] HITCARTE-002 — [code mort] Supprimer `Tab = "Fiches_HistoFac"`, la deuxième affectation de
  `Tab2`, `Frmt`, `filename` et le couple `carte`/`TotA` sans effet (valeurs écrites identiques) ·
  appelants : aucun · tests : T01, T04 · sources : [HitCarte.class:_New](../../../../.src/Statistiques/HitCarte.class#L32-L46), [HitCarte.class:Traitement](../../../../.src/Statistiques/HitCarte.class#L157-L229)
- [ ] HITCARTE-003 — [commonalisation] Lecture de la carte par `LitCarte(code)` (FCLIENTCARTE-008),
  partagée avec `FClientcarte`, `Tricartes`, `Caisse.RecupClientd`, `EmailingCarte` (même requête
  `SELECT * … WHERE code = &1`) · appelants : aucun · tests : T01, T04 · sources : [HitCarte.class:186](../../../../.src/Statistiques/HitCarte.class#L186), [FClientcarte.class:Maj_Zones](../../../../.src/Caisse/FClientcarte.class#L140-L178)
- [ ] HITCARTE-004 — [séparation traitement/GUI] Extraire `RemplitHitParade(d0, d1) As Boolean`
  (DROP/CREATE + cumul dans `Total`, sans contrôle) ; `Traitement` garde le message de date, le choix
  du tri et l'ouverture de `VisHitCartes` · appelants : aucun · tests : T01-T07 · sources : [HitCarte.class:Traitement](../../../../.src/Statistiques/HitCarte.class#L157-L229)
- [ ] HITCARTE-005 — [complexité] Une requête d'agrégat par carte (`COUNT`, `SUM(points)` avec
  jointure `Fiches_Carte`) au lieu de deux `SELECT` par ticket ; **SQL modifié, dump identique** (à
  vérifier sur les arrondis) · appelants : aucun · tests : T01, T02, T04 · sources : [HitCarte.class:Traitement](../../../../.src/Statistiques/HitCarte.class#L157-L229)
- [ ] HITCARTE-006 — [commonalisation] `dteN0_LF`/`dteN1_LF` → `StatCommun.DateSaisie` et
  `DatesOrdonnees(d0, d1)` partagés avec `Histovmo`, `RelvMo`, `RelMoprod` et les `Stat*` (messages et
  focus gardés dans l'écran) · appelants : aucun · tests : T06 · sources : [HitCarte.class:dteN0_LF](../../../../.src/Statistiques/HitCarte.class#L117-L130), [HitCarte.class:dteN1_LF](../../../../.src/Statistiques/HitCarte.class#L135-L155), [Histovmo.class:dteN0_LF](../../../../.src/Statistiques/Histovmo.class#L97-L110)
- [ ] HITCARTE-007 — [réduction de portée] `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private`
  (aucun appelant externe) · appelants : aucun · tests : T01, T06 · sources : [HitCarte.class:dteN0_LF](../../../../.src/Statistiques/HitCarte.class#L117-L130), [HitCarte.class:dteN1_LF](../../../../.src/Statistiques/HitCarte.class#L135-L155), [HitCarte.class:Traitement](../../../../.src/Statistiques/HitCarte.class#L157-L229)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] HITCARTE-A01 — [anomalie] Table de travail `Total` partagée (nom et structure différents selon
  l'écran) : un traitement lancé pendant qu'un autre écran ou poste l'utilise la détruit (= TBORD-A03,
  STATCAI-A04 ; changement du dump) · tests : T01 · sources : [HitCarte.class:174](../../../../.src/Statistiques/HitCarte.class#L174), [HitCarte.class:175](../../../../.src/Statistiques/HitCarte.class#L175)
- [ ] HITCARTE-A02 — [anomalie] Les tickets supprimés (`suppr = 1`) sont comptés dans les visites et
  les points (`Histocliart` les exclut) · tests : T04 · sources : [HitCarte.class:182](../../../../.src/Statistiques/HitCarte.class#L182)
- [ ] HITCARTE-A03 — [anomalie] Borne de fin `date <= aaaammjj` sur une colonne `datetime` : les
  tickets du dernier jour après minuit sont exclus (`Histocliart` utilise `Fin_Jour`) · tests : T02 ·
  sources : [HitCarte.class:182](../../../../.src/Statistiques/HitCarte.class#L182)
- [ ] HITCARTE-A04 — [anomalie] Le tri libellé « CA » classe par **points** de fidélité, pas par
  chiffre d'affaires (à confirmer avec l'utilisateur : libellé ou calcul à corriger) · tests : T03 ·
  sources : [HitCarte.class:216](../../../../.src/Statistiques/HitCarte.class#L216), [VisHitCartes.class:76](../../../../.src/Statistiques/VisHitCartes.class#L76)
