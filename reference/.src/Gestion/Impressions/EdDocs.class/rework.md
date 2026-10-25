# EdDocs — Rework

> Source : `.src/Gestion/Impressions/EdDocs.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdDocs.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 328 |
| Lignes de commentaire | 26 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 84 |
| Complexité max (fonction) | 39 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 328 | 84 | 39 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDDOCS-001 — [documentation] En-tête : filtres, correspondance bouton → `TypeD`, ordres de
  tri, `Colcli_Click` à garder `Public` (rejeu dynamique) · appelants : aucun · tests : aucun ·
  sources : [EdDocs.class:_New](../../../../../.src/Gestion/Impressions/EdDocs.class#L35-L46), [EdDocs.class:RadioButton1_Click](../../../../../.src/Gestion/Impressions/EdDocs.class#L225-L229)
- [ ] EDDOCS-002 — [code mort] Supprimer `Frmt`, `Coulfond` (jamais lus), `Nbpage`, les variables
  lues sans usage (`Fax`, `Mel`, `tel2` hors appel), `Shell "cd …"` · appelants : aucun · tests :
  T01-T07 · sources : [EdDocs.class:39](../../../../../.src/Gestion/Impressions/EdDocs.class#L39), [EdDocs.class:40](../../../../../.src/Gestion/Impressions/EdDocs.class#L40), [EdDocs.class:80](../../../../../.src/Gestion/Impressions/EdDocs.class#L80)
- [ ] EDDOCS-003 — [réduction de portée] `Aff_Clients`, `Select_Date` → `Private` (appels internes
  seulement) · appelants : aucun · tests : T05 · sources : [EdDocs.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdDocs.class#L276-L311), [EdDocs.class:Select_Date](../../../../../.src/Gestion/Impressions/EdDocs.class#L372-L380)
- [ ] EDDOCS-004 — [complexité] `Button1_Click` (CC 39) : extraire `ClauseDocuments(…)`,
  `ImprimeTotalClient(…)` et `NouvellePage()` ; texte SQL et PDF identiques · appelants : aucun ·
  tests : T01-T07 · sources : [EdDocs.class:Button1_Click](../../../../../.src/Gestion/Impressions/EdDocs.class#L48-L216)
- [ ] EDDOCS-005 — [séparation traitement/GUI] `DocumentsEnCours(…) As Result` sans accès aux
  contrôles (SQL inchangé) · appelants : aucun · tests : T01, T02, T05 · sources : [EdDocs.class:104](../../../../../.src/Gestion/Impressions/EdDocs.class#L104), [EdDocs.class:106](../../../../../.src/Gestion/Impressions/EdDocs.class#L106)
- [ ] EDDOCS-006 — [commonalisation] Liste de documents commune avec `EdPrep` (même commit
  qu'EDPREP-007) et `Aff_Clients` via le socle « plage de codes » (`EdClient`, `EdFour`, `EdFam`) ·
  appelants : aucun · tests : T01, T06 · sources : [EdDocs.class:Button1_Click](../../../../../.src/Gestion/Impressions/EdDocs.class#L48-L216), [EdDocs.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdDocs.class#L276-L311), [EdClient.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdClient.class#L45-L80)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDDOCS-A01 — [anomalie] Titres inversés : « Commandes » (`TypeD = "C"`) imprime « Liste des
  devis en cours » et « Devis » (`TypeD = "D"`) « Liste des commandes en cours » · tests : T02 ·
  sources : [EdDocs.class:86](../../../../../.src/Gestion/Impressions/EdDocs.class#L86), [EdDocs.class:87](../../../../../.src/Gestion/Impressions/EdDocs.class#L87)
- [ ] EDDOCS-A02 — [anomalie] « Par commentaire » (`RadioButton12`) : `Ordre` vide → `order by `
  (erreur SQL puis `Result` nul) et filtre de type forcé à `C` · tests : T03 · sources : [EdDocs.class:94](../../../../../.src/Gestion/Impressions/EdDocs.class#L94), [EdDocs.class:RadioButton12_Click](../../../../../.src/Gestion/Impressions/EdDocs.class#L255-L259)
- [ ] EDDOCS-A03 — [anomalie] Tri par compte : le total du dernier client n'est jamais imprimé ·
  tests : T04 · sources : [EdDocs.class:140](../../../../../.src/Gestion/Impressions/EdDocs.class#L140), [EdDocs.class:203](../../../../../.src/Gestion/Impressions/EdDocs.class#L203)
- [ ] EDDOCS-A04 — [anomalie, à confirmer] Filtre de dates par chaînes `aaaammjj` sur un `datetime` :
  documents du dernier jour avec heure exclus (MySQL) ; comparaison texte erronée sous SQLite ·
  tests : T05 · sources : [EdDocs.class:75](../../../../../.src/Gestion/Impressions/EdDocs.class#L75), [EdDocs.class:76](../../../../../.src/Gestion/Impressions/EdDocs.class#L76), [EdDocs.class:104](../../../../../.src/Gestion/Impressions/EdDocs.class#L104)
