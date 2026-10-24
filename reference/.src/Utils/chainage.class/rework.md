# chainage — Rework

> Source : `.src/Utils/chainage.class` · Message de commit (phase 4) : `reference/.src/Utils/chainage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 76 |
| Lignes de commentaire | 2 |
| Fonctions | 10 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 13 (`saisie_keypress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 76 | 31 | 13 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHAINAGE-001 — [documentation] En-tête : rôle, touches gérées, différence `_new`/`add`
  (observateur après/avant), avertissement sur `tableaux` (référence interne) · tests : aucun · sources : [chainage.class:_new](../../../../.src/Utils/chainage.class#L9-L19), [chainage.class:add](../../../../.src/Utils/chainage.class#L80-L89), [chainage.class:tableaux_Read](../../../../.src/Utils/chainage.class#L118-L122)
- [ ] CHAINAGE-002 — [code mort] Supprimer `modif` et `addintercale` (aucun appelant) ; `$obs` en
  variable locale · appelants : aucun · tests : T01, T04 · sources : [chainage.class:modif](../../../../.src/Utils/chainage.class#L100-L107), [chainage.class:addintercale](../../../../.src/Utils/chainage.class#L91-L98), [chainage.class:4](../../../../.src/Utils/chainage.class#L4)
- [ ] CHAINAGE-003 — [complexité] `recherche` via `$text.Find(text)` (identique pour une liste non
  vide) · appelants : aucun · tests : T01, T04, T05, T07 · sources : [chainage.class:recherche](../../../../.src/Utils/chainage.class#L67-L78)
- [ ] CHAINAGE-004 — [séparation traitement/GUI] Fonctions privées `Suivant(i)`/`Precedent(i)` (bouclage)
  appelées par `saisie_keypress` · tests : T04, T05 · sources : [chainage.class:saisie_keypress](../../../../.src/Utils/chainage.class#L34-L65)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CHAINAGE-A01 — [anomalie] `modif` : `Dim i As Object` → erreur de type (code mort ; corrigé de
  fait par CHAINAGE-002) · tests : T03 · sources : [chainage.class:102-105](../../../../.src/Utils/chainage.class#L102-L105)
- [ ] CHAINAGE-A02 — [anomalie] `recherche` sur liste vide → erreur hors bornes (corrigé de fait par
  CHAINAGE-003 : à valider) · tests : T01 · sources : [chainage.class:71-74](../../../../.src/Utils/chainage.class#L71-L74)
- [ ] CHAINAGE-A03 — [anomalie] `add` crée l'observateur sans `After` alors que `_new` utilise
  `After = True` (ordre des événements différent selon la méthode d'ajout) · tests : T07 · sources : [chainage.class:16](../../../../.src/Utils/chainage.class#L16), [chainage.class:86](../../../../.src/Utils/chainage.class#L86)
- [ ] CHAINAGE-A04 — [anomalie] `sup` laisse l'observateur actif : le contrôle retiré garde la
  coloration de focus · tests : T07 · sources : [chainage.class:sup](../../../../.src/Utils/chainage.class#L109-L116)
