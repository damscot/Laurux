# Depots — Rework

> Source : `.src/Gestion/Depots/Depots.class` · Message de commit (phase 4) : `reference/.src/Gestion/Depots/Depots.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 274 |
| Lignes de commentaire | 23 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 74 |
| Complexité max (fonction) | 13 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 274 | 74 | 13 | 0 | 31 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DEPOTS-001 — [documentation] En-tête : rôle du dépôt `01`, tables associées, effet réel de
  la « copie des produits » (tous les articles à 0) · appelants : aucun · tests : aucun · sources : [Depots.class:20](../../../../../.src/Gestion/Depots/Depots.class#L20), [Depots.class:Button1_Click](../../../../../.src/Gestion/Depots/Depots.class#L220-L249)
- [ ] DEPOTS-002 — [code mort] Supprimer `Cpman` (jamais appelée), `Btn_KeyPress` (groupe `Btn`
  absent du `.form`), `Libelle_GotFocus` (appelé seulement par `Cpman`), `Code_LostFocus` vide et
  son appel, la variable `Tab`, `Tri = "cp"`, `Me.Visible = True` · appelants : aucun · tests :
  T01-T05 · sources : [Depots.class:Cpman](../../../../../.src/Gestion/Depots/Depots.class#L275-L285), [Depots.class:Btn_KeyPress](../../../../../.src/Gestion/Depots/Depots.class#L185-L194), [Depots.class:Libelle_GotFocus](../../../../../.src/Gestion/Depots/Depots.class#L202-L206), [Depots.class:Code_LostFocus](../../../../../.src/Gestion/Depots/Depots.class#L208-L212), [Depots.class:269](../../../../../.src/Gestion/Depots/Depots.class#L269)
- [ ] DEPOTS-003 — [complexité] Initialisation du stock par un seul
  `INSERT … SELECT &1, art_code, 0 FROM <TabArt>` via `Cbase.Table` (SQL modifié, dump identique) ;
  `UPdate` sans réécriture de la clé · appelants : aucun · tests : T01, T02 · sources : [Depots.class:232](../../../../../.src/Gestion/Depots/Depots.class#L232), [Depots.class:236](../../../../../.src/Gestion/Depots/Depots.class#L236), [Depots.class:228](../../../../../.src/Gestion/Depots/Depots.class#L228)
- [ ] DEPOTS-004 — [commonalisation] Socle « grille filtrable » (voir CPOSTAUX-005) et module
  `Depot` (liste, libellé) partagé avec MvtDepots, Sdepots, ImpDepots · appelants : aucun · tests :
  T04, MVTDEPOTS-T01, SDEPOTS-T01, IMPDEPOTS-T01 · sources : [Depots.class:Deb2](../../../../../.src/Gestion/Depots/Depots.class#L79-L83), [Depots.class:Dbclk](../../../../../.src/Gestion/Depots/Depots.class#L378-L388), [MvtDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/MvtDepots.class#L73-L87), [Sdepots.class:aff_Depot](../../../../../.src/Gestion/Depots/Sdepots.class#L65-L79), [ImpDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/ImpDepots.class#L34-L48)
- [ ] DEPOTS-005 — [séparation traitement/GUI] `EnregistreDepot`, `InitStockDepot`,
  `SupprimeDepot` sans contrôle · appelants : aucun · tests : T01-T03 · sources : [Depots.class:Button1_Click](../../../../../.src/Gestion/Depots/Depots.class#L220-L249), [Depots.class:Button3_Click](../../../../../.src/Gestion/Depots/Depots.class#L251-L273)
- [ ] DEPOTS-006 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`,
  `Cleanchamps`, `Code_GotFocus`, `ChkCp`, `Ref`, `Dbclk` → `Private` ; `Coldepot_Click` reste
  `Public` (rejeu) · appelants : aucun · tests : T01-T05 · sources : [Depots.class:Tris](../../../../../.src/Gestion/Depots/Depots.class#L69-L77), [Depots.class:Maj_Zones](../../../../../.src/Gestion/Depots/Depots.class#L98-L115), [Depots.class:Code_GotFocus](../../../../../.src/Gestion/Depots/Depots.class#L196-L200), [Depots.class:Ref](../../../../../.src/Gestion/Depots/Depots.class#L369-L376)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DEPOTS-A01 — [anomalie] Suppression : agit sur la ligne sélectionnée (pas le code saisi),
  sans transaction, erreurs masquées par `Catch` ; protection du magasin par `Left$(…, 2) = "01"`
  (tout code commençant par `01` est protégé) · tests : T03, T05 · sources : [Depots.class:257](../../../../../.src/Gestion/Depots/Depots.class#L257), [Depots.class:262](../../../../../.src/Gestion/Depots/Depots.class#L262), [Depots.class:271](../../../../../.src/Gestion/Depots/Depots.class#L271)
- [ ] DEPOTS-A02 — [anomalie] « Copier les produits du dépôt 01 » crée en fait une ligne à 0 pour
  **tous** les articles (stockés ou non) ; filtres `Deb2`/`Deb3` par concaténation · tests : T01,
  T04 · sources : [Depots.class:231](../../../../../.src/Gestion/Depots/Depots.class#L231), [Depots.class:81](../../../../../.src/Gestion/Depots/Depots.class#L81), [Depots.class:87](../../../../../.src/Gestion/Depots/Depots.class#L87)
- [ ] DEPOTS-A03 — [anomalie] `Cleanchamps` vide l'en-tête filtre `CP` au lieu de la zone `Cp2`
  (insensibilité à la casse) : le code postal reste affiché et l'en-tête disparaît · tests : T04 ·
  sources : [Depots.class:123](../../../../../.src/Gestion/Depots/Depots.class#L123)
