# Raz — Rework

> Source : `.src/Communs/Raz.class` · Message de commit (phase 4) : `reference/.src/Communs/Raz.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 18 | 5 | 4 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZ-001 — [documentation] En-tête : rôle, table et colonne modifiées, lancement par `Prgm` ·
  appelants : aucun · tests : aucun · sources : [Raz.class:Button1_Click](../../../../.src/Communs/Raz.class#L3-L20)
- [ ] RAZ-002 — [complexité] Boucle d'UPDATE par article remplacée par un seul `UPdate … SET
  art_stocke = &1` (SQL modifié, dump identique) ; `SELECT` préalable conservé pour le cas « table
  vide » · appelants : aucun · tests : T01-T03 · sources : [Raz.class:8-13](../../../../.src/Communs/Raz.class#L8-L13)
- [ ] RAZ-003 — [séparation traitement/GUI] `RazStocke() As Boolean` privé pour le SQL ; question,
  curseur et messages dans le handler · appelants : aucun · tests : T01-T03 · sources : [Raz.class:Button1_Click](../../../../.src/Communs/Raz.class#L3-L20)
