# Cstock — Rework

> Source : `.src/Utils/Cstock.module` · Message de commit (phase 4) : `reference/.src/Utils/Cstock.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 108 |
| Lignes de commentaire | 30 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 13 (`Calc_stock`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 108 | 16 | 13 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CSTOCK-001 — [documentation] En-tête : formule du stock (sources, signes, date de départ,
  inventaire tournant), tables verrouillées, contrat des paramètres `Art`/`art2` · appelants :
  aucun · tests : aucun · sources : [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134)
- [ ] CSTOCK-002 — [code mort] Supprimer `com_art`, la locale `dte3` et la variable de module `dte3`,
  le bloc commenté des historiques de caisse et `With Utils` ; le `DISTINCT` est conservé (SQL
  identique dans le log) · tests : T01-T08 · sources : [Cstock.module:Calc_stock](../../../../.src/Utils/Cstock.module#L11-L134), [Cstock.module:5](../../../../.src/Utils/Cstock.module#L5), [Cstock.module:109-120](../../../../.src/Utils/Cstock.module#L109-L120)
- [ ] CSTOCK-003 — [séparation traitement/GUI] Paramètre `Optional Mode As Integer` remplaçant la
  lecture de `Calcstock.Cbx/Cbx2` ; `Calcstock` passe le mode du bouton coché, `Validinv` passe le
  mode « article » (comportement actuel conservé) · appelants : `Calcstock.class:84,88,94`,
  `Validinv.class:190` · tests : T01-T03, T09, T10, CALCSTOCK-T01..T04 · sources : [Cstock.module:28-38](../../../../.src/Utils/Cstock.module#L28-L38), [Calcstock.class:Button2_Click](../../../../.src/Utils/Calcstock.class#L50-L111), [Validinv.class:190](../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L190)
- [ ] CSTOCK-004 — [complexité] Extraire `StockArticle(code, txconv, qteDepart, dteDepart) As Float`
  (requête `UNION ALL` + cumul), appelée dans la boucle ; `dte2` reste la variable de module
  modifiée comme aujourd'hui · tests : T01, T04-T08 · sources : [Cstock.module:54-106](../../../../.src/Utils/Cstock.module#L54-L106)
- [ ] CSTOCK-005 — [séparation traitement/GUI] `date_ex` renvoie un booléen d'erreur, le
  `Message.Error` est fait par `Calc_stock` (même texte) · tests : T07 · sources : [Cstock.module:date_ex](../../../../.src/Utils/Cstock.module#L139-L152)
- [ ] CSTOCK-006 — [réarchitecture] `Cbase.Table(...)` pour les tables en dur de la requête et de
  `date_ex` (noms physiques identiques) · tests : T01, T04 · sources : [Cstock.module:54-100](../../../../.src/Utils/Cstock.module#L54-L100), [Cstock.module:date_ex](../../../../.src/Utils/Cstock.module#L139-L152)
- [ ] CSTOCK-007 — [réduction de portée] `date_ex` → `Private` · appelants : aucun · tests : T07 · sources : [Cstock.module:date_ex](../../../../.src/Utils/Cstock.module#L139-L152)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CSTOCK-A01 — [anomalie] Appel depuis `Validinv:190` : `Calcstock.Cbx` vaut `True` par défaut
  sur l'instance automatique → requête `art_code = ''`, **aucun recalcul** après validation
  d'inventaire ; les mouvements postérieurs à la date d'inventaire ne sont pas réappliqués à
  `art_qte` · tests : T09 · sources : [Cstock.module:28](../../../../.src/Utils/Cstock.module#L28), [Validinv.class:190](../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L190)
- [ ] CSTOCK-A02 — [anomalie] `dte2` (variable de module) est modifiée par l'inventaire tournant d'un
  article et sert de borne à la recherche de l'article suivant : stock faux pour un article dont le
  dernier inventaire tournant est antérieur à celui de l'article précédent · tests : T05, T06 · sources : [Cstock.module:46-52](../../../../.src/Utils/Cstock.module#L46-L52)
- [ ] CSTOCK-A03 — [anomalie] `Art` non vide sans mode coché → `ArtResult` nul, erreur non
  interceptée ; toute erreur SQL dans la boucle laisse les tables verrouillées · tests : T10 · sources : [Cstock.module:34-39](../../../../.src/Utils/Cstock.module#L34-L39), [Cstock.module:130](../../../../.src/Utils/Cstock.module#L130)
- [ ] CSTOCK-A04 — [anomalie] SQLite : `UNION ALL(SELECT …)` refusé et comparaison de dates
  `'AAAA-MM-JJ' >= 'AAAAMMJJ'` fausse : recalcul inopérant en mode portable · tests : T11 · sources : [Cstock.module:61](../../../../.src/Utils/Cstock.module#L61), [Cstock.module:100](../../../../.src/Utils/Cstock.module#L100)
- [ ] CSTOCK-A05 — [anomalie] `art_txconv` Null → réceptions ignorées (multiplication par `NULL`) ;
  dépôt `'01'` codé en dur pour `Fiches_Sdepots` (à confirmer avec l'utilisateur) · tests : T04, T08 · sources : [Cstock.module:80](../../../../.src/Utils/Cstock.module#L80), [Cstock.module:99](../../../../.src/Utils/Cstock.module#L99)
