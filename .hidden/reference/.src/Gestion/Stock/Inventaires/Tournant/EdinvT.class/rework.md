# EdinvT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` · Message de commit (phase 4) : `.hidden/reference/.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 25 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 161 | 23 | 10 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDINVT-001 — [documentation] Commentaire d'en-tête signalant la classe comme inutilisée et
  remplacée par `Edinv("T")`, en attendant la décision sur EDINVT-A01 · appelants : aucun · tests : T01 ·
  sources : [EdinvT.class:_New](../../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class#L36-L59)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDINVT-A01 — [anomalie] Supprimer le couple `EdinvT.class` + `EdinvT.form` (aucun appelant,
  remplacé par `Edinv("T")`) · tests : T01, EDINV-T01..T07 · sources : [EdinvT.class:_New](../../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class#L36-L59), [EdinvT.class:Button1_Click](../../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class#L61-L142)
- [ ] EDINVT-A02 — [anomalie] `_New` : `dte.Text = rResult!inv_date` (l. 47) convertit implicitement la date en texte puis la découpe (l. 48-49) : la veille de la date d'inventaire s'affiche (2018-06-01 → « 31.05.2018 ») ; motif transverse « date convertie implicitement en texte (UTC, décalage horaire courant) puis découpée par `Left$`/`Mid$`/`Right$` → la veille s'affiche » : voir aussi [Ecarts](../../Fin-annee/Ecarts.class/rework.md), [EcartsT](../EcartsT.class/rework.md), [GeninvT](../GeninvT.class/rework.md), [SHA1CALC-A01](../../../../../Utils/Sha1Calc.module/rework.md) (phase 2, vague 9, 2026-11-18) · tests : CSTOCKS-T07b · sources : [EdinvT.class:47-49](../../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class#L47-L49)
