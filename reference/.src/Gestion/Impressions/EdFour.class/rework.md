# EdFour — Rework

> Source : `.src/Gestion/Impressions/EdFour.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdFour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 234 |
| Lignes de commentaire | 31 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 10 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 234 | 50 | 10 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDFOUR-001 — [documentation] En-tête : rôle, noms de contrôles hérités d'`EdClient`,
  groupes `Cmpt`/`Btn`, `Colcli_Click`/`Colcli2_Click` à garder `Public` (rejeu dynamique) ·
  appelants : aucun · tests : aucun · sources : [EdFour.class:_New](../../../../../.src/Gestion/Impressions/EdFour.class#L33-L44), [EdFour.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L164-L180)
- [ ] EDFOUR-002 — [code mort] Supprimer le `Case 1` inatteignable de `Btn_Click`, `dte`, `Nbpage`,
  `Shell "cd …"` ; `Do … Loop Until` → `Repeat … Until` (même comportement) · appelants : aucun ·
  tests : T01-T05 · sources : [EdFour.class:168](../../../../../.src/Gestion/Impressions/EdFour.class#L168), [EdFour.class:264](../../../../../.src/Gestion/Impressions/EdFour.class#L264), [EdFour.class:267](../../../../../.src/Gestion/Impressions/EdFour.class#L267), [EdFour.class:283](../../../../../.src/Gestion/Impressions/EdFour.class#L283)
- [ ] EDFOUR-003 — [réduction de portée] `Button2_Click` → `Private` (bouton groupé dans `Btn`) ·
  appelants : aucun · tests : T01 · sources : [EdFour.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L248-L316)
- [ ] EDFOUR-004 — [complexité] Helpers privés `BasculeListe(col)` / `ClavierListe(col, champ)`
  pour les deux listes · appelants : aucun · tests : T03 · sources : [EdFour.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L46-L78), [EdFour.class:ToggleButton2_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L105-L137), [EdFour.class:Colcli_KeyPress](../../../../../.src/Gestion/Impressions/EdFour.class#L83-L103), [EdFour.class:Colcli2_KeyPress](../../../../../.src/Gestion/Impressions/EdFour.class#L142-L162)
- [ ] EDFOUR-005 — [commonalisation] Socle « plage de codes + listes » commun avec `EdFam`,
  `EdClient`, `EdDocs` (même commit qu'EDFAM-005) · appelants : aucun · tests : T01-T05 · sources : [EdFour.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L46-L78), [EdFam.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L46-L78)
- [ ] EDFOUR-006 — [séparation traitement/GUI] `ListeFournisseurs(sDe, sA, sTri)` avec
  `Cbase.Table("TabFour")` (SQL identique) séparée de l'impression · appelants : aucun · tests :
  T01, T02, T04 · sources : [EdFour.class:277](../../../../../.src/Gestion/Impressions/EdFour.class#L277), [EdFour.class:280](../../../../../.src/Gestion/Impressions/EdFour.class#L280)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDFOUR-A01 — [anomalie] Dernière page du PDF paysage terminée par `BasPage` (pied portrait,
  largeur 206 mm) au lieu de `BasPageP` : pied de page décentré · tests : T05 · sources : [EdFour.class:305](../../../../../.src/Gestion/Impressions/EdFour.class#L305), [EdFour.class:298](../../../../../.src/Gestion/Impressions/EdFour.class#L298)
