# VisStatClimo — Rework

> Source : `.src/Statistiques/VisStatClimo.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisStatClimo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 185 |
| Lignes de commentaire | 23 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 19 |
| Complexité max (fonction) | 4 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 185 | 19 | 4 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISSTATCLIMO-001 — [documentation] En-tête en français : colonnes, formule du total,
  dépendance à `Total` de `StatClimo` · appelants : aucun · tests : T01-T04 · sources : [VisStatClimo.class:_New](../../../../.src/Statistiques/VisStatClimo.class#L41-L85), [VisStatClimo.class:Affichage](../../../../.src/Statistiques/VisStatClimo.class#L87-L112)
- [ ] VISSTATCLIMO-002 — [code mort] Supprimer `total`, `value`, `Coulfond`, `Frmt`, `Tab`,
  `Nbpage`, `Shell "cd"`, la requête `Fiches_Societes` et `Ste` (SQL modifié, lecture seule,
  dump identique) · appelants : aucun · tests : T01-T04 · sources : [VisStatClimo.class:_New](../../../../.src/Statistiques/VisStatClimo.class#L41-L85), [VisStatClimo.class:196](../../../../.src/Statistiques/VisStatClimo.class#L196), [VisStatClimo.class:197](../../../../.src/Statistiques/VisStatClimo.class#L197)
- [ ] VISSTATCLIMO-003 — [réduction de portée] `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`,
  `sens` → `Private` · appelants : aucun · tests : T01, T02 · sources : [VisStatClimo.class:Affichage](../../../../.src/Statistiques/VisStatClimo.class#L87-L112), [VisStatClimo.class:Sens_Aff](../../../../.src/Statistiques/VisStatClimo.class#L114-L122)
- [ ] VISSTATCLIMO-004 — [commonalisation] `Sens_Aff`, requête de tri et boucle d'impression vers
  le socle `StatCommun` (VISSTATCOMM-004), en conservant la conversion Float → String actuelle
  des lignes · appelants : aucun · tests : T01-T04 · sources : [VisStatClimo.class:Sens_Aff](../../../../.src/Statistiques/VisStatClimo.class#L114-L122), [VisStatClimo.class:Button2_Click](../../../../.src/Statistiques/VisStatClimo.class#L166-L242)
- [ ] VISSTATCLIMO-005 — [séparation traitement/GUI] Extraire `LignesTotal(sTri, sSens)` et le
  calcul des totaux d'impression · appelants : aucun · tests : T01-T03, T05 · sources : [VisStatClimo.class:Affichage](../../../../.src/Statistiques/VisStatClimo.class#L87-L112), [VisStatClimo.class:Button2_Click](../../../../.src/Statistiques/VisStatClimo.class#L166-L242)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISSTATCLIMO-A01 — [anomalie] Lignes du PDF : montants `Float` passés à `level2P`
  (paramètres `String`) → conversion implicite non localisée et non formatée (`12.5` au lieu de
  `12,50`), incohérente avec la ligne de total · tests : T03 · sources : [VisStatClimo.class:221](../../../../.src/Statistiques/VisStatClimo.class#L221), [Chistoriques.class:level2P](../../../../.src/Reports/Chistoriques.class#L343-L355)
