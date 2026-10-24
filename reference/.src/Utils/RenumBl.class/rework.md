# RenumBl — Rework

> Source : `.src/Utils/RenumBl.class` · Message de commit (phase 4) : `reference/.src/Utils/RenumBl.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 18 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 8 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 29 | 8 | 8 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RENUMBL-001 — [documentation] Avertissement en tête décrivant les trois mises à jour massives
  réellement effectuées · tests : aucun · sources : [RenumBl.class:run](../../../../.src/Utils/RenumBl.class#L4-L52)
- [ ] RENUMBL-002 — [code mort] Supprimer la variable `numfac` inutilisée et le bloc commenté l.38-50 ·
  tests : T01 · sources : [RenumBl.class:8](../../../../.src/Utils/RenumBl.class#L8), [RenumBl.class:38-50](../../../../.src/Utils/RenumBl.class#L38-L50)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] RENUMBL-A01 — [anomalie] Script destructeur accessible sans confirmation : **supprimer** la classe
  et l'entrée `Prgm.class:111` (ou ajouter confirmation + transaction) · appelants : `Prgm` · tests : T03 · sources : [RenumBl.class:run](../../../../.src/Utils/RenumBl.class#L4-L52), [Prgm.class:111](../../../../.src/Communs/Prgm.class#L111)
- [ ] RENUMBL-A02 — [anomalie] Étape 1 : tous les types de ligne de factures forcés à `"A"` ·
  tests : T01 · sources : [RenumBl.class:11-16](../../../../.src/Utils/RenumBl.class#L11-L16)
- [ ] RENUMBL-A03 — [anomalie] Étape 3 : `WHERE num_ligbl` seul → toutes les lignes d'un BL reçoivent
  les montants de la dernière ligne traitée ; taux forcé à `"4"` ; séparateur décimal dépendant de
  la locale · tests : T01, T02 · sources : [RenumBl.class:35](../../../../.src/Utils/RenumBl.class#L35)
