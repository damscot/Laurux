# Recup — Rework

> Source : `.src/Utils/Recup.module` · Message de commit (phase 4) : `reference/.src/Utils/Recup.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 20 |
| Lignes de commentaire | 2 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 3 (`Group`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 20 | 4 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECUP-001 — [documentation] Commentaires en français sur les deux fonctions · appelants :
  aucun · tests : aucun · sources : [Recup.module:Group](../../../../.src/Utils/Recup.module#L4-L23), [Recup.module:Utilisateur](../../../../.src/Utils/Recup.module#L25-L29)
- [ ] RECUP-002 — [code mort] Supprimer `Group` (aucun appelant, lecture de fichier fragile) ·
  appelants : aucun · tests : T01 · sources : [Recup.module:Group](../../../../.src/Utils/Recup.module#L4-L23)
- [ ] RECUP-003 — [code mort] Remplacer `Recup.Utilisateur()` par `User.Name` dans
  `FRestore.class:67` puis supprimer le module · appelants : `FRestore` · tests : T01, replay de
  restauration (FRESTORE) · sources : [Recup.module:Utilisateur](../../../../.src/Utils/Recup.module#L25-L29), [FRestore.class:67](../../../../.src/Communs/FRestore.class#L67)
