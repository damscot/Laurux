# RichDataGrid — Rework

> Source : `.src/Utils/RichDataGrid.class` · Message de commit (phase 4) : `reference/.src/Utils/RichDataGrid.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 225 |
| Lignes de commentaire | 32 |
| Fonctions | 32 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 24 (`Grid_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 225 | 73 | 24 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RICHDATAGRID-001 — [documentation] En-tête en français : rôle, protocole d'usage (propriétés
  puis `Refresh`), formats de colonnes et conditionnels, recherche par clic droit, événements levés
  · appelants : aucun · tests : T01-T05 · sources : [RichDataGrid.class:_New](../../../../.src/Utils/RichDataGrid.class#L49-L68)
- [ ] RICHDATAGRID-002 — [code mort] Supprimer `$oFormatDefaut` et son initialisation, `sFind`,
  les blocs commentés `[GB2:…]` et les déclarations commentées · appelants : aucun · tests : T01-T05 · sources : [RichDataGrid.class:_New](../../../../.src/Utils/RichDataGrid.class#L49-L68), [RichDataGrid.class:Refresh](../../../../.src/Utils/RichDataGrid.class#L95-L124)
- [ ] RICHDATAGRID-003 — [complexité] `Grid_Data` : helper privé d'application d'un format
  (colonne / condition), comportement identique (CC 24 → ≤ 10 visé) · appelants : aucun ·
  tests : T01, T02 · sources : [RichDataGrid.class:Grid_Data](../../../../.src/Utils/RichDataGrid.class#L126-L186)
- [ ] RICHDATAGRID-004 — [séparation traitement/GUI] `Refresh` : construction de la requête dans
  une fonction pure `Requete(…) As String` · appelants : aucun · tests : T01-T03, T06 · sources : [RichDataGrid.class:Refresh](../../../../.src/Utils/RichDataGrid.class#L95-L124)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RICHDATAGRID-A01 — [anomalie] `Refresh:112` : texte de recherche concaténé dans le SQL
  (`LIKE '<texte>%'`) ; une apostrophe casse la requête (erreur masquée par `Catch`). Correction :
  `Utils.db.Subst("… LIKE &1", texte & "%")` · tests : T03 · sources : [RichDataGrid.class:112](../../../../.src/Utils/RichDataGrid.class#L112)
- [ ] RICHDATAGRID-A02 — [anomalie] `Refresh:116` : `db.Exec` (connexion courante gb.db) au lieu
  de `Utils.db.Exec` : pas de traduction SQLite ni de journalisation · tests : T01, T07 · sources : [RichDataGrid.class:116](../../../../.src/Utils/RichDataGrid.class#L116)
- [ ] RICHDATAGRID-A03 — [anomalie] `Grid_Data:168-170` : `hFormat.BackColor`/`ForeColor`
  n'existent pas dans `CFormat` (erreur dès qu'une condition s'applique ; non utilisé aujourd'hui) ;
  `Tag_Write:242` écrit `$hGrid.table` (inexistant) · tests : à créer si validé · sources : [RichDataGrid.class:168-170](../../../../.src/Utils/RichDataGrid.class#L168-L170), [RichDataGrid.class:242](../../../../.src/Utils/RichDataGrid.class#L242)
- [ ] RICHDATAGRID-A04 — [anomalie] `Grid_Data:179` : précédence `Or`/`And` (un Float est formaté
  même sans format, `Format$(x, "")`) · tests : T01 · sources : [RichDataGrid.class:179](../../../../.src/Utils/RichDataGrid.class#L179)
