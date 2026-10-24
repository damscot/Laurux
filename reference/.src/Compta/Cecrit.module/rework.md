# Cecrit — Rework

> Source : `.src/Compta/Cecrit.module` · Message de commit (phase 4) : `reference/.src/Compta/Cecrit.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 71 |
| Lignes de commentaire | 1 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 8 (`Ecrit_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 71 | 17 | 8 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CECRIT-001 — [code mort] Supprimer le module `Cecrit.module` (10 fonctions, aucun appelant ;
  pas de `.form` associé, donc rework et non anomalie) · appelants : aucun · tests : T01, `gbc3 -agt` ·
  sources : [Cecrit.module:Ecrit_Data](../../../../.src/Compta/Cecrit.module#L5-L31), [Cecrit.module:Debe1](../../../../.src/Compta/Cecrit.module#L49-L54), [Cecrit.module:Debn4](../../../../.src/Compta/Cecrit.module#L98-L103)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

_Aucune : le SQL concaténé (`like "%<Sel>%"`) disparaît avec le module._
