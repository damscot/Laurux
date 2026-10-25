# Htickets — Rework

> Source : `.src/Reports/Htickets.class` · Message de commit (phase 4) : `reference/.src/Reports/Htickets.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 6 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 33 | 6 | 1 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HTICKETS-001 — [documentation] En-tête de classe en français : rôle (réimpression A4 d'un
  ticket archivé), absence de pagination, contrat des positions ; `'''` par méthode · appelants :
  aucun · tests : T01 · sources : [Htickets.class:Entete](../../../../.src/Reports/Htickets.class#L20-L24), [Htickets.class:Entete2](../../../../.src/Reports/Htickets.class#L26-L32), [Htickets.class:Level4](../../../../.src/Reports/Htickets.class#L45-L54)
- [ ] HTICKETS-002 — [code mort] Supprimer `Footer` (jamais appelé, vérifié), `_free` (vide), puis
  `_new`, `R`, `G`, `B` qui ne servaient qu'à `Footer` · appelants : aucun · tests : T01, T03 · sources : [Htickets.class:Footer](../../../../.src/Reports/Htickets.class#L35-L42), [Htickets.class:_free](../../../../.src/Reports/Htickets.class#L16-L18), [Htickets.class:_new](../../../../.src/Reports/Htickets.class#L8-L14)
- [ ] HTICKETS-003 — [complexité] `Entete2` : retirer le paramètre ignoré `PosX` et typer `PosY`
  en `Integer` (flux identique) · appelants : `ArchivesTck` (2 appels) · tests : T01, T03 · sources : [Htickets.class:Entete2](../../../../.src/Reports/Htickets.class#L26-L32), [ArchivesTck.class:599](../../../../.src/Archivages/ArchivesTck.class#L599), [ArchivesTck.class:654](../../../../.src/Archivages/ArchivesTck.class#L654)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] HTICKETS-A01 — [anomalie] Aucune pagination : au-delà de y ≈ 287 mm, chaque `Level4`
  déclenche le saut de page automatique de `PdfWriter.Cell` et part seul en haut d'une nouvelle
  page (une page par ligne pour un ticket de plus de ~45 lignes, à confirmer par T02).
  Correction : saut de page explicite dans `ArchivesTck` (seuil, `Entete`, reprise de `PosY`) ·
  tests : T02, T03 · sources : [Htickets.class:Level4](../../../../.src/Reports/Htickets.class#L45-L54), [ArchivesTck.class:633](../../../../.src/Archivages/ArchivesTck.class#L633)
