# Ccomptes — Rework

> Source : `.src/Compta/Ccomptes.module` · Message de commit (phase 4) : `reference/.src/Compta/Ccomptes.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 3 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 6 (`Colco_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 97 | 24 | 6 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CCOMPTES-001 — [documentation] En-tête en français : rôle (aide d'affichage de `FComptes`),
  contrat avec `Utils.rs3`, colonnes affichées · appelants : aucun · tests : aucun ·
  sources : [Ccomptes.module:Colco_Data](../../../../.src/Compta/Ccomptes.module#L5-L39)
- [ ] CCOMPTES-002 — [code mort] Supprimer `Deb4`…`Deb9` (aucun appelant), la variable `Fnt` et
  la ligne `Font` commentée ; `CoTable` ramené à 5 cases · appelants : aucun · tests : T01-T03 ·
  sources : [Ccomptes.module:Deb4](../../../../.src/Compta/Ccomptes.module#L68-L77), [Ccomptes.module:Deb9](../../../../.src/Compta/Ccomptes.module#L125-L134), [Ccomptes.module:9](../../../../.src/Compta/Ccomptes.module#L9), [Ccomptes.module:35](../../../../.src/Compta/Ccomptes.module#L35)
- [ ] CCOMPTES-003 — [commonalisation] `Deb2`/`Deb3` → helper privé `Charge(Colco, Tab, Tri, Sel,
  sOrdre)`, signatures `Public` conservées, SQL identique · appelants : `FComptes` (inchangé) ·
  tests : T01-T03 · sources : [Ccomptes.module:Deb2](../../../../.src/Compta/Ccomptes.module#L54-L59), [Ccomptes.module:Deb3](../../../../.src/Compta/Ccomptes.module#L61-L66)
- [ ] CCOMPTES-004 — [réarchitecture] Paramétrer la recherche : `like &1` avec `Sel & "%"` via
  `Utils.db.Subst` (SQL modifié : guillemets, résultat identique car `FComptes` filtre déjà
  `"`, `&`, `'`, `\` ; dump identique) · appelants : `FComptes` · tests : T02 ·
  sources : [Ccomptes.module:56](../../../../.src/Compta/Ccomptes.module#L56), [Ccomptes.module:63](../../../../.src/Compta/Ccomptes.module#L63)
- [ ] CCOMPTES-005 — [commonalisation] Couleur de fond `Coul_fen` par un helper `LCoul.FondGrille()`
  partagé avec les ~36 écrans qui relisent ce réglage (voir LCOUL) · appelants : aucun ·
  tests : T04 · sources : [Ccomptes.module:Colco_Data](../../../../.src/Compta/Ccomptes.module#L5-L39), [LCoul.class:Ecr_DB_bgcolor](../../../../.src/Utils/LCoul.class#L110-L120)
- [ ] CCOMPTES-006 — [réarchitecture] Intégrer le module dans `FComptes` (appelant unique) :
  `Colco_Data`, `Tris`, `Deb2`, `Deb3` deviennent des méthodes privées de `FComptes` ·
  appelants : `FComptes` (mis à jour dans le même commit) · tests : T01-T04 ·
  sources : [Ccomptes.module:Colco_Data](../../../../.src/Compta/Ccomptes.module#L5-L39), [FComptes.class:Colco_Data](../../../../.src/Compta/Tables/FComptes.class#L721-L725), [FComptes.class:Dbclk](../../../../.src/Compta/Tables/FComptes.class#L825-L835)
- [ ] CCOMPTES-007 — [séparation traitement/GUI] Fonction pure `RequeteListe(Tab, Tri, Sel,
  bDesc) As String` appelée par `Deb2`/`Deb3`, testable en gb.test (SQL identique) ·
  appelants : aucun · tests : T05, T01-T03 · sources : [Ccomptes.module:Deb2](../../../../.src/Compta/Ccomptes.module#L54-L59), [Ccomptes.module:Deb3](../../../../.src/Compta/Ccomptes.module#L61-L66)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CCOMPTES-A01 — [anomalie] `Colco_Data` : si `Str(champ)` échoue, `CoulB`/`CoulF` restent à 0
  (cellule noire sur fond noir) ; initialiser les couleurs hors du `If Not Error` (à confirmer, cas
  théorique) · tests : T04 · sources : [Ccomptes.module:18-27](../../../../.src/Compta/Ccomptes.module#L18-L27)
