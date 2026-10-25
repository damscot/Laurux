# Edmo — Rework

> Source : `.src/Gestion/Impressions/Edmo.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edmo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 370 |
| Lignes de commentaire | 64 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 83 |
| Complexité max (fonction) | 11 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 370 | 83 | 11 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDMO-001 — [documentation] En-tête en français (colonnes, règle HT temps/montant, TTC
  recalculé) ; corriger les commentaires « fournisseur » des listes de familles · appelants :
  aucun · tests : aucun · sources : [Edmo.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L422-L497), [Edmo.class:Colfam_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L327-L335)
- [ ] EDMO-002 — [code mort] Supprimer `Nbpage`, `dte`, le `Shell "cd …"`, les `With Utils` et le
  `Case 1` de `Btn_Click` · appelants : aucun · tests : T01 · sources : [Edmo.class:440](../../../../../.src/Gestion/Impressions/Edmo.class#L440), [Edmo.class:Btn_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L349-L365)
- [ ] EDMO-003 — [séparation traitement/GUI] `Valeur2TTC_Calcul` → fonction pure
  `MontantTTC(txht, taux) As String` + lecture du taux ; plus de membre `Montant` écrit en effet de
  bord · appelants : aucun · tests : T01, T07 · sources : [Edmo.class:Valeur2TTC_Calcul](../../../../../.src/Gestion/Impressions/Edmo.class#L502-L516)
- [ ] EDMO-004 — [complexité] Cache des taux de TVA par code pendant l'impression (une requête par
  code) ; **SQL modifié, PDF et dump identiques** · appelants : aucun · tests : T01, T03 · sources : [Edmo.class:Valeur2TTC_Calcul](../../../../../.src/Gestion/Impressions/Edmo.class#L502-L516)
- [ ] EDMO-005 — [commonalisation] Listes Mo/famille via `EdSelection.ListeCodes` (EDART1-003) ·
  appelants : aucun · tests : T06 · sources : [Edmo.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L54-L86), [Edmo.class:ToggleButton4_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L239-L271)
- [ ] EDMO-006 — [réduction de portée] `Button2_Click`, `Valeur2TTC_Calcul` → `Private` ·
  appelants : aucun · tests : T01 · sources : [Edmo.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L422-L497), [Edmo.class:Valeur2TTC_Calcul](../../../../../.src/Gestion/Impressions/Edmo.class#L502-L516)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDMO-A01 — [anomalie] Une valeur invalide arrête l'impression par `Return` : curseur laissé
  en attente, aucun PDF · tests : T04 · sources : [Edmo.class:464](../../../../../.src/Gestion/Impressions/Edmo.class#L464), [Edmo.class:473](../../../../../.src/Gestion/Impressions/Edmo.class#L473)
- [ ] EDMO-A02 — [anomalie] `Draw.End` sans `Draw.Begin` après le message « Aucune Mo » (erreur
  d'exécution probable) · tests : T05 · sources : [Edmo.class:493](../../../../../.src/Gestion/Impressions/Edmo.class#L493)
- [ ] EDMO-A03 — [anomalie] Navigation : `ColMo2_Click` et `Cmpt_KeyPress` tag 4 renvoient le focus
  sur `Mo` ; Échap dans `Colfam2` donne le focus à `fam` et sélectionne `fam2` · tests : T06 ·
  sources : [Edmo.class:ColMo2_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L314-L322), [Edmo.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/Edmo.class#L378-L409), [Edmo.class:291](../../../../../.src/Gestion/Impressions/Edmo.class#L291)
