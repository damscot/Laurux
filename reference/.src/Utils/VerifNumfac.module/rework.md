# VerifNumfac — Rework

> Source : `.src/Utils/VerifNumfac.module` · Message de commit (phase 4) : `reference/.src/Utils/VerifNumfac.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 3 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 26 (`Dnfac`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 86 | 26 | 26 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VERIFNUMFAC-001 — [code mort] Supprimer `VerifNumfac.module` (aucun appelant) · appelants :
  aucun · tests : T01 · sources : [VerifNumfac.module:Dnfac](../../../../.src/Utils/VerifNumfac.module#L3-L93)
- [ ] VERIFNUMFAC-002 — [code mort] (seulement si 001 est refusé) Supprimer les calculs inutilisés
  `N5`, `bfacture`, `b3facture` et leurs requêtes · tests : T02 · sources : [VerifNumfac.module:11-58](../../../../.src/Utils/VerifNumfac.module#L11-L58)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] VERIFNUMFAC-A01 — [anomalie] Mode Matériel : les tests sur `HistoFacM`/`BlM` écrasent ceux sur
  `HistoFac`/`Bl` au lieu de les combiner (numéro déclaré libre à tort) · tests : T02 · sources : [VerifNumfac.module:74-87](../../../../.src/Utils/VerifNumfac.module#L74-L87)
