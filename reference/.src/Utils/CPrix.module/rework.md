# CPrix — Rework

> Source : `.src/Utils/CPrix.module` · Message de commit (phase 4) : `reference/.src/Utils/CPrix.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Cascade`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 15 | 5 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CPRIX-001 — [documentation] Commentaires `'''` : formule de `Cascade`, format de retour,
  table lue par `CTva` · appelants : aucun · tests : aucun · sources : [CPrix.module:Cascade](../../../../.src/Utils/CPrix.module#L3-L11), [CPrix.module:CTva](../../../../.src/Utils/CPrix.module#L13-L24)
- [ ] CPRIX-002 — [complexité] `Cascade` : variable `Float` et conversion explicite `CStr` (même
  chaîne) ; `CTva` : `SELECT taux_tva` · appelants : aucun · tests : T01, T02 · sources : [CPrix.module:Cascade](../../../../.src/Utils/CPrix.module#L3-L11), [CPrix.module:CTva](../../../../.src/Utils/CPrix.module#L13-L24)
