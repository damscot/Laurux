# LibelFac — Rework

> Source : `.src/Gestion/Tables/LibelFac.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/LibelFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 35 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 4 (`Btn_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 35 | 10 | 4 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LIBELFAC-001 — [documentation] Commentaires : UPDATE sans `WHERE` volontaire (toutes les
  lignes), lecteur `ObjFac`, limite de 250 caractères · appelants : aucun · tests : aucun ·
  sources : [LibelFac.class:Button2_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)
- [ ] LIBELFAC-002 — [code mort] Supprimer `Music.Load` (jamais joué) et la branche tag 1 vide de
  `Btn_Click` · appelants : aucun · tests : T01 · sources : [LibelFac.class:32](../../../../../.src/Gestion/Tables/LibelFac.class#L32), [LibelFac.class:Btn_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L48-L64)
- [ ] LIBELFAC-003 — [réarchitecture] `Cbase.Table("TabLibelFac")` au lieu du nom en dur (SQL
  identique) · appelants : aucun · tests : T01-T02 · sources : [LibelFac.class:Form_Open](../../../../../.src/Gestion/Tables/LibelFac.class#L37-L46), [LibelFac.class:Button2_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)
- [ ] LIBELFAC-004 — [commonalisation] Fonctions « texte unique » partagées avec Tleg et Tmail
  (voir TLEG-003) · appelants : aucun · tests : T01-T03 · sources : [LibelFac.class:Form_Open](../../../../../.src/Gestion/Tables/LibelFac.class#L37-L46), [LibelFac.class:Button2_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)
- [ ] LIBELFAC-005 — [réduction de portée] `Button2_Click` → `Private` (pseudo-handler appelé par
  `Btn_Click`) · appelants : aucun · tests : T01 · sources : [LibelFac.class:Button2_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LIBELFAC-A01 — [anomalie] Texte vide non enregistrable (impossible d'effacer le bas de
  facture) ; `ReplaceLb` altère `"` et `&` ; aucun retour visuel après l'enregistrement · tests :
  T01 · sources : [LibelFac.class:72](../../../../../.src/Gestion/Tables/LibelFac.class#L72), [LibelFac.class:73](../../../../../.src/Gestion/Tables/LibelFac.class#L73)
