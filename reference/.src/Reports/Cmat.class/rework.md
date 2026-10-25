# Cmat — Rework

> Source : `.src/Reports/Cmat.class` · Message de commit (phase 4) : `reference/.src/Reports/Cmat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 54 |
| Lignes de commentaire | 4 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 8 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 54 | 8 | 1 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CMAT-001 — [documentation] En-tête de classe en français : rôle (liste des matériels,
  appelant `EdMat`), colonnes imprimées ; `'''` par méthode · appelants : aucun · tests : T01 · sources : [Cmat.class:_new](../../../../.src/Reports/Cmat.class#L9-L16), [Cmat.class:Level2](../../../../.src/Reports/Cmat.class#L57-L72)
- [ ] CMAT-002 — [code mort] Supprimer `_free` (vide), `Ligne` et `Ligne2` (aucun appelant,
  vérifié par `grep`) et les membres `R`/`G`/`B` · appelants : aucun · tests : T01 · sources : [Cmat.class:_free](../../../../.src/Reports/Cmat.class#L18-L20), [Cmat.class:Ligne](../../../../.src/Reports/Cmat.class#L74-L78), [Cmat.class:Ligne2](../../../../.src/Reports/Cmat.class#L80-L84)
- [ ] CMAT-003 — [commonalisation] Hériter de la base `PdfLaurux` (CARTICLES-004) : `_new` →
  `CouleurTheme`, `Entete` → `TitrePage`, `Footer` → `PiedDePage(190)` ; `Level1`/`Level2` via
  `EnteteColonnes`/`LigneColonnes` (CARTICLES-005) ; flux identique · appelants : aucun · tests :
  T01, T02 · sources : [Cmat.class:Entete](../../../../.src/Reports/Cmat.class#L22-L29), [Cmat.class:Footer](../../../../.src/Reports/Cmat.class#L32-L38), [Cmat.class:Level1](../../../../.src/Reports/Cmat.class#L41-L54), [Cmat.class:Level2](../../../../.src/Reports/Cmat.class#L57-L72)
