# Stockmvt — Rework

> Source : `.src/Gestion/Stockmvt.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stockmvt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 843 |
| Lignes de commentaire | 23 |
| Fonctions | 18 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 75 (`Buttrait_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 843 | 163 | 75 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STOCKMVT-001 — [documentation] En-tête en français : rôle, liste des 10 sources et de leurs
  colonnes, règles d'exclusion (client/fournisseur), sens de `qtem`/`qtep` ; commentaires `'''`
  sur `Buttrait_Click`, `affiche`, `dtinv` · appelants : aucun · tests : aucun · sources :
  [Stockmvt.class:Buttrait_Click](../../../../.src/Gestion/Stockmvt.class#L64-L504), [Stockmvt.class:affiche](../../../../.src/Gestion/Stockmvt.class#L512-L583)
- [ ] STOCKMVT-002 — [code mort] Supprimer `$soption` (jamais utilisé) et rendre `$rpt` local à
  `Butedit_Click` · appelants : aucun · tests : T07 · sources : [Stockmvt.class:4](../../../../.src/Gestion/Stockmvt.class#L4), [Stockmvt.class:10](../../../../.src/Gestion/Stockmvt.class#L10)
- [ ] STOCKMVT-003 — [réarchitecture] Renommer la méthode privée `TriArticles` (homonyme de la
  classe) en `RemplitArbreFamilles` · appelants : aucun (privée) · tests : T02 · sources :
  [Stockmvt.class:TriArticles](../../../../.src/Gestion/Stockmvt.class#L46-L62)
- [ ] STOCKMVT-004 — [séparation traitement/GUI] Extraire `ConstruitRequete(criteres) As String`
  (pure, sans accès aux contrôles) depuis `Buttrait_Click` ; le handler lit les contrôles,
  appelle la fonction puis exécute ; **sans changement SQL** (diff `Exec_SQL` bloquant) ·
  appelants : aucun · tests : T01 à T06, T10 · sources : [Stockmvt.class:Buttrait_Click](../../../../.src/Gestion/Stockmvt.class#L64-L504)
- [ ] STOCKMVT-005 — [complexité] Dans `ConstruitRequete`, remplacer les 40 variables
  `champ*/fichier*/cond*/lib*` par un tableau de descripteurs de source et des boucles, SQL
  identique à l'octet près (CC 75 → ≤ 20 visé), en plusieurs commits si nécessaire · appelants :
  aucun · tests : T01 à T06, T10, T11 · sources : [Stockmvt.class:Buttrait_Click](../../../../.src/Gestion/Stockmvt.class#L64-L504)
- [ ] STOCKMVT-006 — [séparation traitement/GUI] Extraire le calcul des totaux d'`affiche` et la
  génération des lignes CSV de `Butexp_Click` en fonctions sans contrôle · appelants : aucun ·
  tests : T01, T08 · sources : [Stockmvt.class:affiche](../../../../.src/Gestion/Stockmvt.class#L512-L583), [Stockmvt.class:Butexp_Click](../../../../.src/Gestion/Stockmvt.class#L940-L959)
- [ ] STOCKMVT-007 — [réarchitecture] Noms de tables par `Cbase.Table` (14 tables), SQL identique ·
  appelants : aucun · tests : T01 à T06 · sources : [Stockmvt.class:Buttrait_Click](../../../../.src/Gestion/Stockmvt.class#L64-L504), [Stockmvt.class:dtinv](../../../../.src/Gestion/Stockmvt.class#L686-L697), [Stockmvt.class:btn_Click](../../../../.src/Gestion/Stockmvt.class#L854-L880)
- [ ] STOCKMVT-008 — [commonalisation] Description commune des sources de mouvements (tables,
  colonnes code/date/famille/quantité, signe) partagée avec `Cstock.Calc_stock`, **en conservant
  les règles propres à chaque fichier** (types de BL, conversion, tickets) ; SQL identique dans
  les deux fichiers · appelants : `Cstock` (même commit) · tests : T01 à T06, tests de `Cstock` ·
  sources : [Stockmvt.class:Buttrait_Click](../../../../.src/Gestion/Stockmvt.class#L64-L504), [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STOCKMVT-A01 — [anomalie] Filtre marque/centrale : jointure `art_code = num_ligfac` (numéro
  de facture) au lieu de `code_ligfac` pour les factures archivées et archivées entretien ·
  tests : T03 · sources : [Stockmvt.class:159](../../../../.src/Gestion/Stockmvt.class#L159), [Stockmvt.class:161](../../../../.src/Gestion/Stockmvt.class#L161)
- [ ] STOCKMVT-A02 — [anomalie] Fournisseur seul + stock de départ ou théorique coché : le
  préfixe `UNION ALL` de la sous-requête réceptions est retiré alors qu'elle n'est pas en tête
  (SQL invalide) · tests : T04 · sources : [Stockmvt.class:474](../../../../.src/Gestion/Stockmvt.class#L474)
- [ ] STOCKMVT-A03 — [anomalie] Double-clic : « Factures en cours entretien » ouvre le document
  dans `Fiches_Bl` (`ObjFac.bl`) et « archives entretien » dans les archives non entretien (test
  `Match` trop large, à confirmer) · tests : T09 · sources : [Stockmvt.class:672](../../../../.src/Gestion/Stockmvt.class#L672), [Stockmvt.class:GridView1_Activate](../../../../.src/Gestion/Stockmvt.class#L664-L684)
- [ ] STOCKMVT-A04 — [anomalie] Export CSV en mode regroupé : lecture de `$res!nom`, absent hors
  détail (erreur) ; `mrgmo` non exporté · tests : T08 · sources : [Stockmvt.class:Butexp_Click](../../../../.src/Gestion/Stockmvt.class#L940-L959)
- [ ] STOCKMVT-A05 — [anomalie] Définition des mouvements divergente de `Cstock` (BL de type `A`
  inclus, réceptions sans `art_txconv`, tickets de caisse inclus, dépôts et inventaire tournant
  absents) : le stock reconstitué par cet écran ne correspond pas à `art_qte` ; aligner change les
  chiffres affichés · tests : T01, T05 · sources : [Stockmvt.class:95](../../../../.src/Gestion/Stockmvt.class#L95), [Stockmvt.class:226](../../../../.src/Gestion/Stockmvt.class#L226), [Stockmvt.class:123](../../../../.src/Gestion/Stockmvt.class#L123), [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134)
- [ ] STOCKMVT-A06 — [anomalie] `Radiofam` sans famille sélectionnée : `Utils.fam` produit
  `IN)` (UTILS-A02), erreur SQL ; à corriger avec UTILS-A02 · tests : T06 · sources : [Stockmvt.class:287](../../../../.src/Gestion/Stockmvt.class#L287), [Utils.module:fam](../../../../.src/Utils/Utils.module#L1439-L1452)
