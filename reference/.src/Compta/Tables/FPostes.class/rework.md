# FPostes — Rework

> Source : `.src/Compta/Tables/FPostes.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FPostes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 7 (`Col_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 117 | 35 | 7 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FPOSTES-001 — [documentation] En-tête corrigé (nom du fichier, rôle : postes analytiques,
  tables utilisatrices) ; commenter l'effet des `Try` de `Form_Open` en cas de code en double
  (l'ajout échoue et les `Item[…]` réécrivent la ligne précédente) · appelants : aucun · tests : aucun · sources : [FPostes.class:5](../../../../../.src/Compta/Tables/FPostes.class#L5), [FPostes.class:Form_Open](../../../../../.src/Compta/Tables/FPostes.class#L28-L43)
- [ ] FPOSTES-002 — [séparation traitement/GUI] `EnregistrePoste(sCode, sLib)` et
  `SupprimePoste(sCode)` sans contrôle · appelants : aucun · tests : T01-T03 · sources : [FPostes.class:Button1_Click](../../../../../.src/Compta/Tables/FPostes.class#L136-L148), [FPostes.class:Button2_Click](../../../../../.src/Compta/Tables/FPostes.class#L150-L170)
- [ ] FPOSTES-003 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` →
  `Private` · appelants : aucun · tests : T01-T03 · sources : [FPostes.class:Maj_Zones](../../../../../.src/Compta/Tables/FPostes.class#L45-L51), [FPostes.class:CleanChamps](../../../../../.src/Compta/Tables/FPostes.class#L53-L58), [FPostes.class:Refresh](../../../../../.src/Compta/Tables/FPostes.class#L60-L65), [FPostes.class:cptman](../../../../../.src/Compta/Tables/FPostes.class#L124-L134)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FPOSTES-A01 — [anomalie] Suppression d'un poste sans contrôle d'usage (`Fiches_Analytiques`,
  écritures analytiques) · tests : T03 · sources : [FPostes.class:143](../../../../../.src/Compta/Tables/FPostes.class#L143)
- [ ] FPOSTES-A02 — [anomalie] Zone code de 8 caractères pour une colonne `char(3)` ; codes en
  double possibles (pas de clé sur `code`), UPDATE/DELETE agissent alors sur tous les doublons ·
  tests : T04 · sources : [FPostes.class:156](../../../../../.src/Compta/Tables/FPostes.class#L156), [FPostes.class:158](../../../../../.src/Compta/Tables/FPostes.class#L158)
