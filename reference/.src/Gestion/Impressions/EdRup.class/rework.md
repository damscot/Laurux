# EdRup — Rework

> Source : `.src/Gestion/Impressions/EdRup.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdRup.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 503 |
| Lignes de commentaire | 46 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 73 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 503 | 122 | 73 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDRUP-001 — [documentation] En-tête en français : rôle, 3 sections, dépendance à
  `Crupt.Rupture`, tables de travail `Rupture`/`RuptureC` (partagées avec `Changefam`), options
  mémorisées · appelants : aucun · tests : aucun · sources : [EdRup.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdRup.class#L289-L613), [Crupt.module:Rupture](../../../../../.src/Utils/Crupt.module#L6-L332)
- [ ] EDRUP-002 — [code mort] Supprimer `Frmt`/`Coulfond`, `Tabl`, `Nbpage`, `dte`, `Decm`, `Fourn2`,
  `PosX`, le `Shell "cd …"`, la branche `Else` vide, les `'Wait` commentés et le `Case 1`
  inatteignable de `Btn_Click` · appelants : aucun · tests : T01, T03 · sources : [EdRup.class:_New](../../../../../.src/Gestion/Impressions/EdRup.class#L42-L60), [EdRup.class:321](../../../../../.src/Gestion/Impressions/EdRup.class#L321), [EdRup.class:437](../../../../../.src/Gestion/Impressions/EdRup.class#L437), [EdRup.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdRup.class#L184-L203)
- [ ] EDRUP-003 — [complexité] Découper `Button2_Click` (CC 73) en `ImprimeRuptures`,
  `ImprimeCommandesClients`, `ImprimeVentes`, `SautDePage`, ordre des requêtes et des appels
  PdfWriter inchangé · appelants : aucun · tests : T01 à T06, T09 · sources : [EdRup.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdRup.class#L289-L613)
- [ ] EDRUP-004 — [commonalisation] Constantes de tables de travail partagées avec `Crupt` et
  `Changefam` (CRUPT-004, même commit) · appelants : `Crupt`, `Changefam` · tests : T01, T03 · sources : [EdRup.class:319](../../../../../.src/Gestion/Impressions/EdRup.class#L319), [Crupt.module:21](../../../../../.src/Utils/Crupt.module#L21), [Changefam.class:541](../../../../../.src/Utils/Changefam.class#L541)
- [ ] EDRUP-005 — [séparation traitement/GUI] Extraire `QuantiteACommander(rarts, bNonStockes)` et
  la décision d'impression (calcul pur), et les lectures SQL des 3 sections dans des fonctions sans
  contrôles · appelants : aucun · tests : T01, T02, T10 · sources : [EdRup.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdRup.class#L289-L613)
- [ ] EDRUP-006 — [commonalisation] `art_man`, `SelectionArt` vers le socle `EdSelection`
  (EDART1-004) · appelants : aucun · tests : T01 · sources : [EdRup.class:art_man](../../../../../.src/Gestion/Impressions/EdRup.class#L156-L182), [EdRup.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdRup.class#L130-L151)
- [ ] EDRUP-007 — [réduction de portée] `fourman`, `SelectionArt`, `art_man`, `Button2_Click` →
  `Private` · appelants : aucun · tests : T01, T07 · sources : [EdRup.class:fourman](../../../../../.src/Gestion/Impressions/EdRup.class#L115-L127), [EdRup.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdRup.class#L130-L151), [EdRup.class:art_man](../../../../../.src/Gestion/Impressions/EdRup.class#L156-L182), [EdRup.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdRup.class#L289-L613)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDRUP-A01 — [anomalie] `SELECT`/`UPdate RuptureC` avec `codec`, `intitulea`, `numcom` jamais
  affectés : la mise à jour de `qtecom` est sans effet (supprimer ou corriger change le SQL et
  peut changer `RuptureC`) · tests : T03 · sources : [EdRup.class:430](../../../../../.src/Gestion/Impressions/EdRup.class#L430), [EdRup.class:432](../../../../../.src/Gestion/Impressions/EdRup.class#L432)
- [ ] EDRUP-A02 — [anomalie] `fourman` : le message « fournisseur inexistant » est dans le `Catch`,
  donc jamais affiché pour un code inconnu · tests : T07 · sources : [EdRup.class:fourman](../../../../../.src/Gestion/Impressions/EdRup.class#L115-L127)
- [ ] EDRUP-A03 — [anomalie] Section ventes : colonne `date` ambiguë (présente dans
  `Fiches_HisLigTickets` et `Fiches_HisEntTickets`) et `SELECT *` avec `GROUP BY` partiel : erreur
  SQL probable, sans `Catch` (curseur bloqué) · tests : T05 · sources : [EdRup.class:542](../../../../../.src/Gestion/Impressions/EdRup.class#L542)
- [ ] EDRUP-A04 — [anomalie] Titre des pages de ventes incohérent (« sur les N derniers jours » /
  « sur les derniers N jours ») et première page vide si seule la section ventes a des lignes ·
  tests : T05 · sources : [EdRup.class:532](../../../../../.src/Gestion/Impressions/EdRup.class#L532), [EdRup.class:589](../../../../../.src/Gestion/Impressions/EdRup.class#L589), [EdRup.class:326](../../../../../.src/Gestion/Impressions/EdRup.class#L326)
- [ ] EDRUP-A05 — [anomalie] `Jours` porte le tag 3 comme `Four` (Entrée → focus `Four2`) ; tag 2
  (`Art2`) contrôle `Art.Text` ; `Bsel` jamais remis à faux ; impression sur toute touche ·
  tests : T07 · sources : [EdRup.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/EdRup.class#L214-L276), [EdRup.class:231](../../../../../.src/Gestion/Impressions/EdRup.class#L231), [EdRup.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdRup.class#L205-L212)
- [ ] EDRUP-A06 — [anomalie] Tables de travail globales `Rupture`/`RuptureC` : deux impressions
  simultanées s'écrasent (même défaut que CRUPT-A05 ; correction = changement de schéma) · tests :
  aucun · sources : [EdRup.class:335](../../../../../.src/Gestion/Impressions/EdRup.class#L335)
