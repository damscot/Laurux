# Site — Rework

> Source : `.src/Gestion/Site.module` · Message de commit (phase 4) : `reference/.src/Gestion/Site.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 9 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`connect_site`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 9 | 1 | 1 | 1 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SITE-001 — [code mort] Supprimer `Site.module` (`ServeurB` et `connect_site` jamais
  référencés ; connexion jamais ouverte). Fichier `.module` sans `.form` : pas d'anomalie requise ·
  appelants : aucun (`Fsoc:355-356` vise le contrôle `Site` de `Fsoc.form`) · tests : T01, T02 ·
  sources : [Site.module:connect_site](../../../../.src/Gestion/Site.module#L5-L14), [Site.module:3](../../../../.src/Gestion/Site.module#L3)

### Anomalies : changement de comportement, validation utilisateur requise

_Aucune._
