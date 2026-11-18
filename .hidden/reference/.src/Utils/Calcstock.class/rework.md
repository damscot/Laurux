# Calcstock — Rework

> Source : `.src/Utils/Calcstock.class` · Message de commit (phase 4) : `.hidden/reference/.src/Utils/Calcstock.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 133 |
| Lignes de commentaire | 43 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 133 | 31 | 15 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALCSTOCK-001 — [documentation] En-tête : les 4 modes, les pré-conditions, le contrat avec
  `Cstock` (boutons publics lus par le module jusqu'à CSTOCK-003) · appelants : aucun · tests :
  aucun · sources : [Calcstock.class:Button2_Click](../../../../../.src/Utils/Calcstock.class#L50-L111)
- [ ] CALCSTOCK-002 — [code mort] Supprimer `Art_man` (jamais appelée) et les lignes commentées des
  `Cbx*_Click` · tests : T01-T03 · sources : [Calcstock.class:Art_man](../../../../../.src/Utils/Calcstock.class#L188-L211), [Calcstock.class:Cbx_Click](../../../../../.src/Utils/Calcstock.class#L113-L130)
- [ ] CALCSTOCK-003 — [séparation traitement/GUI] Extraire `ControleCaisses() As String` et
  `RazNonStockes()` sans contrôle GUI ; `Button2_Click` affiche les messages (mêmes textes) · tests :
  T04-T07 · sources : [Calcstock.class:Button2_Click](../../../../../.src/Utils/Calcstock.class#L50-L111)
- [ ] CALCSTOCK-004 — [réarchitecture] Passer le mode à `Cstock.Calc_stock` (voir CSTOCK-003, même
  commit) · appelants : `Cstock`, `Validinv` · tests : T01-T03, CSTOCK-T01..T03, CSTOCK-T09 · sources : [Calcstock.class:Button2_Click](../../../../../.src/Utils/Calcstock.class#L50-L111), [Cstock.module:Calc_stock](../../../../../.src/Utils/Cstock.module#L11-L134)
- [ ] CALCSTOCK-005 — [réduction de portée] `SelectionArt` → `Private` · tests : T01 · sources : [Calcstock.class:SelectionArt](../../../../../.src/Utils/Calcstock.class#L173-L183)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALCSTOCK-A01 — [anomalie] « Traitement terminé » affiché alors que rien n'a été fait (bornes
  manquantes, produit vide) · tests : T02, T08 · sources : [Calcstock.class:90](../../../../../.src/Utils/Calcstock.class#L90), [Calcstock.class:108](../../../../../.src/Utils/Calcstock.class#L108)
- [ ] CALCSTOCK-A02 — [anomalie] Message « …numéro <code>est connectée » sans espace ; curseur
  `Mouse.Pointing` au lieu de `Mouse.Default` en fin de traitement ; zones de saisie non masquées
  quand on coche `Cbx4` · tests : T04, T05 · sources : [Calcstock.class:61](../../../../../.src/Utils/Calcstock.class#L61), [Calcstock.class:107](../../../../../.src/Utils/Calcstock.class#L107)
- [ ] CALCSTOCK-A03 — [anomalie] `Button2_Click` : `If rResult!connecte = "1"` (l. 60) n'est jamais vrai sur MySQL (`connecte` `tinyint(1)` lu `True`) : le recalcul est lancé alors qu'une caisse est connectée ; motif transverse « colonne `tinyint(1)` lue en Booléen par le pilote MySQL (`True` = -1) comparée à `1` ou `"1"` → toujours faux » : voir aussi [EDDOCS-A05](../../Gestion/Impressions/EdDocs.class/rework.md), [TRIHISTOS-A06](../../Affichages/TriHistos.class/rework.md), [Fcaisses](../../Caisse/Fcaisses.class/rework.md), [Materiel](../../Gestion/Tables/Materiel.class/rework.md) (phase 2, vague 8, 2026-11-16) · tests : T05 (xfail) · sources : [Calcstock.class:60](../../../../../.src/Utils/Calcstock.class#L60)
