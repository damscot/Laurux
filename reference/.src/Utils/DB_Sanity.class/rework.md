# DB_Sanity — Rework

> Source : `.src/Utils/DB_Sanity.class` · Message de commit (phase 4) : `reference/.src/Utils/DB_Sanity.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 575 |
| Lignes de commentaire | 40 |
| Fonctions | 25 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 171 |
| Complexité max (fonction) | 50 (`Refresh_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 575 | 171 | 50 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DB_SANITY-001 — [documentation] En-tête de classe : rôle, format de `db_control.csv`, codes de
  validité (-1/0/1/2/3) et couleurs, limites MySQL de Corriger/Nettoyer · appelants : aucun · tests : aucun · sources : [DB_Sanity.class:_new](../../../../.src/Utils/DB_Sanity.class#L16-L42)
- [ ] DB_SANITY-002 — [code mort] Supprimer le membre `$indexes` et les variables locales inutilisées
  de `Refresh_Data` (`$indexes`, `$index`, `$user`, `$field`, `obj`) et le bloc commenté des index ·
  appelants : aucun · tests : T01, T02 · sources : [DB_Sanity.class:14](../../../../.src/Utils/DB_Sanity.class#L14), [DB_Sanity.class:Refresh_Data](../../../../.src/Utils/DB_Sanity.class#L50-L254)
- [ ] DB_SANITY-003 — [complexité] Découper `Refresh_Data` (CC 50) : `LireStructure`, `ComparerLigne`
  (pure), `ExporterCsv` ; comportement identique, y compris l'écriture des libellés au dessin ·
  appelants : aucun · tests : T01, T02, T03, T09 · sources : [DB_Sanity.class:Refresh_Data](../../../../.src/Utils/DB_Sanity.class#L50-L254)
- [ ] DB_SANITY-004 — [séparation traitement/GUI] `Corriger_Click` : génération des requêtes dans
  `RequetesCorrection(i) As String[]` sans accès aux contrôles ; le handler exécute, affiche la
  progression et les messages (mêmes textes) · appelants : aucun · tests : T04, T05 · sources : [DB_Sanity.class:Corriger_Click](../../../../.src/Utils/DB_Sanity.class#L450-L562)
- [ ] DB_SANITY-005 — [commonalisation] Factoriser la remise à zéro de la grille (`rows.count`,
  `MoveTo`, `SetFocus`, `Refresh`, 4 copies) dans `AfficherLignes(n)` · appelants : aucun · tests : T01, T03 · sources : [DB_Sanity.class:Refresh_Data](../../../../.src/Utils/DB_Sanity.class#L50-L254), [DB_Sanity.class:Refresh_Data_Missing](../../../../.src/Utils/DB_Sanity.class#L256-L299)
- [ ] DB_SANITY-006 — [réduction de portée] `Refresh`, `Refresh_Data`, `Refresh_Data_Missing` →
  `Private` · appelants : aucun · tests : T01 à T03 · sources : [DB_Sanity.class:Refresh](../../../../.src/Utils/DB_Sanity.class#L44-L48), [DB_Sanity.class:Refresh_Data](../../../../.src/Utils/DB_Sanity.class#L50-L254), [DB_Sanity.class:Refresh_Data_Missing](../../../../.src/Utils/DB_Sanity.class#L256-L299)
- [ ] DB_SANITY-007 — [complexité] `GridView1_Data` : table `[couleur, libellé]` indexée par le code
  de validité au lieu de 4 branches (CC 15 → ≤ 5) · appelants : aucun · tests : T02, T03 · sources : [DB_Sanity.class:GridView1_Data](../../../../.src/Utils/DB_Sanity.class#L309-L351)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DB_SANITY-A01 — [anomalie] `Corriger_Click` ligne 487 : espace manquant avant `ENGINE=` ; la
  correction du moteur produit un SQL invalide · tests : T02, T04 · sources : [DB_Sanity.class:487](../../../../.src/Utils/DB_Sanity.class#L487)
- [ ] DB_SANITY-A02 — [anomalie] Schéma reconstruit en `"Laurux" & Start.Societe` (lignes 485, 487,
  516, 518, 521, 526) : faux si `/dbase/Prefixe` est renseigné ; utiliser `DB_Con.Name` · tests : T04 · sources : [DB_Sanity.class:485](../../../../.src/Utils/DB_Sanity.class#L485), [DB_Sanity.class:516](../../../../.src/Utils/DB_Sanity.class#L516), [DB_Sanity.class:526](../../../../.src/Utils/DB_Sanity.class#L526)
- [ ] DB_SANITY-A03 — [anomalie] Les libellés OK/ERR/ABS/SUP ne sont écrits dans `Data` que par
  `GridView1_Data` : l'export CSV dépend des lignes affichées · tests : T01, T02 · sources : [DB_Sanity.class:GridView1_Data](../../../../.src/Utils/DB_Sanity.class#L309-L351), [DB_Sanity.class:73-90](../../../../.src/Utils/DB_Sanity.class#L73-L90)
- [ ] DB_SANITY-A04 — [anomalie] `Refresh_Data_Missing` ligne 267 : `Valid = New Integer[]` pour un
  `Integer[][]` (erreur de type probable, à confirmer) · tests : T03 · sources : [DB_Sanity.class:267](../../../../.src/Utils/DB_Sanity.class#L267)
- [ ] DB_SANITY-A05 — [anomalie] `Datain`/`Found` non réinitialisés par `Refresh_Data()` sans fichier
  (après Corriger, comparaison à un état périmé) · tests : T04 · sources : [DB_Sanity.class:Refresh_Data](../../../../.src/Utils/DB_Sanity.class#L50-L254), [DB_Sanity.class:98-111](../../../../.src/Utils/DB_Sanity.class#L98-L111)
- [ ] DB_SANITY-A06 — [anomalie] `Corriger` et `Nettoyer` sont proposés sous SQLite alors que leurs
  requêtes sont MySQL uniquement (`SHOW`, `information_schema`, `@counter`) · tests : T09 · sources : [DB_Sanity.class:Corriger_Click](../../../../.src/Utils/DB_Sanity.class#L450-L562), [DB_Sanity.class:Nettoyer_Click](../../../../.src/Utils/DB_Sanity.class#L416-L448)
