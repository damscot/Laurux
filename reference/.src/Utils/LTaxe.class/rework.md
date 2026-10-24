# LTaxe — Rework

> Source : `.src/Utils/LTaxe.class` · Message de commit (phase 4) : `reference/.src/Utils/LTaxe.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 13 |
| Fonctions | 8 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 88 | 23 | 5 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LTAXE-001 — [documentation] En-tête de classe en français : rôle, convention de signe des
  remises, sens de `All_Taxes`/`All_Remises`, contrat de `Montant` (renvoie le **total** de la taxe
  dans `Mnt` avec `Qte = 1`) · appelants : aucun · tests : T01-T10 · sources : [LTaxe.class:_New](../../../../.src/Utils/LTaxe.class#L26-L47), [LTaxe.class:Montant](../../../../.src/Utils/LTaxe.class#L112-L139)
- [ ] LTAXE-002 — [commonalisation] Conversion Variant → Float de `_New` via
  `Utils.VariantToFloat` (créée par LPRIX-009, à faire dans le même lot) ; le retrait du `%` reste
  local · appelants : aucun · tests : T01, LPRIX-T01 · sources : [LTaxe.class:_New](../../../../.src/Utils/LTaxe.class#L26-L47), [LPrix.class:_New](../../../../.src/Utils/LPrix.class#L44-L74)
- [ ] LTAXE-003 — [complexité] `Montant` : extraire le calcul dans une fonction privée pure
  `Calcul(base, qte, ttc) As Float` · appelants : `LPrix`, `calculdroit1`, `Consigne`, `Achat`,
  `ValidBR1`, `Moulinage` (signature inchangée) · tests : T05-T09, LPRIX-T06 · sources : [LTaxe.class:Montant](../../../../.src/Utils/LTaxe.class#L112-L139)
- [ ] LTAXE-004 — [séparation traitement/GUI] Prédicats purs `TypeValide(type)` et
  `CompteValide(type, cpt)` ; `Ttx_Write`/`Cpt_Write` gardent le `Message.Error` (même texte) ·
  appelants : aucun · tests : T03, T04 · sources : [LTaxe.class:Ttx_Write](../../../../.src/Utils/LTaxe.class#L94-L106), [LTaxe.class:Cpt_Write](../../../../.src/Utils/LTaxe.class#L64-L74)
- [ ] LTAXE-005 — [code mort] Supprimer la propriété `Lib` (`Libelle`, `Lib_Read`, `Lib_Write`)
  si `grep -rn "\.Lib\b" .src` ne trouve toujours aucun usage · appelants : aucun · tests : tous · sources : [LTaxe.class:Lib_Read](../../../../.src/Utils/LTaxe.class#L76-L80), [LTaxe.class:Lib_Write](../../../../.src/Utils/LTaxe.class#L82-L86)
- [ ] LTAXE-006 — [réarchitecture] `All_Taxes`/`All_Remises` en `Static Public` initialisées une
  seule fois (plus d'allocation par instance) ; vérifier avec `gbc3` que `LTaxe.All_Taxes` reste
  accessible · appelants : `LPrix` (inchangé) · tests : T10, LPRIX-T06, LPRIX-T07 · sources : [LTaxe.class:14-15](../../../../.src/Utils/LTaxe.class#L14-L15)
- [ ] LTAXE-007 — [code mort] Retirer `Inherits Array` si aucun usage indexé de `LTaxe` n'est
  trouvé (à vérifier avec `gbc3 -agt`) · appelants : aucun · tests : tous · sources : [LTaxe.class:3](../../../../.src/Utils/LTaxe.class#L3)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LTAXE-A01 — [anomalie] `Montant` renvoie `LPrix(val, qte, …)` avec `val` déjà multiplié par
  `qte` : correct aujourd'hui uniquement grâce à LPRIX-A01 (quantité ignorée par `_call`). À
  corriger **dans le même commit que LPRIX-A01** (passer `val / qte` ou quantité 1) · appelants :
  `ValidBR1.class:419`, `Achat.class:994`, `LPrix` · tests : T08, LPRIX-T12 · sources : [LTaxe.class:137](../../../../.src/Utils/LTaxe.class#L137), [LPrix.class:_call](../../../../.src/Utils/LPrix.class#L76-L83)
- [ ] LTAXE-A02 — [anomalie] `Ttx_Write` négative le montant à chaque affectation de `Remise` ou
  `Deconsigne` (double affectation = signe repositif) ; défaut latent, aucune écriture externe de
  `Ttx` aujourd'hui · tests : T02 · sources : [LTaxe.class:101-103](../../../../.src/Utils/LTaxe.class#L101-L103)
- [ ] LTAXE-A03 — [anomalie] Le message d'erreur de `Cpt_Write` affiche le numéro du type
  (`… pour la Taxe 2`) au lieu de son nom · tests : manuel · sources : [LTaxe.class:67](../../../../.src/Utils/LTaxe.class#L67)
