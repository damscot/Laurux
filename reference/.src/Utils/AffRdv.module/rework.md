# AffRdv — Rework

> Source : `.src/Utils/AffRdv.module` · Message de commit (phase 4) : `reference/.src/Utils/AffRdv.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`Aff_Rdv`) |
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

- [ ] AFFRDV-001 — [documentation] Commentaires : déclenchement par `Fmenu.Timer1`, format des
  colonnes `haction`/`daction`, réentrance · appelants : aucun · tests : aucun · sources : [AffRdv.module:Aff_Rdv](../../../../.src/Utils/AffRdv.module#L3-L18), [AffRdv.module:Calc_Timer](../../../../.src/Utils/AffRdv.module#L20-L26)
- [ ] AFFRDV-002 — [réduction de portée] `Aff_Rdv` → `Private` · appelants : aucun · tests : T01, T02 · sources : [AffRdv.module:Aff_Rdv](../../../../.src/Utils/AffRdv.module#L3-L18)
- [ ] AFFRDV-003 — [séparation traitement/GUI] Fonction privée `TexteRdv() As String` (requête +
  construction des messages) ; `Aff_Rdv` garde `Syntheses.Message` et `Message.Warning`, textes
  identiques · appelants : aucun · tests : T01, T02 · sources : [AffRdv.module:Aff_Rdv](../../../../.src/Utils/AffRdv.module#L3-L18)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] AFFRDV-A01 — [anomalie, à confirmer] `Catch` vide : une erreur SQL toutes les minutes passe
  inaperçue ; et un rendez-vous peut être annoncé deux fois si le message est fermé dans la même
  minute · tests : T01 · sources : [AffRdv.module:16](../../../../.src/Utils/AffRdv.module#L16), [AffRdv.module:22-24](../../../../.src/Utils/AffRdv.module#L22-L24)
