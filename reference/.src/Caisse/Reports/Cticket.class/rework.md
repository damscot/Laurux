# Cticket — Rework

> Source : `.src/Caisse/Reports/Cticket.class` · Message de commit (phase 4) : `reference/.src/Caisse/Reports/Cticket.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 3 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 14 | 4 | 1 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CTICKET-001 — [code mort] Supprimer `Cticket.class` (classe jamais référencée, sans
  `.form`, `newPage`/`Entete2` jamais appelés, `Me.seto` inexistant) ; supprimer aussi
  `reference/.src/Caisse/Reports/Cticket.class/` · appelants : aucun · tests : `gbc3 -agt`,
  `./Laurux -T all` · sources : [Cticket.class:newPage](../../../../../.src/Caisse/Reports/Cticket.class#L15-L19), [Cticket.class:Entete2](../../../../../.src/Caisse/Reports/Cticket.class#L22-L29), [Cticket.class:24](../../../../../.src/Caisse/Reports/Cticket.class#L24)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : le code n'est jamais exécuté.
