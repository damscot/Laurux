# Edbl — Rework

> Source : `.src/Gestion/Impressions/Edbl.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edbl.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 212 |
| Lignes de commentaire | 39 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 6 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 212 | 39 | 6 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDBL-001 — [documentation] En-tête : réimpression via `Edbr.Ed`, mémorisation de
  `codef`/`dater`, tri par en-têtes, `Colbl_Click` à garder `Public` (rejeu dynamique) · appelants :
  aucun · tests : aucun · sources : [Edbl.class:_New](../../../../../.src/Gestion/Impressions/Edbl.class#L35-L42), [Edbl.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edbl.class#L278-L303)
- [ ] EDBL-002 — [code mort] Supprimer le `Kill` de `~/tmp//Edbl.ps` (fichier jamais produit) et
  les membres `Tab`/`Tab2` au profit de locales · appelants : aucun · tests : T01-T03 · sources : [Edbl.class:307](../../../../../.src/Gestion/Impressions/Edbl.class#L307), [Edbl.class:27](../../../../../.src/Gestion/Impressions/Edbl.class#L27)
- [ ] EDBL-003 — [réduction de portée] `Aff_Data`, `cache_bl` → `Private` (appels internes
  seulement) · appelants : aucun · tests : T03, T05, T06 · sources : [Edbl.class:Aff_Data](../../../../../.src/Gestion/Impressions/Edbl.class#L104-L138), [Edbl.class:cache_bl](../../../../../.src/Gestion/Impressions/Edbl.class#L163-L172)
- [ ] EDBL-004 — [complexité] Helper `TrierPar(sAsc, sDesc)` pour les cinq `*_GotFocus` et
  `ImprimeBon(sNumero)` pour `Cmpt_KeyPress`/`Button2_Click` (comportement identique, mémorisation
  comprise) · appelants : aucun · tests : T01-T05 · sources : [Edbl.class:Nm_GotFocus](../../../../../.src/Gestion/Impressions/Edbl.class#L192-L205), [Edbl.class:Mt_GotFocus](../../../../../.src/Gestion/Impressions/Edbl.class#L252-L265), [Edbl.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/Edbl.class#L47-L75), [Edbl.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edbl.class#L278-L303)
- [ ] EDBL-005 — [séparation traitement/GUI] `ReceptionParNumero` et `ListeReceptions(sTri)` avec
  `Cbase.Table` (SQL identique) · appelants : aucun · tests : T01, T03, T05 · sources : [Edbl.class:58](../../../../../.src/Gestion/Impressions/Edbl.class#L58), [Edbl.class:119](../../../../../.src/Gestion/Impressions/Edbl.class#L119)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDBL-A01 — [anomalie] `codef`/`dater` mémorisés : après une impression, un autre numéro tapé
  dans `Nbl` est imprimé avec le fournisseur précédent ; `Colbl_KeyPress` déclare une locale
  `codef` qui masque le membre (Entrée dans la liste ne met rien à jour) · tests : T04 · sources : [Edbl.class:145](../../../../../.src/Gestion/Impressions/Edbl.class#L145), [Edbl.class:285](../../../../../.src/Gestion/Impressions/Edbl.class#L285), [Edbl.class:299](../../../../../.src/Gestion/Impressions/Edbl.class#L299)
- [ ] EDBL-A02 — [anomalie] Recherche par `numrecpt` seul : avec un même numéro chez deux
  fournisseurs, le premier trouvé est imprimé · tests : T07 · sources : [Edbl.class:58](../../../../../.src/Gestion/Impressions/Edbl.class#L58), [Edbl.class:286](../../../../../.src/Gestion/Impressions/Edbl.class#L286)
- [ ] EDBL-A03 — [anomalie] `cache_bl` ne masque pas l'en-tête `Mt` (montant) · tests : T06 ·
  sources : [Edbl.class:cache_bl](../../../../../.src/Gestion/Impressions/Edbl.class#L163-L172)
- [ ] EDBL-A04 — [anomalie, à confirmer] `dater` transmis à `Edbr` sous deux formes (valeur `Date`
  ou texte `dd.mm.yyyy`) : date des pages suivantes et date GED (`LDate(dater)`) dépendantes du
  chemin suivi · tests : T01, T03 · sources : [Edbl.class:61](../../../../../.src/Gestion/Impressions/Edbl.class#L61), [Edbl.class:181](../../../../../.src/Gestion/Impressions/Edbl.class#L181), [Edbr.module:234](../../../../../.src/Gestion/Impressions/Edbr.module#L234)
