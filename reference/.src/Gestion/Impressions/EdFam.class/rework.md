# EdFam — Rework

> Source : `.src/Gestion/Impressions/EdFam.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdFam.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 217 |
| Lignes de commentaire | 31 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 7 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 217 | 47 | 7 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDFAM-001 — [documentation] En-tête : rôle, groupes `Cmpt`/`Btn` et leurs tags, handlers
  `Colfam_Click`/`Colfam2_Click` à garder `Public` (rejeu dynamique) · appelants : aucun · tests :
  aucun · sources : [EdFam.class:_New](../../../../../.src/Gestion/Impressions/EdFam.class#L33-L44), [EdFam.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L164-L180)
- [ ] EDFAM-002 — [code mort] Supprimer le `Case 1` inatteignable de `Btn_Click`, `dte`,
  `Shell "cd …"` et les `With Utils` inutiles · appelants : aucun · tests : T01-T05 · sources : [EdFam.class:168](../../../../../.src/Gestion/Impressions/EdFam.class#L168), [EdFam.class:250](../../../../../.src/Gestion/Impressions/EdFam.class#L250), [EdFam.class:252](../../../../../.src/Gestion/Impressions/EdFam.class#L252)
- [ ] EDFAM-003 — [réduction de portée] `Button2_Click` → `Private` (bouton groupé dans `Btn`,
  appelé seulement par `Btn_Click`) · appelants : aucun · tests : T01 · sources : [EdFam.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L236-L297)
- [ ] EDFAM-004 — [complexité] Helpers privés `BasculeListe(col)` et `ClavierListe(col, champ)`
  pour les deux listes ; noms et portée des handlers inchangés · appelants : aucun · tests : T02,
  T05 · sources : [EdFam.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L46-L78), [EdFam.class:ToggleButton2_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L105-L137), [EdFam.class:Colfam_KeyPress](../../../../../.src/Gestion/Impressions/EdFam.class#L83-L103), [EdFam.class:ColFam2_KeyPress](../../../../../.src/Gestion/Impressions/EdFam.class#L142-L162)
- [ ] EDFAM-005 — [commonalisation] Socle « plage de codes + listes de sélection » partagé avec
  `EdFour`, `EdClient`, `EdDocs` (module commun, sorties identiques) · appelants : aucun · tests :
  T01-T05 et ceux des trois écrans · sources : [EdFam.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFam.class#L46-L78), [EdFour.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/EdFour.class#L46-L78), [EdClient.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdClient.class#L45-L80)
- [ ] EDFAM-006 — [séparation traitement/GUI] `ListeFamilles(sDe, sA)` (SQL, `Cbase.Table("TabFam")`,
  SQL identique) séparée de l'impression · appelants : aucun · tests : T01, T03 · sources : [EdFam.class:262](../../../../../.src/Gestion/Impressions/EdFam.class#L262), [EdFam.class:62](../../../../../.src/Gestion/Impressions/EdFam.class#L62)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune anomalie relevée sur cet écran.
