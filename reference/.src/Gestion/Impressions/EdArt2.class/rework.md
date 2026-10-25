# EdArt2 — Rework

> Source : `.src/Gestion/Impressions/EdArt2.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdArt2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 489 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 112 |
| Complexité max (fonction) | 21 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 489 | 112 | 21 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDART2-001 — [documentation] En-tête signalant que l'écran n'est plus appelé (remplacé par
  `Edart4` au commit `29df3a6d`) et renvoyant à EDART2-A01 ; aucun autre rework tant qu'A01 n'est
  pas tranchée · appelants : aucun · tests : T01 · sources : [EdArt2.class:_New](../../../../../.src/Gestion/Impressions/EdArt2.class#L41-L57), [Fmenu.class:863](../../../../../.src/Communs/Fmenu.class#L863)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDART2-A01 — [anomalie] Supprimer le couple mort `EdArt2.class` + `EdArt2.form` (aucun
  appelant depuis `29df3a6d`) et, dans le lot Reports, les méthodes `Carticles.Level8`, `Level8bis`,
  `Level9`, `Level9bis`, `Ligne2` qui n'ont pas d'autre utilisateur · tests : T01 · sources : [EdArt2.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt2.class#L544-L651), [Fmenu.class:863](../../../../../.src/Communs/Fmenu.class#L863)
- [ ] EDART2-A02 — [anomalie] (si l'écran est conservé) tris 2 à 4 sans filtre fournisseur et
  4 `If` indépendants au lieu de `Else If` · tests : aucun (écran inaccessible) · sources : [EdArt2.class:587](../../../../../.src/Gestion/Impressions/EdArt2.class#L587), [EdArt2.class:590](../../../../../.src/Gestion/Impressions/EdArt2.class#L590), [EdArt2.class:593](../../../../../.src/Gestion/Impressions/EdArt2.class#L593)
- [ ] EDART2-A03 — [anomalie] (si l'écran est conservé) prix consommateur lu mais jamais imprimé,
  défauts hérités d'`EdArt1` (contrôle du 2ᵉ article, `Bsel`, impression sur toute touche, article
  omis si photo illisible) · tests : aucun · sources : [EdArt2.class:608](../../../../../.src/Gestion/Impressions/EdArt2.class#L608), [EdArt2.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdArt2.class#L322-L343), [EdArt2.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdArt2.class#L445-L452)
