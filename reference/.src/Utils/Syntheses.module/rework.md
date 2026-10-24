# Syntheses — Rework

> Source : `.src/Utils/Syntheses.module` · Message de commit (phase 4) : `reference/.src/Utils/Syntheses.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 4 (`Message`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 12 | 4 | 4 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SYNTHESES-001 — [documentation] Commentaire de rôle : option `/son2`, dépendances
  `pico2wave`/`aplay` · appelants : aucun · tests : aucun · sources : [Syntheses.module:Message](../../../../.src/Utils/Syntheses.module#L5-L17)
- [ ] SYNTHESES-002 — [code mort] `Musique` en `Const` ; `Message` déclarée `Sub` (aucun appelant
  n'exploite la valeur de retour, vérifié par grep sur les 17 appels) · appelants : aucun
  changement de code · tests : T01, T02 · sources : [Syntheses.module:3](../../../../.src/Utils/Syntheses.module#L3), [Syntheses.module:5](../../../../.src/Utils/Syntheses.module#L5)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] SYNTHESES-A01 — [anomalie] `Shell "pico2wave ; aplay msg.wav"` relance `pico2wave` sans
  argument, et `msg.wav` est écrit dans le répertoire courant sans être supprimé. Correction :
  `Exec ["aplay", Temp$()…]` puis suppression · tests : T02 · sources : [Syntheses.module:11-13](../../../../.src/Utils/Syntheses.module#L11-L13)
