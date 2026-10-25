# Epurmvtexp — Rework

> Source : `.src/Gestion/Stock/Epurmvtexp.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Epurmvtexp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 109 |
| Lignes de commentaire | 28 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 109 | 21 | 7 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EPURMVTEXP-001 — [documentation] En-tête en français : rôle (purge des mouvements
  exceptionnels jusqu'à `date2`), origine des dates proposées, tables lues par d'autres modules
  (`Cstock`, `Stockmvt`), défaut A01 · appelants : aucun · tests : aucun · sources : [Epurmvtexp.class:Form_Open](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L46-L66), [Epurmvtexp.class:Button1_Click](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L133-L163)
- [ ] EPURMVTEXP-002 — [code mort] Supprimer `date1_LostFocus` et `date2_LostFocus` (contrôles
  du groupe `Cmpt`, jamais levés) et les membres `jour`, `dterpt`, `B` (jamais relus) ·
  appelants : aucun · tests : T01-T05 · sources : [Epurmvtexp.class:date1_LostFocus](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L83-L97), [Epurmvtexp.class:date2_LostFocus](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L102-L125), [Epurmvtexp.class:28-36](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L28-L36)
- [ ] EPURMVTEXP-003 — [séparation traitement/GUI] Fonction privée `Purge(sDateFin)` regroupant
  la lecture et les `DELETE` (SQL identique, défaut A01 conservé), appelée par `Button1_Click` ·
  appelants : aucun · tests : T01-T03 · sources : [Epurmvtexp.class:Button1_Click](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L133-L163)
- [ ] EPURMVTEXP-004 — [réduction de portée] `Aff_date` → `Private` (appel interne seulement) ·
  appelants : aucun · tests : T04 · sources : [Epurmvtexp.class:Aff_date](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L68-L78)
- [ ] EPURMVTEXP-005 — [réarchitecture] `Cbase.Table("TabMvtexp")` à la place de
  `"Fiches_Mvtexp"` (nom physique identique) · appelants : aucun · tests : T01 · sources : [Epurmvtexp.class:145](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L145)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EPURMVTEXP-A01 — [anomalie] **CRITIQUE** : `DELETE FROM Fiches_Mvtexp WHERE mind` sans
  `= &1` → dès le premier mouvement ≤ `date2`, **toute** la table est vidée (mouvements
  postérieurs compris), ce qui fausse le recalcul de stock (`Cstock`) et l'historique
  (`Stockmvt`). Correction : `WHERE mind = &1`, ou un seul `DELETE … WHERE daterecpt <= &1` ·
  tests : T01, T02 · sources : [Epurmvtexp.class:150](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L150)
- [ ] EPURMVTEXP-A02 — [anomalie] Les contrôles de date (`date1_LostFocus`, `date2_LostFocus`)
  ne sont jamais exécutés (groupe `Cmpt` sans handler) : date invalide ou `date2 < date1`
  acceptées. Correction : handler `Cmpt_LostFocus` aiguillant sur `Last` (alternative à la
  suppression EPURMVTEXP-002, décision utilisateur) · tests : T05 · sources : [Epurmvtexp.class:date1_LostFocus](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L83-L97), [Epurmvtexp.class:date2_LostFocus](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L102-L125)
- [ ] EPURMVTEXP-A03 — [anomalie] `date1` (début de période) est affichée mais ignorée : la purge
  porte sur tout ce qui précède `date2`. À aligner sur le texte de l'écran (« pour la période
  proposée ») ou retirer la zone · tests : T01 · sources : [Epurmvtexp.class:149](../../../../../.src/Gestion/Stock/Epurmvtexp.class#L149)
