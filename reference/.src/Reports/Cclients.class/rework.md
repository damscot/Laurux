# Cclients — Rework

> Source : `.src/Reports/Cclients.class` · Message de commit (phase 4) : `reference/.src/Reports/Cclients.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 118 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 13 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 118 | 13 | 1 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CCLIENTS-001 — [documentation] En-tête de classe en français : rôle (listes de tiers),
  couples portrait/paysage, correspondance des colonnes `Level1` ↔ `Level2` sur deux lignes,
  paramètres de `Level2S` ; `'''` par méthode · appelants : aucun · tests : T01-T03 · sources : [Cclients.class:_new](../../../../.src/Reports/Cclients.class#L8-L14), [Cclients.class:Level1](../../../../.src/Reports/Cclients.class#L43-L60), [Cclients.class:Level2](../../../../.src/Reports/Cclients.class#L64-L83)
- [ ] CCLIENTS-002 — [code mort] Supprimer `_free` (vide) · appelants : aucun · tests : T01 · sources : [Cclients.class:_free](../../../../.src/Reports/Cclients.class#L16-L18)
- [ ] CCLIENTS-003 — [commonalisation] Hériter de la base `PdfLaurux` (CARTICLES-004) :
  `Entete`/`EnteteP` → `TitrePage(…, 206|292)`, `BasPage`/`BasPageP` → `PiedDePage(206|292)`,
  `Lines`/`LinesP` → `Trait(y, 2, 206|292)` ; noms publics conservés, flux identique ·
  appelants : aucun · tests : T01, T03, T05 · sources : [Cclients.class:Entete](../../../../.src/Reports/Cclients.class#L21-L29), [Cclients.class:EnteteP](../../../../.src/Reports/Cclients.class#L32-L40), [Cclients.class:BasPage](../../../../.src/Reports/Cclients.class#L147-L153), [Cclients.class:BasPageP](../../../../.src/Reports/Cclients.class#L165-L171), [Cclients.class:Lines](../../../../.src/Reports/Cclients.class#L138-L144), [Cclients.class:LinesP](../../../../.src/Reports/Cclients.class#L156-L162)
- [ ] CCLIENTS-004 — [complexité] `Level2S` : retirer les paramètres jamais imprimés `dom`,
  `codebanque`, `codeguichet` (PDF identique) · appelants : `ImpSage` (3 appels) · tests : T02,
  T05 · sources : [Cclients.class:Level2S](../../../../.src/Reports/Cclients.class#L86-L100), [ImpSage.class:203](../../../../.src/Compta/Utils/ImpSage.class#L203), [ImpSage.class:212](../../../../.src/Compta/Utils/ImpSage.class#L212), [ImpSage.class:221](../../../../.src/Compta/Utils/ImpSage.class#L221)
- [ ] CCLIENTS-005 — [commonalisation] `Level1`, `Level2`, `Level2S`, `Level1F`, `Level2F` via
  `EnteteColonnes`/`LigneColonnes` (CARTICLES-005), la cellule « Code » double hauteur restant
  explicite ; flux identique · appelants : aucun · tests : T01-T03 · sources : [Cclients.class:Level1](../../../../.src/Reports/Cclients.class#L43-L60), [Cclients.class:Level2](../../../../.src/Reports/Cclients.class#L64-L83), [Cclients.class:Level1F](../../../../.src/Reports/Cclients.class#L103-L117), [Cclients.class:Level2F](../../../../.src/Reports/Cclients.class#L121-L135)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CCLIENTS-A01 — [anomalie] `Level2` exige 13 arguments (`reglt` obligatoire) alors
  qu'`ImpJdv` en passe 12 : « Not enough arguments » à la première création de client d'un import
  du journal des ventes. Correction côté gabarit : `Optional reglt As String = ""` (alternative :
  IMPJDV-A04 côté appelant ; n'en valider qu'une) · tests : T04, IMPJDV-T02 · sources : [Cclients.class:64](../../../../.src/Reports/Cclients.class#L64), [ImpJdv.class:205](../../../../.src/Compta/Utils/ImpJdv.class#L205)
