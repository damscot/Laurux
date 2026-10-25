# Edregulprdc — Rework

> Source : `.src/Gestion/Impressions/Edregulprdc.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edregulprdc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 33 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 13 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 186 | 39 | 13 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDREGULPRDC-001 — [documentation] Corriger l'en-tête recopié (nom de fichier, rôle :
  entrées des produits composés), documenter `mind`/`type` et la purge · appelants : aucun ·
  tests : aucun · sources : [Edregulprdc.class:21](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L21), [Edregulprdc.class:24](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L24)
- [ ] EDREGULPRDC-002 — [code mort] Supprimer `Level1`, `Level2` (jamais appelées),
  `date2_GotFocus` (handler inactif, `Date2` groupé), `PosX`, `p`, `Nbpage`, `dte`, `Shell "cd …"`,
  le `If … Then Endif` vide · appelants : aucun · tests : T01-T05 · sources : [Edregulprdc.class:Level1](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L217-L236), [Edregulprdc.class:Level2](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L239-L251), [Edregulprdc.class:date2_GotFocus](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L105-L109), [Edregulprdc.class:154](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L154)
- [ ] EDREGULPRDC-003 — [réduction de portée] `date1_LostFocus`, `date2_LostFocus` → `Private`
  (pseudo-handlers appelés par `Cmpt_KeyPress`) · appelants : aucun · tests : T04 · sources : [Edregulprdc.class:date1_LostFocus](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L91-L103), [Edregulprdc.class:date2_LostFocus](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L111-L130)
- [ ] EDREGULPRDC-004 — [commonalisation] Module commun d'impression/purge avec `Edregul`
  (même commit qu'EDREGUL-004) : table `<TabMvtexpdc>`, tri `mind, type, code`, séparateur actif,
  `Wait 0.5` et couleur `&HF9F9BD&` conservés en paramètres · appelants : aucun · tests : T01-T05
  · sources : [Edregulprdc.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L132-L214), [Edregul.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edregul.class#L132-L210)
- [ ] EDREGULPRDC-005 — [séparation traitement/GUI] Sélection (jointure `LEFT JOIN <TabArt>`, SQL
  modifié, dump identique) et purge (SQL inchangé jusqu'à A01) sans accès aux contrôles ·
  appelants : aucun · tests : T01-T03 · sources : [Edregulprdc.class:165](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L165), [Edregulprdc.class:170](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L170), [Edregulprdc.class:202](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L202)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDREGULPRDC-A01 — [anomalie] **Perte de données** : `DELETE … WHERE code = &1` supprime tous
  les mouvements du code (autres fabrications `mind`, hors période) ; correction : `DELETE … WHERE
  id = &1` ou filtre `mind` + période · tests : T02 · sources : [Edregulprdc.class:206](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L206)
- [ ] EDREGULPRDC-A02 — [anomalie] Purge proposée et succès annoncé sur une période vide · tests :
  T03 · sources : [Edregulprdc.class:200](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L200), [Edregulprdc.class:209](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L209)
- [ ] EDREGULPRDC-A03 — [anomalie] `Button3_Click` supprime `~/Regul.ps` (jamais produit) au lieu
  de `~/tmp/Regul.pdf` · tests : aucun · sources : [Edregulprdc.class:255](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L255)
