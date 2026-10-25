# EditfacB — Rework

> Source : `.src/Gestion/option/EditfacB.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/EditfacB.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 628 |
| Lignes de commentaire | 14 |
| Fonctions | 13 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 38 |
| Complexité max (fonction) | 10 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 628 | 38 | 10 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITFACB-001 — [documentation] En-tête : état boisson dérivé d'`Editfac`, deux mises en
  page (BL non chiffré, facture paysage), signification des index `aimprimer`/`decons`,
  surcharges `code_data`/`intitule_Data` (à garder `Public`) · appelants : aucun · tests : aucun ·
  sources : [EditfacB.class:_new](../../../../../.src/Gestion/option/EditfacB.class#L24-L556), [EditfacB.class:code_data](../../../../../.src/Gestion/option/EditfacB.class#L661-L679), [EditfacB.class:intitule_Data](../../../../../.src/Gestion/option/EditfacB.class#L681-L703)
- [ ] EDITFACB-002 — [complexité] `_new` (496 LOC) : helpers `AjouteColonne`, `AjouteEntete`,
  `AjouteFrais`, `AjouteTotal`, découpage `MiseEnPageBl`/`MiseEnPageFacture`, même ordre de
  création des contrôles et mêmes propriétés · appelants : `ObjFacB` (inchangé) · tests : T01-T04 ·
  sources : [EditfacB.class:_new](../../../../../.src/Gestion/option/EditfacB.class#L24-L556)
- [ ] EDITFACB-003 — [commonalisation] `ValeurImprimer(Index, colonne, avecBorne)` pour
  `cu_data`, `pourc_data`, `ve_data`, `ap_data` (bornes conservées : avec pour `cu`/`pourc`, sans
  pour `ve`/`ap`) · appelants : aucun · tests : T03, T04 · sources : [EditfacB.class:cu_data](../../../../../.src/Gestion/option/EditfacB.class#L607-L619), [EditfacB.class:ap_data](../../../../../.src/Gestion/option/EditfacB.class#L648-L659)
- [ ] EDITFACB-004 — [complexité] Un seul appel à `Utils.Option()` dans `_new` · appelants :
  aucun · tests : T01 · sources : [EditfacB.class:31](../../../../../.src/Gestion/option/EditfacB.class#L31)
- [ ] EDITFACB-005 — [réarchitecture] Remplacer `cal.borientation()` par la propriété
  d'orientation calculée par `ObjFacB.calcul` (SQL modifié : requêtes en moins, dump identique) ·
  appelants : `ObjFacB` (même commit qu'OBJFACB-011) · tests : T01-T04 · sources : [EditfacB.class:32](../../../../../.src/Gestion/option/EditfacB.class#L32), [ObjFacB.class:borientation](../../../../../.src/Gestion/option/ObjFacB.class#L388-L412)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITFACB-A01 — [anomalie, à confirmer] `ve_data`/`ap_data` ne bornent pas `Index` : une
  ligne de déconsigne peut afficher le volume d'une clé `aimprimer` homonyme · tests : T04 ·
  sources : [EditfacB.class:ve_data](../../../../../.src/Gestion/option/EditfacB.class#L635-L646), [EditfacB.class:ap_data](../../../../../.src/Gestion/option/EditfacB.class#L648-L659)
- [ ] EDITFACB-A02 — [anomalie] BL non chiffré : `Me.clr($bout)` sur un objet nul (colonne
  absente) décale l'alternance de couleurs par rapport à la facture ; en-tête « Colis »/« Pal »
  aligné sur `$coli`/`$Palette` créés dans l'ordre inverse de la branche facture (à vérifier sur
  PDF) · tests : T02 · sources : [EditfacB.class:59-61](../../../../../.src/Gestion/option/EditfacB.class#L59-L61)
