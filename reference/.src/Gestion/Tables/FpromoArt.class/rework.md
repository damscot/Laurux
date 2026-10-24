# FpromoArt — Rework

> Source : `.src/Gestion/Tables/FpromoArt.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/FpromoArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 377 |
| Lignes de commentaire | 52 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 96 |
| Complexité max (fonction) | 22 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 377 | 96 | 22 | 0 | 26 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FPROMOART-001 — [documentation] En-tête : déroulement de la saisie, groupe `Cmpt` (tags),
  drapeau `B`, retour de `TriArticles` par `Bsel`/`Bval` · appelants : aucun · tests : aucun ·
  sources : [FpromoArt.class:20](../../../../../.src/Gestion/Tables/FpromoArt.class#L20), [FpromoArt.class:Cmpt_Keypress](../../../../../.src/Gestion/Tables/FpromoArt.class#L197-L275)
- [ ] FPROMOART-002 — [code mort] Supprimer `Code_KeyPress` (handler inactif, `Code` groupé dans
  `Cmpt`), `Calc_Marge` (jamais appelée), les variables `Prvt`, `Margem`, `Margep` et les couleurs
  inutilisées · appelants : aucun · tests : T01-T06 · sources : [FpromoArt.class:Code_KeyPress](../../../../../.src/Gestion/Tables/FpromoArt.class#L91-L110), [FpromoArt.class:Calc_Marge](../../../../../.src/Gestion/Tables/FpromoArt.class#L511-L520), [FpromoArt.class:37](../../../../../.src/Gestion/Tables/FpromoArt.class#L37)
- [ ] FPROMOART-003 — [complexité] `Cmpt_Keypress` (CC 22) : extraire `ValidePrixHT()` et
  `ValidePrixTTC()` privés, comportement identique (drapeau `B` compris) · appelants : aucun ·
  tests : T01-T03 · sources : [FpromoArt.class:Cmpt_Keypress](../../../../../.src/Gestion/Tables/FpromoArt.class#L197-L275)
- [ ] FPROMOART-004 — [commonalisation] Recherche d'article (code, code fournisseur, code
  équivalent, code-barres) via une fonction commune avec MvtDepots/Sdepots/Facture ; calcul HT/TTC
  via `LPrix`/`LTaxe` (valeurs identiques au centime, à vérifier par T07) · appelants : aucun ·
  tests : T01, T06, T07 · sources : [FpromoArt.class:art_man](../../../../../.src/Gestion/Tables/FpromoArt.class#L430-L470), [FpromoArt.class:CalcTTC](../../../../../.src/Gestion/Tables/FpromoArt.class#L475-L480), [FpromoArt.class:CalcHt](../../../../../.src/Gestion/Tables/FpromoArt.class#L485-L493), [MvtDepots.class:art_man](../../../../../.src/Gestion/Depots/MvtDepots.class#L243-L295)
- [ ] FPROMOART-005 — [séparation traitement/GUI] `PrixTTC`, `PrixHT`, `EnregistreArtPromo`,
  `SupprimeArtPromo` sans contrôle · appelants : aucun · tests : T01-T07 · sources : [FpromoArt.class:Button3_Click](../../../../../.src/Gestion/Tables/FpromoArt.class#L313-L334), [FpromoArt.class:delArt](../../../../../.src/Gestion/Tables/FpromoArt.class#L403-L410), [FpromoArt.class:Recup_Tva](../../../../../.src/Gestion/Tables/FpromoArt.class#L498-L506)
- [ ] FPROMOART-006 — [réduction de portée] `Cpromo`, `ChkPrx`, `Deb2`, `CleanChamps`, `delArt`,
  `SelectionArt`, `art_man`, `CalcTTC`, `CalcHt`, `Recup_Tva` → `Private` ; `Bsel`/`Bval`,
  `Colpromo_Click`, `ColArtPromo_Click` restent `Public` · appelants : aucun · tests : T01-T06 ·
  sources : [FpromoArt.class:Cpromo](../../../../../.src/Gestion/Tables/FpromoArt.class#L174-L195), [FpromoArt.class:ChkPrx](../../../../../.src/Gestion/Tables/FpromoArt.class#L277-L285), [FpromoArt.class:SelectionArt](../../../../../.src/Gestion/Tables/FpromoArt.class#L413-L425)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FPROMOART-A01 — [anomalie] `Deb2` : code promotion concaténé (apostrophe → erreur SQL) et
  `order by '<Tri>'` sur une chaîne littérale (aucun tri) · tests : T01 · sources : [FpromoArt.class:303](../../../../../.src/Gestion/Tables/FpromoArt.class#L303)
- [ ] FPROMOART-A02 — [anomalie] `Button5_Click` écrit `Item[2]`/`Item[3]` dans une liste de 2
  colonnes (stockage à confirmer) et `Colpromo_Click` relit ces dates · tests : T01 · sources : [FpromoArt.class:135](../../../../../.src/Gestion/Tables/FpromoArt.class#L135), [FpromoArt.class:150](../../../../../.src/Gestion/Tables/FpromoArt.class#L150)
- [ ] FPROMOART-A03 — [anomalie] Drapeau `B` positionné dans la branche TTC mais remis à 0
  seulement dans la branche HT : la validation HT suivante saute le calcul du TTC · tests : T03 ·
  sources : [FpromoArt.class:240](../../../../../.src/Gestion/Tables/FpromoArt.class#L240), [FpromoArt.class:228](../../../../../.src/Gestion/Tables/FpromoArt.class#L228)
