# CalcRem — Rework

> Source : `.src/Utils/CalcRem.class` · Message de commit (phase 4) : `reference/.src/Utils/CalcRem.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 39 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 7 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 39 | 12 | 7 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALCREM-001 — [documentation] En-tête (rôle, accès par `Prgm`, tables lues/écrites, formule
  des remises) · appelants : aucun · tests : aucun · sources : [CalcRem.class:Button2_Click](../../../../.src/Utils/CalcRem.class#L21-L53)
- [ ] CALCREM-002 — [séparation traitement/GUI] Extraire la boucle de `Button2_Click` dans une
  fonction `RecalculeRemises()` sans contrôle ; le handler garde souris, son et message ; SQL émis
  identique · appelants : aucun · tests : T01-T04 · sources : [CalcRem.class:Button2_Click](../../../../.src/Utils/CalcRem.class#L21-L53)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALCREM-A01 — [anomalie] `Button2_Click` : la dernière facture (dans l'ordre de `num_ligfac`)
  n'est jamais mise à jour (pas d'`UPDATE` après la boucle) · tests : T01 · sources : [CalcRem.class:34-47](../../../../.src/Utils/CalcRem.class#L34-L47), [CalcRem.class:Button2_Click](../../../../.src/Utils/CalcRem.class#L21-L53)
- [ ] CALCREM-A02 — [anomalie] Cumuls Float écrits sans arrondi dans des `varchar(10)` : troncature ou
  erreur SQL en mode strict · tests : T02 · sources : [CalcRem.class:36](../../../../.src/Utils/CalcRem.class#L36), [CalcRem.class:42](../../../../.src/Utils/CalcRem.class#L42)
- [ ] CALCREM-A03 — [anomalie] `Music.Play` sans `Music.Load` ni test de `Start.son` (son joué même
  désactivé) · tests : T01 · sources : [CalcRem.class:48](../../../../.src/Utils/CalcRem.class#L48)
