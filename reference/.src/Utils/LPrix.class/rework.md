# LPrix — Rework

> Source : `.src/Utils/LPrix.class` · Message de commit (phase 4) : `reference/.src/Utils/LPrix.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 518 |
| Lignes de commentaire | 31 |
| Fonctions | 50 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 124 |
| Complexité max (fonction) | 21 (`Conv_Brut_Net_HT_TTC`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 518 | 124 | 21 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LPRIX-001 — [documentation] En-tête de classe en français : rôle, invariants (`Mnt` unitaire,
  total = `Mnt * Qte`), tableau des propriétés de format ; commentaires `'''` sur chaque méthode
  Public · appelants : aucun · tests : T01-T13 · sources : [LPrix.class:_New](../../../../.src/Utils/LPrix.class#L44-L74)
- [ ] LPRIX-002 — [code mort] Supprimer `_put`/`_get` (jamais utilisés, bornes erronées) et la
  variable `$qte` de `QD_Read` · appelants : aucun · tests : tous · sources : [LPrix.class:_put](../../../../.src/Utils/LPrix.class#L85-L92), [LPrix.class:_get](../../../../.src/Utils/LPrix.class#L94-L102), [LPrix.class:QD_Read](../../../../.src/Utils/LPrix.class#L304-L318)
- [ ] LPRIX-003 — [commonalisation] Helper privé `Conv(prix, qte, sens_bn, sens_ht)` utilisé par
  les 14 accesseurs `Pu*`/`Tot*` · appelants : aucun · tests : T06, T08, T09 · sources : [LPrix.class:PuBHT_Write](../../../../.src/Utils/LPrix.class#L360-L365), [LPrix.class:TotNTC_Read](../../../../.src/Utils/LPrix.class#L505-L513)
- [ ] LPRIX-004 — [complexité] `Conv_Brut_Net_HT_TTC` : extraire le filtre `ignore_taxe` et les
  trois boucles dans un helper privé (CC 21 → ≤ 8 visé) · appelants : aucun · tests : T06, T07 · sources : [LPrix.class:Conv_Brut_Net_HT_TTC](../../../../.src/Utils/LPrix.class#L520-L575)
- [ ] LPRIX-005 — [commonalisation] `Add`/`AddA`/`Sub`/`SubA`/`Sum`/`SumA` → `Cumul(alp, signe,
  avec_arrondi)` privé ; signatures Public conservées · appelants : `Saisecrit` (inchangé) · tests : T10 · sources : [LPrix.class:Add](../../../../.src/Utils/LPrix.class#L591-L596), [LPrix.class:SumA](../../../../.src/Utils/LPrix.class#L630-L639)
- [ ] LPRIX-006 — [séparation traitement/GUI] `Arrondi_Conv` : conversion pure (renvoie -1 en cas
  d'erreur) + `Message.Error` dans l'appelant, même message · appelants : aucun · tests : T04 · sources : [LPrix.class:Arrondi_Conv](../../../../.src/Utils/LPrix.class#L114-L162)
- [ ] LPRIX-007 — [complexité] Table de correspondance énumération ↔ pas d'arrondi, partagée par
  `Arrondi_Conv` et `Arr_Read`, avec un comportement **identique** (cas `Arr_00005`/`Arr_00001`
  toujours `""`) (CC 17 → ≤ 5 visé) · tests : T03, T04 · sources : [LPrix.class:Arrondi_Conv](../../../../.src/Utils/LPrix.class#L114-L162), [LPrix.class:Arr_Read](../../../../.src/Utils/LPrix.class#L335-L356)
- [ ] LPRIX-008 — [réduction de portée] `Conv_Brut_Net_HT_TTC`, `Arrondi_New`, `AddA`, `SubA`,
  `Sum`, `SumA`, `Del_Taxe`, `Lit_Taxe` → `Private` si la couverture par les propriétés est
  confirmée (sinon le membre reste `Public`) · appelants : aucun · tests : tous · sources : [LPrix.class:Conv_Brut_Net_HT_TTC](../../../../.src/Utils/LPrix.class#L520-L575), [LPrix.class:Arrondi_New](../../../../.src/Utils/LPrix.class#L577-L589), [LPrix.class:Lit_Taxe](../../../../.src/Utils/LPrix.class#L675-L681)
- [ ] LPRIX-009 — [commonalisation] Conversion Variant → Float de `_New` vers
  `Utils.VariantToFloat` (partagée avec `LTaxe`, voir LTAXE) · appelants : `LTaxe` · tests : T01 · sources : [LPrix.class:_New](../../../../.src/Utils/LPrix.class#L44-L74), [LTaxe.class:_New](../../../../.src/Utils/LTaxe.class#L26-L47)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LPRIX-A01 — [anomalie] `_call` transmet `Qte` de l'auto-instance au lieu de `Quantite`
  (impact : `LTaxe.Montant`, taxes sur quantité ≠ 1) · tests : T12 · sources : [LPrix.class:80](../../../../.src/Utils/LPrix.class#L80), [LTaxe.class:137](../../../../.src/Utils/LTaxe.class#L137)
- [ ] LPRIX-A02 — [anomalie] `QD_Write` écrit `Mnt` au lieu de `Qte` · tests : T05 · sources : [LPrix.class:QD_Write](../../../../.src/Utils/LPrix.class#L320-L325)
- [ ] LPRIX-A03 — [anomalie] `Arr_Read` ne gère pas `Arr_00005`/`Arr_00001` · tests : T04 · sources : [LPrix.class:Arr_Read](../../../../.src/Utils/LPrix.class#L335-L356)
- [ ] LPRIX-A04 — [anomalie] `Abs()` ne lève pas `change` ; `TotBHT_Write` divise par `Qte = 0` · tests : T09, T13 · sources : [LPrix.class:Abs](../../../../.src/Utils/LPrix.class#L669-L673), [LPrix.class:TotBHT_Write](../../../../.src/Utils/LPrix.class#L439-L444)
