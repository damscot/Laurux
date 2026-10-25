# VisHitCartes — Rework

> Source : `.src/Statistiques/VisHitCartes.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisHitCartes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 171 |
| Lignes de commentaire | 26 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 7 (`Draw_Chart`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 171 | 20 | 7 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISHITCARTES-001 — [documentation] En-tête en français : rôle, contrat avec `HitCarte`
  (paramètres, colonnes de `Total`), colonnes de la liste et du PDF · appelants : aucun · tests :
  aucun · sources : [VisHitCartes.class:_New](../../../../.src/Statistiques/VisHitCartes.class#L37-L104)
- [ ] VISHITCARTES-002 — [code mort] Supprimer `Tab3`, `Frmt`, `Coulfond`, `colors`, `dte` et le
  `Shell "cd …"` sans effet · appelants : aucun · tests : T01, T04 · sources : [VisHitCartes.class:_New](../../../../.src/Statistiques/VisHitCartes.class#L37-L104), [VisHitCartes.class:Draw_Chart](../../../../.src/Statistiques/VisHitCartes.class#L109-L176), [VisHitCartes.class:Button2_Click](../../../../.src/Statistiques/VisHitCartes.class#L178-L220)
- [ ] VISHITCARTES-003 — [séparation traitement/GUI] Extraire de `_New` la lecture
  `LitHitParade(tri, total) As Result` et le calcul pur `Ratios(points As Float[]) As Float[]` ; le
  constructeur garde la configuration et le remplissage de `Liste` (mêmes formats) · appelants :
  aucun · tests : T01, T02, T05 · sources : [VisHitCartes.class:_New](../../../../.src/Statistiques/VisHitCartes.class#L37-L104)
- [ ] VISHITCARTES-004 — [complexité] `value[n]` calculé depuis le Float arrondi à 2 décimales au lieu
  de `Val(.Item[3])` (relecture du texte localisé), valeurs identiques · appelants : aucun · tests :
  T01 · sources : [VisHitCartes.class:96](../../../../.src/Statistiques/VisHitCartes.class#L96)
- [ ] VISHITCARTES-005 — [commonalisation] `Draw_Chart` → helper d'histogramme commun avec `TBord`
  (TBORD-007), échelle propre à l'écran conservée · appelants : `TBord` (même commit) · tests : T01,
  TBORD-T01 · sources : [VisHitCartes.class:Draw_Chart](../../../../.src/Statistiques/VisHitCartes.class#L109-L176), [TBord.class:Draw_Chart](../../../../.src/Statistiques/TBord.class#L278-L359)
- [ ] VISHITCARTES-006 — [réduction de portée] `Draw_Chart` → `Private` (aucun appelant externe) ·
  appelants : aucun · tests : T01 · sources : [VisHitCartes.class:Draw_Chart](../../../../.src/Statistiques/VisHitCartes.class#L109-L176)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISHITCARTES-A01 — [anomalie] Ratio `points / Totl` sans protection : si toutes les cartes
  retenues ont 0 point, erreur de division à l'ouverture · tests : T03 · sources : [VisHitCartes.class:95](../../../../.src/Statistiques/VisHitCartes.class#L95)
- [ ] VISHITCARTES-A02 — [anomalie] Impression : titre différent entre la première page (« hit
  parades ») et les suivantes, PDF écrit sous `~/tmp/Edhit.kud` (extension `.kud`), visites non
  imprimées, curseur laissé en `Mouse.Pointing` · tests : T02 · sources : [VisHitCartes.class:191](../../../../.src/Statistiques/VisHitCartes.class#L191), [VisHitCartes.class:207](../../../../.src/Statistiques/VisHitCartes.class#L207), [VisHitCartes.class:47](../../../../.src/Statistiques/VisHitCartes.class#L47), [VisHitCartes.class:218](../../../../.src/Statistiques/VisHitCartes.class#L218)
- [ ] VISHITCARTES-A03 — [anomalie] Histogramme : `sumdata` déclaré `Integer` (somme des points
  tronquée) et barre dessinée même pour une valeur nulle (à confirmer visuellement) · tests : T01
  (contrôle visuel) · sources : [VisHitCartes.class:123](../../../../.src/Statistiques/VisHitCartes.class#L123), [VisHitCartes.class:168](../../../../.src/Statistiques/VisHitCartes.class#L168)
