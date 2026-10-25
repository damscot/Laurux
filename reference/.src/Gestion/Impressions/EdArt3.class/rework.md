# EdArt3 — Rework

> Source : `.src/Gestion/Impressions/EdArt3.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdArt3.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 583 |
| Lignes de commentaire | 68 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 135 |
| Complexité max (fonction) | 30 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 583 | 135 | 30 | 0 | 27 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDART3-001 — [documentation] En-tête en français (tarif par type client, menu, fichier
  `Tarif1.pdf` partagé avec `EdArt1`, rôle de `Fiches_CoeffTypec`, écrasement du PV signalé par A01) ;
  commentaires sur `Quitte_Cdt` et `Button2_Click` · appelants : aucun · tests : aucun · sources : [EdArt3.class:Quitte_Cdt](../../../../../.src/Gestion/Impressions/EdArt3.class#L472-L498), [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)
- [ ] EDART3-002 — [code mort] Supprimer `Frmt`/`Coulfond`, `Nbpage`, `dte`, `PosX`, le
  `Shell "cd …"`, le `Case 1` inatteignable de `Btn_Click` · appelants : aucun · tests : T01, T08 ·
  sources : [EdArt3.class:_New](../../../../../.src/Gestion/Impressions/EdArt3.class#L42-L61), [EdArt3.class:652](../../../../../.src/Gestion/Impressions/EdArt3.class#L652), [EdArt3.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L508-L524)
- [ ] EDART3-003 — [commonalisation] Listes `ToggleButton3..6_Click` et `art_man` vers le socle
  `EdSelection` (voir EDART1-003/004, même commit) · appelants : aucun · tests : T08 · sources : [EdArt3.class:ToggleButton3_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L80-L112), [EdArt3.class:art_man](../../../../../.src/Gestion/Impressions/EdArt3.class#L352-L378)
- [ ] EDART3-004 — [complexité] Charger les coefficients du type client une seule fois
  (`Collection` famille → coeff) au lieu d'une requête par article ; **SQL modifié, dump et PDF
  identiques** · appelants : aucun · tests : T01, T02 · sources : [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)
- [ ] EDART3-005 — [séparation traitement/GUI] `Quitte_Cdt` → `TypeClientValide(code) As Integer`
  (SQL seul) + messages/focus dans l'appelant ; `Button2_Click` → `SelectArticles`/`LigneTarif`
  comme EDART1-005 · appelants : aucun · tests : T01, T05, T06 · sources : [EdArt3.class:Quitte_Cdt](../../../../../.src/Gestion/Impressions/EdArt3.class#L472-L498), [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)
- [ ] EDART3-006 — [commonalisation] Procédure commune `ImprimeTarif` avec `EdArt1` (EDART1-008,
  même commit) · appelants : aucun · tests : T01 à T04 · sources : [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763), [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696)
- [ ] EDART3-007 — [commonalisation] Lecture du coefficient par type client et famille partagée
  (`CoefTypeClient(typec, famille)`) avec `TarArt` et la liste des types avec `Edart4.Buttypc_Click`
  · appelants : aucun · tests : T01, T06, EDART4-T03 · sources : [EdArt3.class:ToggleButton7_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L431-L458), [Edart4.class:Buttypc_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L403-L424), [TarArt.class:_new](../../../../../.src/Utils/TarArt.class#L15-L145)
- [ ] EDART3-008 — [réduction de portée] `SelectionArt`, `art_man`, `Quitte_Cdt`, `Button2_Click` →
  `Private` · appelants : aucun · tests : T01, T05, T08 · sources : [EdArt3.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdArt3.class#L326-L347), [EdArt3.class:art_man](../../../../../.src/Gestion/Impressions/EdArt3.class#L352-L378), [EdArt3.class:Quitte_Cdt](../../../../../.src/Gestion/Impressions/EdArt3.class#L472-L498), [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDART3-A01 — [anomalie] Le PV HT calculé avec le coefficient du type client
  (`art_prvt × coeff`) est écrasé par `art_pvht` : le tarif « par type client » imprime le prix de
  base à côté du coefficient du type. **Impact métier** : tarif client faux · tests : T01 · sources : [EdArt3.class:695](../../../../../.src/Gestion/Impressions/EdArt3.class#L695), [EdArt3.class:697](../../../../../.src/Gestion/Impressions/EdArt3.class#L697)
- [ ] EDART3-A02 — [anomalie] Pages 2 et suivantes titrées « Impression du tarif interne » au lieu
  du titre « par type client » · tests : T02 · sources : [EdArt3.class:739](../../../../../.src/Gestion/Impressions/EdArt3.class#L739)
- [ ] EDART3-A03 — [anomalie] Un type client saisi sans Entrée n'est pas contrôlé avant impression
  (type inconnu → coefficients de base, libellé vide) · tests : T07 · sources : [EdArt3.class:648](../../../../../.src/Gestion/Impressions/EdArt3.class#L648), [EdArt3.class:cdt_KeyPress](../../../../../.src/Gestion/Impressions/EdArt3.class#L500-L506)
- [ ] EDART3-A04 — [anomalie] Défauts hérités d'`EdArt1` : contrôle du 2ᵉ article sur `Art.Text`
  (l. 552), `Bsel` jamais remis à faux, impression sur toute touche (`Btn_KeyPress`), focus/sélection
  incohérents dans `Colfam2`/`Colfour2` (l. 194-195, 318-319), pas de `Catch` · tests : T08 ·
  sources : [EdArt3.class:552](../../../../../.src/Gestion/Impressions/EdArt3.class#L552), [EdArt3.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdArt3.class#L326-L347), [EdArt3.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdArt3.class#L526-L533), [EdArt3.class:194](../../../../../.src/Gestion/Impressions/EdArt3.class#L194)
- [ ] EDART3-A05 — [anomalie] `Coltype` sans `Coltype_KeyPress` (Échap ne ferme pas la liste) et
  liste des types sans `ORDER BY` (ordre physique) · tests : T06 · sources : [EdArt3.class:ToggleButton7_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L431-L458)
- [ ] EDART3-A06 — [anomalie] Mode photo : un article dont la photo est renseignée mais illisible
  (`Image.Load` en échec) est **omis** du tarif (aucune ligne imprimée) · tests : T03 · sources : [EdArt3.class:713](../../../../../.src/Gestion/Impressions/EdArt3.class#L713)
