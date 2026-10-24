# HistoCom — Rework

> Source : `.src/Utils/HistoCom.class` · Message de commit (phase 4) : `reference/.src/Utils/HistoCom.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 11 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 4 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 11 | 4 | 4 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HISTOCOM-001 — [documentation] Commentaire : contexte du bogue 3.16, idempotence, écrasement
  de `com_ligfac` · tests : aucun · sources : [HistoCom.class:run](../../../../.src/Utils/HistoCom.class#L5-L18)
- [ ] HISTOCOM-002 — [complexité] `Do … Loop Until` → `Repeat … Until` · tests : T01, T02 · sources : [HistoCom.class:11-15](../../../../.src/Utils/HistoCom.class#L11-L15)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] HISTOCOM-A01 — [anomalie] Écrase un `com_ligfac` existant ; script de réparation d'une version
  de 2016 toujours accessible : à retirer de `Prgm` (ou à protéger) après validation · appelants :
  `Prgm` · tests : T01 · sources : [HistoCom.class:13](../../../../.src/Utils/HistoCom.class#L13), [Prgm.class:106-110](../../../../.src/Communs/Prgm.class#L106-L110)
