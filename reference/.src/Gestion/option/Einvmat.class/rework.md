# Einvmat — Rework

> Source : `.src/Gestion/option/Einvmat.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Einvmat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 244 |
| Lignes de commentaire | 10 |
| Fonctions | 35 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 50 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 244 | 50 | 6 | 0 | 34 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EINVMAT-001 — [documentation] En-tête en français : déclaration du régime acquitté,
  structure `Declaration` reçue, unités hl/l/cl, liste des handlers `Data` du `.report` (à ne pas
  supprimer malgré `deps.py`) · appelants : aucun · tests : T01 · sources : [Einvmat.class:_new](../../../../../.src/Gestion/option/Einvmat.class#L9-L48),
  [Einvmat.class:convers](../../../../../.src/Gestion/option/Einvmat.class#L355-L382)
- [ ] EINVMAT-002 — [réarchitecture] Remplacer `Caleditcmat.ddcl` par une variable locale dans
  les 24 handlers (valeur identique) ; préalable à CALEDITCMAT-005, même commit qu'ECOMPTAMAT-002 ·
  appelants : `Caleditcmat` (suppression de `ddcl` ensuite) · tests : T01-T03 · sources :
  [Einvmat.class:vaehldp_Data](../../../../../.src/Gestion/option/Einvmat.class#L60-L65), [Einvmat.class:vapclfp_Data](../../../../../.src/Gestion/option/Einvmat.class#L228-L233)
- [ ] EINVMAT-003 — [code mort] Supprimer `$resreg`, les variables `i` et `res` de `_new`, le
  commentaire d'en-tête dupliqué · appelants : aucun · tests : T01 · sources : [Einvmat.class:5](../../../../../.src/Gestion/option/Einvmat.class#L5),
  [Einvmat.class:_new](../../../../../.src/Gestion/option/Einvmat.class#L9-L48)
- [ ] EINVMAT-004 — [commonalisation] Module commun avec Ecomptamat : `EnteteDeclaration`,
  `Convers(vol, choix, arrondiInitial)` (Einvmat : `False`, comportement identique), `Total(...)` ;
  handlers réduits à un appel · appelants : `Ecomptamat` (même commit, ECOMPTAMAT-004) · tests :
  T01-T05 ; tests d'Ecomptamat · sources : [Einvmat.class:_new](../../../../../.src/Gestion/option/Einvmat.class#L9-L48), [Einvmat.class:convers](../../../../../.src/Gestion/option/Einvmat.class#L355-L382),
  [Einvmat.class:vaehldp2_Data](../../../../../.src/Gestion/option/Einvmat.class#L235-L248), [Ecomptamat.class:convers](../../../../../.src/Gestion/option/Ecomptamat.class#L456-L483)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EINVMAT-A01 — [anomalie] `convers` n'arrondit au centilitre que pour la colonne cl :
  hl/l/cl incohérents quand l'arrondi fait passer à l'unité supérieure (199,996 l → 1 hl 99 l
  0 cl) ; Ecomptamat arrondit d'abord · tests : T02, T05 · sources : [Einvmat.class:convers](../../../../../.src/Gestion/option/Einvmat.class#L355-L382)
- [ ] EINVMAT-A02 — [anomalie] `SELECT * FROM Fiches_Societes` sans `WHERE cd_sc` : en
  multi-sociétés, l'en-tête est celui de la première société, pas de `Start.Societe` · tests : T04 ·
  sources : [Einvmat.class:24](../../../../../.src/Gestion/option/Einvmat.class#L24)
- [ ] EINVMAT-A03 — [anomalie] Signe perdu sur les litres d'un volume ≤ -100 (`Abs`) et
  centilitres négatifs : affichage incohérent d'un stock négatif · tests : T03, T05 · sources :
  [Einvmat.class:convers](../../../../../.src/Gestion/option/Einvmat.class#L355-L382)
- [ ] EINVMAT-A04 — [anomalie] `Application.Busy = 0` en fin de `_new` remet à zéro le compteur de
  l'appelant (`Caleditcmat.Edit` le décrémente ensuite : valeur négative possible, à confirmer) ·
  tests : T01 · sources : [Einvmat.class:45](../../../../../.src/Gestion/option/Einvmat.class#L45)
