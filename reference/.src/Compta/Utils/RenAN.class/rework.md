# RenAN — Rework

> Source : `.src/Compta/Utils/RenAN.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/RenAN.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 12 | 3 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RENAN-001 — [documentation] Commentaire d'en-tête : table `Fiches_Mvtoc` disparue, script
  inopérant, en attente de retrait (RENAN-A01) · appelants : aucun · tests : T01 · sources : [RenAN.class:run](../../../../../.src/Compta/Utils/RenAN.class#L5-L19)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RENAN-A01 — [anomalie] Script sur `Fiches_Mvtoc` (table inexistante) : erreur SQL à chaque
  lancement ; supprimer la classe et l'entrée `RenAN` de `Prgm` (même commit que PRGM-A06) ·
  tests : T01 · sources : [RenAN.class:10](../../../../../.src/Compta/Utils/RenAN.class#L10), [Prgm.class:74](../../../../../.src/Communs/Prgm.class#L74)
