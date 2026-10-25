# Etiqfbtarif — Rework

> Source : `.src/Gestion/Etiquettes/Etiqfbtarif.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Etiqfbtarif.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 365 |
| Lignes de commentaire | 35 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 18 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 365 | 92 | 18 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQFBTARIF-001 — [documentation] En-tête en français : rôle (prix recalculés à la date de
  fiche barème), chaîne de calcul, lien avec `MajFbtarif2` · appelants : aucun · tests : T01 · sources : [Etiqfbtarif.class:_new](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L47-L57), [Etiqfbtarif.class:prix_base](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L198-L218)
- [ ] ETIQFBTARIF-002 — [code mort] Supprimer `Calc_Marge`, `Calc_Percent`, `Calc_coeff` et les
  membres `Margem`, `Margep`, `Percent`, `Pmp`, `Stocke` (résultats jamais imprimés, `Coeff` relu en
  base à chaque article), ainsi que `Kill … EtiqGond.ps`, `Shell "cd ~"`, `SorP`, `Rect`,
  `Filename` initial · appelants : aucun · tests : T01-T05 (PDF identique) · sources : [Etiqfbtarif.class:Calc_Marge](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L295-L308), [Etiqfbtarif.class:Calc_Percent](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L355-L359), [Etiqfbtarif.class:Calc_coeff](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L364-L368), [Etiqfbtarif.class:94](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L94), [Etiqfbtarif.class:122](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L122)
- [ ] ETIQFBTARIF-003 — [séparation traitement/GUI] Calcul de prix en fonction pure
  `PrixVente(rArt, brut)` renvoyant `Pvht`/`PvTTC` formatés, sans membres partagés ni
  `Message.Error` (erreur renvoyée, message dans `Button2_Click`) · appelants : aucun · tests : T01-T03,
  T07 · sources : [Etiqfbtarif.class:prix_base](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L198-L218), [Etiqfbtarif.class:Prix_achat](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L239-L262), [Etiqfbtarif.class:TrC](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L223-L237), [Etiqfbtarif.class:PvTTC_arrondi](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L313-L350)
- [ ] ETIQFBTARIF-004 — [commonalisation] Utiliser la fonction de prix barème commune avec
  `MajFbtarif2` / `MajTarifP` / `Impart` (lot Stock/Tarifs) si T07 est identique · appelants :
  aucun · tests : T03, T07 · sources : [Etiqfbtarif.class:PvTTC_arrondi](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L313-L350), [Etiqfbtarif.class:Tva_Calcul](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L281-L290), [Etiqfbtarif.class:PvTTcLF](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L373-L380)
- [ ] ETIQFBTARIF-005 — [réduction de portée] `init_ComboBox`, `fin_impression`, `prix_base`, `TrC`,
  `Prix_achat`, `rTva`, `Tva_Calcul`, `PvTTC_arrondi`, `PvTTcLF`, `Imprime`, `pos_Etiq` → `Private`
  (les fonctions supprimées par ETIQFBTARIF-002 exclues) · appelants : aucun · tests : T01-T05 · sources : [Etiqfbtarif.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L59-L75), [Etiqfbtarif.class:rTva](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L267-L276), [Etiqfbtarif.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L383-L437), [Etiqfbtarif.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L439-L460)
- [ ] ETIQFBTARIF-006 — [commonalisation] `init_ComboBox`, format, ouverture PDF, `pos_Etiq` (V4) et
  `fin_impression` via `PlancheEtiquettes` (après ETIQART-010) ; PDF identique · appelants : aucun
  · tests : T01, T04 · sources : [Etiqfbtarif.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L83-L165), [Etiqfbtarif.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L167-L176)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQFBTARIF-A01 — [anomalie] `i2 = 0` à chaque article : le compteur de rangées ne dépasse
  jamais 1, `pdf.NewPage()` n'est jamais appelé pour une planche de plus d'une rangée et les
  étiquettes suivantes sont dessinées sous le bas de page (à confirmer en replay) ; espacement compté
  une fois (V4) ; format lu par `code` seul · tests : T04 · sources : [Etiqfbtarif.class:156](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L156), [Etiqfbtarif.class:451](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L451), [Etiqfbtarif.class:444](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L444), [Etiqfbtarif.class:99](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L99)
- [ ] ETIQFBTARIF-A02 — [anomalie] Imprimante Zebra : aucun PDF, `pdf.Open()` sur `Null` ; aucun
  message quand aucun article ne correspond à la date ; sauts `Posetiq` calculés avant la création
  du PDF · tests : T06 · sources : [Etiqfbtarif.class:127](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L127), [Etiqfbtarif.class:134](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L134), [Etiqfbtarif.class:118](../../../../../.src/Gestion/Etiquettes/Etiqfbtarif.class#L118)
