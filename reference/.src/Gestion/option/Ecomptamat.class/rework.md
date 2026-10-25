# Ecomptamat — Rework

> Source : `.src/Gestion/option/Ecomptamat.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Ecomptamat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 306 |
| Lignes de commentaire | 13 |
| Fonctions | 48 |
| Fonctions Public | 47 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 6 (`convers`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 306 | 66 | 6 | 0 | 47 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECOMPTAMAT-001 — [documentation] En-tête en français : déclaration du régime suspendu,
  sections (volumes, droits, sécurité sociale, total), plage de vignettes, liste des handlers
  `Data` du `.report` (faux `unused`) · appelants : aucun · tests : T01 · sources :
  [Ecomptamat.class:_new](../../../../../.src/Gestion/option/Ecomptamat.class#L7-L60), [Ecomptamat.class:convers](../../../../../.src/Gestion/option/Ecomptamat.class#L456-L483)
- [ ] ECOMPTAMAT-002 — [réarchitecture] Variable locale au lieu de `Caleditcmat.ddcl` dans les
  handlers de cellule (valeur identique), même commit qu'EINVMAT-002, avant CALEDITCMAT-005 ·
  appelants : `Caleditcmat` · tests : T01-T03 · sources : [Ecomptamat.class:vaehldp_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L72-L77),
  [Ecomptamat.class:montss_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L317-L322)
- [ ] ECOMPTAMAT-003 — [code mort] Supprimer `$resreg`, la variable `i` et les lignes commentées de
  `_new` et `ReportLlibss_Data` · appelants : aucun · tests : T01 · sources : [Ecomptamat.class:3](../../../../../.src/Gestion/option/Ecomptamat.class#L3),
  [Ecomptamat.class:_new](../../../../../.src/Gestion/option/Ecomptamat.class#L7-L60), [Ecomptamat.class:ReportLlibss_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L282-L287)
- [ ] ECOMPTAMAT-004 — [commonalisation] Module commun avec Einvmat (`EnteteDeclaration`,
  `Convers(…, arrondiInitial = True)`, `Total`, `PlageVignettes`) ; handlers conservés, réduits à
  un appel · appelants : `Einvmat` (même commit, EINVMAT-004) · tests : T01-T07 ; tests d'Einvmat ·
  sources : [Ecomptamat.class:_new](../../../../../.src/Gestion/option/Ecomptamat.class#L7-L60), [Ecomptamat.class:convers](../../../../../.src/Gestion/option/Ecomptamat.class#L456-L483), [Ecomptamat.class:montant2_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L444-L454),
  [Einvmat.class:convers](../../../../../.src/Gestion/option/Einvmat.class#L355-L382)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECOMPTAMAT-A01 — [anomalie] `ni_Data` vide : si `gb.report` lève `Data` pour `ni`, le
  n° d'identification posé dans `_new` pourrait ne pas s'imprimer (à confirmer par T06) ; sinon
  le handler est du code mort · tests : T06 · sources : [Ecomptamat.class:ni_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L485-L489)
- [ ] ECOMPTAMAT-A02 — [anomalie] Plage de vignettes sans filtre de régime ni de type et sans
  exclure `''` : vignettes d'entrées ou de régies acquittées comprises, borne basse vide possible ·
  tests : T05 · sources : [Ecomptamat.class:44](../../../../../.src/Gestion/option/Ecomptamat.class#L44)
- [ ] ECOMPTAMAT-A03 — [anomalie] `convers` : signe perdu sur les litres d'un volume ≤ -100 ·
  tests : T07 · sources : [Ecomptamat.class:convers](../../../../../.src/Gestion/option/Ecomptamat.class#L456-L483)
- [ ] ECOMPTAMAT-A04 — [anomalie] `Fiches_Societes` sans `WHERE cd_sc` (première société en
  multi-sociétés) et `Application.Busy = 0` brutal (comme EINVMAT-A02/A04) · tests : T01 ·
  sources : [Ecomptamat.class:26](../../../../../.src/Gestion/option/Ecomptamat.class#L26), [Ecomptamat.class:57](../../../../../.src/Gestion/option/Ecomptamat.class#L57)
