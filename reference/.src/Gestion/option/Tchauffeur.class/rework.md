# Tchauffeur — Rework

> Source : `.src/Gestion/option/Tchauffeur.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Tchauffeur.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 6 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 6 | 2 | 1 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TCHAUFFEUR-001 — [documentation] En-tête de classe en français : écran « Fiche chauffeurs »
  inachevé, non raccordé au menu, sans table ni handler de barre ; renvoi vers l'anomalie A01 ·
  appelants : aucun · tests : T01 · sources : [Tchauffeur.class:_new](../../../../../.src/Gestion/option/Tchauffeur.class#L5-L9)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TCHAUFFEUR-A01 — [anomalie] Couple `Tchauffeur.class` + `Tchauffeur.form` mort (aucun
  appelant, aucune table, barre `bar1` sans handler, `TextBox7_KeyPress` vide) : suppression du
  couple à décider par l'utilisateur (ou achèvement de l'écran, hors rework) · tests : T01 ·
  sources : [Tchauffeur.class:_new](../../../../../.src/Gestion/option/Tchauffeur.class#L5-L9), [Tchauffeur.class:TextBox7_KeyPress](../../../../../.src/Gestion/option/Tchauffeur.class#L11-L15)
