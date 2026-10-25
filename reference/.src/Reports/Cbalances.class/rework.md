# Cbalances — Rework

> Source : `.src/Reports/Cbalances.class` · Message de commit (phase 4) : `reference/.src/Reports/Cbalances.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 263 |
| Lignes de commentaire | 26 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 5 (`Level2a`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 263 | 44 | 5 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CBALANCES-001 — [documentation] En-tête de classe en français : gabarit des balances et de
  l'état de TVA, tableau famille de niveaux → appelant (`BalanceM`, `FTVA`), `PosY` et pages gérés
  par l'appelant ; commentaire `'''` par méthode · appelants : aucun · tests : T01-T04 · sources : [Cbalances.class:_new](../../../../.src/Reports/Cbalances.class#L8-L14), [Cbalances.class:Level1](../../../../.src/Reports/Cbalances.class#L49-L73)
- [ ] CBALANCES-002 — [code mort] Supprimer `Level2s`, `Level2sbis` (aucun appelant, vérifié par
  grep) et `_free` (vide) · appelants : aucun · tests : T01-T03 · sources : [Cbalances.class:Level2s](../../../../.src/Reports/Cbalances.class#L176-L199), [Cbalances.class:Level2sbis](../../../../.src/Reports/Cbalances.class#L201-L206), [Cbalances.class:_free](../../../../.src/Reports/Cbalances.class#L16-L18)
- [ ] CBALANCES-003 — [complexité] `Level3` : supprimer le `SetXY`/`SetFont(…, 7)` immédiatement
  écrasés ; `Level5T` : supprimer le `If` à branches identiques (texte PDF identique, octets
  différents pour `Level3`) · appelants : aucun · tests : T01, T03, T05, T06 · sources : [Cbalances.class:99](../../../../.src/Reports/Cbalances.class#L99), [Cbalances.class:Level5T](../../../../.src/Reports/Cbalances.class#L349-L370)
- [ ] CBALANCES-004 — [séparation traitement/GUI] Fonction privée `SoldeDebitCredit(deb, cred) As
  String` (calcul `Val(Utils.cpoint(…))` + `Format$`) et helper `MontantVide(s)` (`Null`/`"0"` →
  `""`) utilisés par `Level2a`, `Level3a`, `Level4a`, `Level2T` ; rendu identique · appelants :
  aucun · tests : T02, T03 · sources : [Cbalances.class:Level2a](../../../../.src/Reports/Cbalances.class#L155-L173), [Cbalances.class:Level3a](../../../../.src/Reports/Cbalances.class#L209-L227), [Cbalances.class:Level4a](../../../../.src/Reports/Cbalances.class#L229-L246), [Cbalances.class:Level2T](../../../../.src/Reports/Cbalances.class#L281-L300)
- [ ] CBALANCES-005 — [commonalisation] (phase 3) Dériver de la base commune `PdfLaurux` : `_new`,
  `Entete` (= `TitrePage` standard) et `BasPage` deviennent des délégations ; PDF identique ·
  appelants : aucun · tests : T01, T04 · sources : [Cbalances.class:Entete](../../../../.src/Reports/Cbalances.class#L20-L28), [Cbalances.class:BasPage](../../../../.src/Reports/Cbalances.class#L31-L38), [Ccompta.class:BasPage](../../../../.src/Reports/Ccompta.class#L31-L38)
- [ ] CBALANCES-006 — [code mort] Supprimer les paramètres inutilisés `totd`, `totc` de
  `Level5T` · appelants : `FTVA:716`, `FTVA:718` (même commit) · tests : T03, T06 · sources : [Cbalances.class:Level5T](../../../../.src/Reports/Cbalances.class#L349-L370), [FTVA.class:716](../../../../.src/Compta/Impressions/FTVA.class#L716)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune anomalie relevée : le rendu est cohérent avec les appelants (les écarts de calcul de la
balance sont documentés dans [BalanceM](../../Compta/Impressions/BalanceM.module/rework.md)).
