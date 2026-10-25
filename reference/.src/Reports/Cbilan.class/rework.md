# Cbilan — Rework

> Source : `.src/Reports/Cbilan.class` · Message de commit (phase 4) : `reference/.src/Reports/Cbilan.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 6 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 17 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 166 | 67 | 17 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CBILAN-001 — [documentation] En-tête de classe en français : gabarit du bilan, colonnes
  actif/passif selon `Sens`, règles de calcul du net (y compris les cas figés par A01/A02),
  couleurs fixes ; commentaire `'''` par méthode · appelants : aucun · tests : T01-T04 · sources : [Cbilan.class:Level1](../../../../.src/Reports/Cbilan.class#L48-L77), [Cbilan.class:Level3](../../../../.src/Reports/Cbilan.class#L173-L198)
- [ ] CBILAN-002 — [code mort] Supprimer `Level1A`, `Level2` (aucun appelant, vérifié par grep) et
  `_free` · appelants : aucun · tests : T01-T03 · sources : [Cbilan.class:Level1A](../../../../.src/Reports/Cbilan.class#L113-L119), [Cbilan.class:Level2](../../../../.src/Reports/Cbilan.class#L156-L171), [Cbilan.class:_free](../../../../.src/Reports/Cbilan.class#L17-L19)
- [ ] CBILAN-003 — [séparation traitement/GUI] Fonction privée `NetBilan(imp1, imp2, avec_abs) As
  String` reproduisant exactement le calcul de `Level1`, `Level1L` (avec `Abs`) et `Level1S` ; les
  niveaux ne gardent que le rendu · appelants : aucun · tests : T02, T03, T05 · sources : [Cbilan.class:Level1](../../../../.src/Reports/Cbilan.class#L48-L77), [Cbilan.class:Level1L](../../../../.src/Reports/Cbilan.class#L79-L110), [Cbilan.class:Level1S](../../../../.src/Reports/Cbilan.class#L121-L154)
- [ ] CBILAN-004 — [complexité] Helpers privés `PositionX(Sens, xA, xP)` et `CelluleMontant(w, v)`
  (le `Try Me.cell(…, Format$(Val(Utils.cpoint(v)), ",#"), …)` répété 9 fois, y compris l'absence
  de cellule si la conversion échoue) ; CC cumulée des trois `Level1*` 48 → ≤ 15 visé · appelants :
  aucun · tests : T02, T03 · sources : [Cbilan.class:Level1](../../../../.src/Reports/Cbilan.class#L48-L77), [Cbilan.class:Level1L](../../../../.src/Reports/Cbilan.class#L79-L110), [Cbilan.class:Level1S](../../../../.src/Reports/Cbilan.class#L121-L154)
- [ ] CBILAN-005 — [code mort] Supprimer les paramètres inutilisés `detail` (`Level0`), `dte2`
  (`Level3`), `p5`, `imp3`, `imp4` (`Level1*`) · appelants : `Imp_Bilan` (tous les appels, même
  commit) · tests : T01-T03, T05 · sources : [Cbilan.class:Level0](../../../../.src/Reports/Cbilan.class#L32-L45), [Cbilan.class:Level3](../../../../.src/Reports/Cbilan.class#L173-L198), [Imp_Bilan.module:682](../../../../.src/Compta/Impressions/Imp_Bilan.module#L682)
- [ ] CBILAN-006 — [commonalisation] (phase 3) Dériver de `PdfLaurux` : `BasPage` standard, `Level0`
  via `TitreEtat(titre, periode, ste, 200, rempli)` partagé avec `Csig`/`Cresultat`, `Lines` →
  `Integer` ; PDF identique · appelants : aucun · tests : T01, T04 · sources : [Cbilan.class:BasPage](../../../../.src/Reports/Cbilan.class#L22-L29), [Cbilan.class:Level0](../../../../.src/Reports/Cbilan.class#L32-L45), [Csig.class:Level0](../../../../.src/Reports/Csig.class#L32-L45)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CBILAN-A01 — [anomalie] Net nul remplacé par le brut : dans `Level1` et `Level1S`, si
  `imp1 − imp2` vaut 0 (poste totalement amorti), le test `imp2 = "0"` qui suit remet `imp2 =
  imp1` et la colonne N affiche le **montant brut** au lieu de 0 · appelants : `Imp_Bilan` · tests :
  T02, T03, T05 · sources : [Cbilan.class:68](../../../../.src/Reports/Cbilan.class#L68), [Cbilan.class:145](../../../../.src/Reports/Cbilan.class#L145)
- [ ] CBILAN-A02 — [anomalie, à confirmer par un comptable] `Level1L` calcule le net sur la valeur
  absolue du brut (`Abs(Val(imp1)) − Val(imp2)`), `Level1` et `Level1S` sur le brut signé : une
  ligne de détail à brut négatif (compte `129…` inversé par `Imp_Bilan`, voir IMP_BILAN-A08) n'a pas
  le même net que son total · appelants : `Imp_Bilan` · tests : T03 · sources : [Cbilan.class:98](../../../../.src/Reports/Cbilan.class#L98), [Cbilan.class:66](../../../../.src/Reports/Cbilan.class#L66)
