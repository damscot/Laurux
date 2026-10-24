# Deblockbl — Rework

> Source : `.src/Communs/Deblockbl.class` · Message de commit (phase 4) : `reference/.src/Communs/Deblockbl.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 21 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 21 | 5 | 3 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DEBLOCKBL-001 — [documentation] En-tête : rôle, tables, lien avec `DocActif` et `Prgm`
  `RazDocactif` · appelants : aucun · tests : aucun · sources : [Deblockbl.class:Button2_Click](../../../../.src/Communs/Deblockbl.class#L9-L26)
- [ ] DEBLOCKBL-002 — [commonalisation] `Cbase.Table("TabBl")` et `Cbase.Table("TabActif")` au lieu
  des noms en dur (SQL identique) · appelants : aucun · tests : T01, T02 · sources : [Deblockbl.class:14](../../../../.src/Communs/Deblockbl.class#L14), [Deblockbl.class:16](../../../../.src/Communs/Deblockbl.class#L16)
- [ ] DEBLOCKBL-003 — [séparation traitement/GUI] `DocumentExiste(sNum)` et `Debloque(sNum)`
  privés, le handler garde messages et focus · appelants : aucun · tests : T01-T03 · sources : [Deblockbl.class:Button2_Click](../../../../.src/Communs/Deblockbl.class#L9-L26)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DEBLOCKBL-A01 — [anomalie] `DELETE FROM Fiches_Docactif WHERE numerobl = &1` : colonne
  inexistante, aucun verrou n'est jamais supprimé (erreur SQL) ; corriger par
  `DocActif.Free_Lock(type, numéro)` ou `WHERE doc_num = &1` (type de document à préciser) ·
  tests : T02 · sources : [Deblockbl.class:16](../../../../.src/Communs/Deblockbl.class#L16), [DocActif.class:Free_Lock](../../../../.src/Communs/DocActif.class#L138-L173)
- [ ] DEBLOCKBL-A02 — [anomalie] Seuls les numéros présents dans `Fiches_Bl` sont acceptés, alors
  que `Fiches_Docactif` verrouille aussi d'autres types de documents (`doc_type`) ; message de
  succès affiché même si aucun verrou n'existait · tests : T01, T02 · sources : [Deblockbl.class:14-17](../../../../.src/Communs/Deblockbl.class#L14-L17)
