# Edinv1 — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 126 |
| Lignes de commentaire | 28 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 15 (`TriArticles`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 126 | 27 | 15 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDINV1-001 — [documentation] Commentaire d'en-tête signalant la classe comme inutilisée et
  remplacée par `Edinv("F")`, en attendant la décision sur EDINV1-A01 · appelants : aucun · tests : T01 ·
  sources : [Edinv1.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class#L38-L65)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDINV1-A01 — [anomalie] Supprimer le couple `Edinv1.class` + `Edinv1.form` (aucun appelant,
  remplacé par `Edinv("F")`) · tests : T01, EDINV-T01..T07 · sources : [Edinv1.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class#L38-L65), [Edinv1.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class#L136-L166)
