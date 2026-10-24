# FTvav — Rework

> Source : `.src/Compta/Tables/FTvav.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FTvav.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 413 |
| Lignes de commentaire | 37 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 25 (`Recalcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 413 | 106 | 25 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FTVAV-001 — [documentation] En-tête en français : table gérée, contrôle d'unicité du compte,
  tables modifiées par `Recalcul`, règles d'arrondi, handlers du groupe `tva` · appelants : aucun ·
  tests : aucun · sources : [FTvav.class:_New](../../../../../.src/Compta/Tables/FTvav.class#L39-L57), [FTvav.class:Recalcul](../../../../../.src/Compta/Tables/FTvav.class#L405-L504), [FTvav.class:arrondi](../../../../../.src/Compta/Tables/FTvav.class#L509-L547)
- [ ] FTVAV-002 — [code mort] Supprimer `Cleanchamps`, le membre `b` (toujours `False`) et son
  test, le second `Txtva.clear` de `Refresh`, les `Else` vides ; `rResult3` devient locale ·
  appelants : aucun · tests : T01-T05 · sources : [FTvav.class:Cleanchamps](../../../../../.src/Compta/Tables/FTvav.class#L108-L114), [FTvav.class:37](../../../../../.src/Compta/Tables/FTvav.class#L37), [FTvav.class:211](../../../../../.src/Compta/Tables/FTvav.class#L211), [FTvav.class:82](../../../../../.src/Compta/Tables/FTvav.class#L82)
- [ ] FTVAV-003 — [complexité] `Recalcul` : une seule fonction pour les blocs `Bl` et `BlM` (même
  ordre de requêtes, test `Available` conservé seulement là où il existe) ; CC 25 → ≤ 10 visé ·
  appelants : aucun · tests : T03, T07 · sources : [FTvav.class:Recalcul](../../../../../.src/Compta/Tables/FTvav.class#L405-L504)
- [ ] FTVAV-004 — [complexité] Boucle des familles remplacée par un seul `UPdate … WHERE cdtva_fam
  = &2` et suppression des `SELECT` inutiles sur `TabMo` — SQL modifié, dump identique ·
  appelants : aucun · tests : T03, T07 · sources : [FTvav.class:411-416](../../../../../.src/Compta/Tables/FTvav.class#L411-L416), [FTvav.class:437](../../../../../.src/Compta/Tables/FTvav.class#L437), [FTvav.class:465](../../../../../.src/Compta/Tables/FTvav.class#L465)
- [ ] FTVAV-005 — [séparation traitement/GUI] `arrondi` → fonction pure
  `ArrondiPrix(sPrix, sArr, sNbdec) As String` (même algorithme) ; `Recalcul(sCode, sTaux)` reçoit
  ses paramètres au lieu de lire `Cdtva`/`Txtva` · appelants : aucun · tests : T03, T06 · sources : [FTvav.class:arrondi](../../../../../.src/Compta/Tables/FTvav.class#L509-L547), [FTvav.class:Recalcul](../../../../../.src/Compta/Tables/FTvav.class#L405-L504), [FTvav.class:Btn_Click](../../../../../.src/Compta/Tables/FTvav.class#L192-L218)
- [ ] FTVAV-006 — [réarchitecture] `Cbase.Table("TabTvav")`/`Cbase.Table("TabComptes")` à la place
  du membre `Tab` et des noms en dur (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FTvav.class:Form_Open](../../../../../.src/Compta/Tables/FTvav.class#L59-L75), [FTvav.class:Button1_Click](../../../../../.src/Compta/Tables/FTvav.class#L254-L286), [FTvav.class:Button4_Click](../../../../../.src/Compta/Tables/FTvav.class#L311-L343)
- [ ] FTVAV-007 — [commonalisation] Module commun avec `FTvac` (voir FTVAC-006), même commit ·
  appelants : aucun · tests : T01-T05, FTVAC-T01 à T05 · sources : [FTvav.class:Form_Open](../../../../../.src/Compta/Tables/FTvav.class#L59-L75), [FTvav.class:Button3_Click](../../../../../.src/Compta/Tables/FTvav.class#L288-L309), [FTvac.class:Button3_Click](../../../../../.src/Compta/Tables/FTvac.class#L275-L296)
- [ ] FTVAV-008 — [réduction de portée] `Refresh`, `Maj_Zones`, `Recalcul`, `arrondi` (ou
  `ArrondiPrix` si testée par un replay) → `Private` · appelants : aucun · tests : T01-T07 · sources : [FTvav.class:Refresh](../../../../../.src/Compta/Tables/FTvav.class#L77-L87), [FTvav.class:Maj_Zones](../../../../../.src/Compta/Tables/FTvav.class#L89-L106), [FTvav.class:Recalcul](../../../../../.src/Compta/Tables/FTvav.class#L405-L504)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FTVAV-A01 — [anomalie] `Recalcul` s'exécute avant les contrôles de `Button1_Click` : si
  l'enregistrement est refusé (compte déjà attribué) les familles, documents, articles et
  main-d'œuvre sont recalculés au nouveau taux mais la table garde l'ancien ; avec un code vide, les
  lignes sans code TVA seraient recalculées (à confirmer) · tests : T04 · sources : [FTvav.class:206](../../../../../.src/Compta/Tables/FTvav.class#L206), [FTvav.class:211](../../../../../.src/Compta/Tables/FTvav.class#L211), [FTvav.class:263](../../../../../.src/Compta/Tables/FTvav.class#L263)
- [ ] FTVAV-A02 — [anomalie] `Btn_KeyPress` : toute touche sur Enregistrer enregistre le nouveau
  taux **sans** proposer le recalcul (incohérent avec le clic) · tests : T05 · sources : [FTvav.class:Btn_KeyPress](../../../../../.src/Compta/Tables/FTvav.class#L181-L190)
- [ ] FTVAV-A03 — [anomalie] `Tvaman` jamais appelée : compte de TVA inexistant accepté, Entrée
  sur le compte ne passe jamais au bouton · tests : T05 · sources : [FTvav.class:Tvaman](../../../../../.src/Compta/Tables/FTvav.class#L387-L403), [FTvav.class:156](../../../../../.src/Compta/Tables/FTvav.class#L156)
- [ ] FTVAV-A04 — [anomalie] Recalcul des lignes `M` sans arrondi ni format (Float → String
  implicite, à confirmer : séparateur point) alors que les lignes `A` sont formatées ; lignes `A` des
  bons d'entretien lues sans test `Available` (erreur si article supprimé) · tests : T03 · sources : [FTvav.class:439](../../../../../.src/Compta/Tables/FTvav.class#L439), [FTvav.class:467](../../../../../.src/Compta/Tables/FTvav.class#L467), [FTvav.class:456](../../../../../.src/Compta/Tables/FTvav.class#L456)
- [ ] FTVAV-A05 — [anomalie] SQL par concaténation (`Button1_Click`, `Button3_Click`,
  `Button4_Click`) et suppression de la ligne sélectionnée au lieu du code saisi (comme FTVAC-A02/A03) ·
  tests : T05 · sources : [FTvav.class:271](../../../../../.src/Compta/Tables/FTvav.class#L271), [FTvav.class:273](../../../../../.src/Compta/Tables/FTvav.class#L273), [FTvav.class:302](../../../../../.src/Compta/Tables/FTvav.class#L302), [FTvav.class:329](../../../../../.src/Compta/Tables/FTvav.class#L329)
