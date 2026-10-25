# Edittipp — Rework

> Source : `.src/Gestion/option/Edittipp.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Edittipp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 1 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 38 | 9 | 2 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITTIPP-001 — [documentation] En-tête : état « Annexe IX » TICPE, sources BL et factures,
  handlers `*_Data` du `.report` (à garder `Public`, faux `unused`) · appelants : aucun · tests :
  T01-T03 · sources : [Edittipp.class:_new](../../../../../.src/Gestion/option/Edittipp.class#L6-L15), [Edittipp.class:num_Data](../../../../../.src/Gestion/option/Edittipp.class#L17-L22)
- [ ] EDITTIPP-002 — [séparation traitement/GUI] Fonction privée `RequeteMois()` (texte SQL et
  paramètres identiques) appelée par `_new` · appelants : aucun · tests : T01-T03 · sources : [Edittipp.class:_new](../../../../../.src/Gestion/option/Edittipp.class#L6-L15)
- [ ] EDITTIPP-003 — [complexité] Helper privé `Ligne(Index) As Result` pour les 7 handlers `*_Data`
  (noms et portée des handlers inchangés) · appelants : aucun · tests : T01, T03 · sources : [Edittipp.class:num_Data](../../../../../.src/Gestion/option/Edittipp.class#L17-L22), [Edittipp.class:prod_Data](../../../../../.src/Gestion/option/Edittipp.class#L24-L29), [Edittipp.class:vol_Data](../../../../../.src/Gestion/option/Edittipp.class#L31-L36), [Edittipp.class:rais_Data](../../../../../.src/Gestion/option/Edittipp.class#L38-L43), [Edittipp.class:siret_Data](../../../../../.src/Gestion/option/Edittipp.class#L45-L50), [Edittipp.class:code_Data](../../../../../.src/Gestion/option/Edittipp.class#L52-L57), [Edittipp.class:dest_Data](../../../../../.src/Gestion/option/Edittipp.class#L59-L64)
- [ ] EDITTIPP-004 — [réarchitecture] `Cbase.Table` pour `Fiches_Ligbl`, `Fiches_Bl`,
  `Fiches_HistoLigfac`, `Fiches_HistoFac`, `Fiches_Cli`, `Fiches_Art` (SQL identique) · appelants :
  aucun · tests : T01-T03 · sources : [Edittipp.class:_new](../../../../../.src/Gestion/option/Edittipp.class#L6-L15)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITTIPP-A01 — [anomalie, à confirmer] Jointure `Fiches_region` sur l'article seul (clé
  `(code, cart)`) : une ligne par région de l'article ; le code région de la ligne
  (`tipp_ligbl`) n'est pas utilisé dans la jointure · tests : T03 · sources : [Edittipp.class:9](../../../../../.src/Gestion/option/Edittipp.class#L9), [Edittipp.class:10](../../../../../.src/Gestion/option/Edittipp.class#L10)
- [ ] EDITTIPP-A02 — [anomalie, à confirmer] Double comptage possible d'une ligne de BL facturé
  (présente dans `Fiches_Ligbl` et dans `Fiches_HistoLigfac`) · tests : T03 · sources : [Edittipp.class:9](../../../../../.src/Gestion/option/Edittipp.class#L9)
- [ ] EDITTIPP-A03 — [anomalie] Raison sociale et adresse du déclarant en dur dans
  `Edittipp.report` (une société précise) : correction hors périmètre (`.report` intouchable),
  décision utilisateur · tests : T01 · sources : [Edittipp.class:_new](../../../../../.src/Gestion/option/Edittipp.class#L6-L15)
