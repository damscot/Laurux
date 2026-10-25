# EdMat — Rework

> Source : `.src/Gestion/Impressions/EdMat.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdMat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 393 |
| Lignes de commentaire | 26 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 100 |
| Complexité max (fonction) | 35 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 393 | 100 | 35 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDMAT-001 — [documentation] En-tête en français : rôle, tables lues (pas de tables `*M`),
  communication avec `TriMat` par l'auto-instance, champs `Type` ignorés · appelants : aucun ·
  tests : aucun · sources : [EdMat.class:_New](../../../../../.src/Gestion/Impressions/EdMat.class#L25-L39), [EdMat.class:SelectionMat](../../../../../.src/Gestion/Impressions/EdMat.class#L128-L158)
- [ ] EDMAT-002 — [code mort] Supprimer `Gpvcons`, `Nbpage`, `dte`, `fami`, `four3`, `tva`, `sel`,
  `Tri`, `Tab` de `SelectionMat`, `PosX`, le `Shell "cd …"`, le `Case 1` de `Btn_Click` ·
  appelants : aucun · tests : T01, T07 · sources : [EdMat.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdMat.class#L383-L491), [EdMat.class:SelectionMat](../../../../../.src/Gestion/Impressions/EdMat.class#L128-L158), [EdMat.class:422](../../../../../.src/Gestion/Impressions/EdMat.class#L422)
- [ ] EDMAT-003 — [séparation traitement/GUI] `SelectMateriels(bVendus, bStock, tri) As Result`
  (mêmes textes SQL et paramètres) et formatage `LigneMateriel` hors handler · appelants : aucun ·
  tests : T01, T02, T04 · sources : [EdMat.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdMat.class#L383-L491)
- [ ] EDMAT-004 — [commonalisation] `Mat_man` via le helper `ChercheCode` du socle `EdSelection`
  (après décision sur EDMAT-A02) ; liste des marques partagée avec `Materiel` · appelants : aucun ·
  tests : T04, T08 · sources : [EdMat.class:Mat_man](../../../../../.src/Gestion/Impressions/EdMat.class#L163-L189), [EdMat.class:Aff_Marques](../../../../../.src/Gestion/Impressions/EdMat.class#L209-L248), [Materiel.class:ColMarque_Click](../../../../../.src/Gestion/Tables/Materiel.class#L470-L476)
- [ ] EDMAT-005 — [réduction de portée] `SelectionProp`, `SelectionMat`, `Mat_man`, `Aff_Marques`,
  `Button2_Click` → `Private` (`CodeMat`, `Bsel`, `Bval` restent `Public`) · appelants : aucun ·
  tests : T01, T06, T07 · sources : [EdMat.class:SelectionProp](../../../../../.src/Gestion/Impressions/EdMat.class#L66-L93), [EdMat.class:Mat_man](../../../../../.src/Gestion/Impressions/EdMat.class#L163-L189), [EdMat.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdMat.class#L383-L491)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDMAT-A01 — [anomalie] `SelectionProp` recopie `CClient` (jamais renseigné) au lieu de `Bval` :
  la sélection d'un propriétaire vide le champ · tests : T06 · sources : [EdMat.class:76](../../../../../.src/Gestion/Impressions/EdMat.class#L76), [EdMat.class:80](../../../../../.src/Gestion/Impressions/EdMat.class#L80)
- [ ] EDMAT-A02 — [anomalie] `Mat_man` interroge `mat_refcentrale`, colonne absente de
  `Fiches_Materiels` : erreur SQL non interceptée pour tout code inconnu · tests : T08 · sources : [EdMat.class:176](../../../../../.src/Gestion/Impressions/EdMat.class#L176)
- [ ] EDMAT-A03 — [anomalie] Filtre par type (`Type`/`Type2`) affiché mais non implémenté
  (`ToggleButton7`/`8` sans handler, champs absents du SQL) · tests : T01 · sources : [EdMat.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/EdMat.class#L293-L370), [EdMat.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdMat.class#L383-L491)
- [ ] EDMAT-A04 — [anomalie] Titre des pages suivantes « Liste des marériels » (faute, titre
  différent) ; fichier `Tarif2.pdf` mal nommé · tests : T05 · sources : [EdMat.class:471](../../../../../.src/Gestion/Impressions/EdMat.class#L471), [EdMat.class:423](../../../../../.src/Gestion/Impressions/EdMat.class#L423)
- [ ] EDMAT-A05 — [anomalie] Tag 2 (`Mat2`) contrôle `Mat.Text` ; impression sur toute touche
  (`Btn_KeyPress`) · tests : T08 · sources : [EdMat.class:310](../../../../../.src/Gestion/Impressions/EdMat.class#L310), [EdMat.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdMat.class#L284-L291)
