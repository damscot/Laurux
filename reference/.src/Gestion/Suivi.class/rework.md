# Suivi — Rework

> Source : `.src/Gestion/Suivi.class` · Message de commit (phase 4) : `reference/.src/Gestion/Suivi.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 292 |
| Lignes de commentaire | 30 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 95 |
| Complexité max (fonction) | 14 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 292 | 95 | 14 | 0 | 31 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SUIVI-001 — [documentation] En-tête en français : prévu / réalisé, formules de marge et
  d'écart (avec la convention de signe actuelle), règles d'éditabilité selon les drapeaux du
  constructeur ; `'''` sur `_new` (sens des 11 paramètres, `DateF` inutilisé) · appelants : aucun ·
  tests : aucun · sources : [Suivi.class:_new](../../../../.src/Gestion/Suivi.class#L33-L125)
- [ ] SUIVI-002 — [complexité] `_new` : helper privé `LectureSeule(hCtrl)` pour les 9 blocs
  `ReadOnly` + fond, comportement identique · appelants : aucun · tests : T01, T02, T03 ·
  sources : [Suivi.class:_new](../../../../.src/Gestion/Suivi.class#L33-L125)
- [ ] SUIVI-003 — [commonalisation] Fusionner `Calc_MargeMo`/`Calc_MargeMo2`,
  `Calc_MargeArt`/`Calc_MargeArt2`, `Calc_MargeTotale`/`Calc_MargeTotale2` en fonctions
  paramétrées par les contrôles de la colonne ; ordre des mises à jour conservé · appelants :
  aucun · tests : T01, T02, T04 · sources : [Suivi.class:Calc_MargeMo](../../../../.src/Gestion/Suivi.class#L316-L323), [Suivi.class:Calc_MargeMo2](../../../../.src/Gestion/Suivi.class#L341-L348), [Suivi.class:Calc_MargeTotale2](../../../../.src/Gestion/Suivi.class#L358-L364)
- [ ] SUIVI-004 — [complexité] `Calc_Emarge` : deux soustractions directes au lieu des branches et
  du préfixe `"-"`, textes identiques (écart nul compris) · appelants : aucun · tests : T02, T04 ·
  sources : [Suivi.class:Calc_Emarge](../../../../.src/Gestion/Suivi.class#L366-L387)
- [ ] SUIVI-005 — [séparation traitement/GUI] Fonctions pures `MargeMo(qte, pu, prmo)`,
  `MargeArt(vtes, ach)`, `Ecart(a, b)` et SQL isolé dans `ChargeSuivi`/`EnregistreSuivi` sans
  accès aux contrôles · appelants : aucun · tests : T01 à T06 · sources : [Suivi.class:Calc_MargeMo](../../../../.src/Gestion/Suivi.class#L316-L323), [Suivi.class:Calc_MargeArt](../../../../.src/Gestion/Suivi.class#L325-L331), [Suivi.class:Button2_Click](../../../../.src/Gestion/Suivi.class#L389-L402)
- [ ] SUIVI-006 — [commonalisation] `Chkinput` → helper partagé `Utils.FiltreNumerique()` (même
  code que `SupprArt.ChkPrx`) · appelants : aucun · tests : T01 · sources : [Suivi.class:Chkinput](../../../../.src/Gestion/Suivi.class#L306-L314), [SupprArt.class:ChkPrx](../../../../.src/Gestion/SupprArt.class#L295-L303)
- [ ] SUIVI-007 — [réduction de portée] `Chkinput` et les 8 `Calc_*` → `Private` (aucun appelant
  externe, couverts par T01 à T04) · appelants : aucun · tests : T01 à T04 · sources : [Suivi.class:Chkinput](../../../../.src/Gestion/Suivi.class#L306-L314), [Suivi.class:Calc_Emarge](../../../../.src/Gestion/Suivi.class#L366-L387)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SUIVI-A01 — [anomalie] Prix de revient MO nul : le suivi enregistré n'est pas chargé (le
  `SELECT` est dans la branche `Else`) ; un enregistrement depuis cet écran vide écrase les
  valeurs existantes · tests : T05 · sources : [Suivi.class:86](../../../../.src/Gestion/Suivi.class#L86), [Suivi.class:89](../../../../.src/Gestion/Suivi.class#L89)
- [ ] SUIVI-A02 — [anomalie] Conventions de signe opposées des écarts : `EmargeMO = prévu − réalisé`
  mais `EmargeArt = réalisé − prévu`, puis `EmargeTot` les additionne · tests : T02, T04 ·
  sources : [Suivi.class:Calc_Emarge](../../../../.src/Gestion/Suivi.class#L366-L387)
- [ ] SUIVI-A03 — [anomalie] Clé incohérente : chargement et suppression par `numdev` + `code`,
  enregistrement par `numdev` seul (deux clients ayant le même n° de devis s'écrasent) · tests :
  T07 · sources : [Suivi.class:394](../../../../.src/Gestion/Suivi.class#L394), [Suivi.class:410](../../../../.src/Gestion/Suivi.class#L410)
- [ ] SUIVI-A04 — [anomalie] Consultation depuis `Archives` (tout en lecture seule) : le bouton
  Enregistrer reste actif ; si aucun suivi n'existe, il insère une ligne avec `numdev` vide ·
  tests : T03 · sources : [Suivi.class:Button2_Click](../../../../.src/Gestion/Suivi.class#L389-L402), [Archives.class:1435](../../../../.src/Archivages/Archives.class#L1435)
