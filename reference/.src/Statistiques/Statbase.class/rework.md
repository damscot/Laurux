# Statbase — Rework

> Source : `.src/Statistiques/Statbase.class` · Message de commit (phase 4) : `reference/.src/Statistiques/Statbase.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 32 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 32 | 2 | 1 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATBASE-001 — [documentation] En-tête en français : rôle (compteurs d'utilisation, pas
  une classe de base), tableau contrôle → table · appelants : aucun · tests : T01, T02 · sources : [Statbase.class:_new](../../../../.src/Statistiques/Statbase.class#L3-L44)
- [ ] STATBASE-002 — [code mort] Supprimer `Coulfc` et `Frmt` (couleurs lues, jamais utilisées) ·
  appelants : aucun · tests : T01 · sources : [Statbase.class:9](../../../../.src/Statistiques/Statbase.class#L9), [Statbase.class:11](../../../../.src/Statistiques/Statbase.class#L11)
- [ ] STATBASE-003 — [séparation traitement/GUI] Extraire `Compteurs()` (10 requêtes, même ordre,
  même SQL) ; `_new` remplit les `TextLabel` · appelants : aucun · tests : T01-T04 · sources : [Statbase.class:_new](../../../../.src/Statistiques/Statbase.class#L3-L44)
- [ ] STATBASE-004 — [complexité] Table de correspondance (clé `Cbase`, filtre `type`, contrôle)
  parcourue en boucle au lieu de 10 blocs copiés (même SQL, même ordre) · appelants : aucun ·
  tests : T01-T04 · sources : [Statbase.class:_new](../../../../.src/Statistiques/Statbase.class#L3-L44)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATBASE-A01 — [anomalie] « Nombre de tickets de caisse archivés » compte
  `Fiches_EntTicketz` (`TabEntTck`, tickets en cours) au lieu de `Fiches_HisEntTickets`
  (`TabHEntTck`) · tests : T02 · sources : [Statbase.class:32](../../../../.src/Statistiques/Statbase.class#L32)
- [ ] STATBASE-A02 — [anomalie] « Nombre de factures archivées » ne compte pas les factures
  d'entretien `Fiches_HistoFacM` (à confirmer avec l'utilisateur) · tests : T02 · sources : [Statbase.class:29](../../../../.src/Statistiques/Statbase.class#L29)
