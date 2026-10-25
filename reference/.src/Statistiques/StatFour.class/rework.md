# StatFour — Rework

> Source : `.src/Statistiques/StatFour.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatFour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 34 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 40 |
| Complexité max (fonction) | 17 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 166 | 40 | 17 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATFOUR-001 — [documentation] En-tête en français : statistique d'**achats**
  (réceptions), structure de `Total` partagée avec `VisStatFour`, calcul N-1 · appelants : aucun
  · tests : T01-T05 · sources : [StatFour.class:Traitement](../../../../.src/Statistiques/StatFour.class#L156-L236)
- [ ] STATFOUR-002 — [code mort] Supprimer la branche `INSERT` inatteignable (3 colonnes,
  2 valeurs), `Tot`, `Frmt`, les `If son Then` vides, `montant1 = Montant1 + 0` · appelants :
  aucun · tests : T01-T05 · sources : [StatFour.class:210](../../../../.src/Statistiques/StatFour.class#L210), [StatFour.class:204](../../../../.src/Statistiques/StatFour.class#L204), [StatFour.class:DteN1_LF](../../../../.src/Statistiques/StatFour.class#L134-L154), [StatFour.class:_New](../../../../.src/Statistiques/StatFour.class#L35-L53)
- [ ] STATFOUR-003 — [complexité] Noms de tables en dur → `Cbase.Table("TabEntrecpt"/"TabFour"/
  "TabParam")` ; test de saisie des dates simplifié (même valeur) · appelants : aucun · tests :
  T01, T05 · sources : [StatFour.class:Traitement](../../../../.src/Statistiques/StatFour.class#L156-L236), [StatFour.class:181](../../../../.src/Statistiques/StatFour.class#L181)
- [ ] STATFOUR-004 — [réduction de portée] `DateN1`, `DteN0_LF`, `DteN1_LF`, `Traitement` →
  `Private` · appelants : aucun · tests : T01, T05 · sources : [StatFour.class:DateN1](../../../../.src/Statistiques/StatFour.class#L78-L85), [StatFour.class:DteN0_LF](../../../../.src/Statistiques/StatFour.class#L115-L129), [StatFour.class:DteN1_LF](../../../../.src/Statistiques/StatFour.class#L134-L154), [StatFour.class:Traitement](../../../../.src/Statistiques/StatFour.class#L156-L236)
- [ ] STATFOUR-005 — [commonalisation] Déléguer dates (`PeriodeN1`, `DateSaisie`,
  `PeriodeInversee`) et `TotalCree` à `StatCommun.module` (STATCOMM-005), en gardant `Balloon`
  et le format `dd/mm/yyyy` du repli dans le handler · appelants : aucun · tests : T01-T06 · sources : [StatFour.class:DateN1](../../../../.src/Statistiques/StatFour.class#L78-L85), [StatFour.class:DteN0_LF](../../../../.src/Statistiques/StatFour.class#L115-L129), [StatFour.class:174](../../../../.src/Statistiques/StatFour.class#L174)
- [ ] STATFOUR-006 — [séparation traitement/GUI] Extraire `CalculTotal(sDeb, sFin, sDebN1,
  sFinN1)` sans contrôles · appelants : aucun · tests : T01-T04, T07 · sources : [StatFour.class:Traitement](../../../../.src/Statistiques/StatFour.class#L156-L236)
- [ ] STATFOUR-007 — [complexité] Cumul en mémoire puis `INSERT` (SQL modifié, dump identique),
  **après** STATFOUR-A01 · appelants : aucun · tests : T01-T03, T07 · sources : [StatFour.class:Traitement](../../../../.src/Statistiques/StatFour.class#L156-L236)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATFOUR-A01 — [anomalie] Le N-1 est recalculé et ajouté pour **chaque réception N** du
  fournisseur : `montant1` multiplié par le nombre de réceptions N ; fournisseurs sans réception
  N absents · tests : T02 · sources : [StatFour.class:196](../../../../.src/Statistiques/StatFour.class#L196), [StatFour.class:208](../../../../.src/Statistiques/StatFour.class#L208)
- [ ] STATFOUR-A02 — [anomalie] Date de repli formatée `"dd/mm/yyyy"` au lieu de `"dd.mm.yyyy"`
  dans `DteN0_LF`/`DteN1_LF` (incohérent avec `Cdate_Dbase` ; branche probablement inatteignable,
  à confirmer) · tests : T05 · sources : [StatFour.class:121](../../../../.src/Statistiques/StatFour.class#L121), [StatFour.class:140](../../../../.src/Statistiques/StatFour.class#L140)
- [ ] STATFOUR-A03 — [anomalie] `Nmfour` non réinitialisé : un fournisseur absent de
  `Fiches_Four` reçoit le nom du fournisseur précédent · tests : T03 · sources : [StatFour.class:192](../../../../.src/Statistiques/StatFour.class#L192)
- [ ] STATFOUR-A04 — [anomalie] Réceptions non validées (`validee = 0`) comptées et `montant` NULL
  non protégé (erreur de type probable) : périmètre à confirmer avec l'utilisateur · tests : T04 · sources : [StatFour.class:182](../../../../.src/Statistiques/StatFour.class#L182), [StatFour.class:185](../../../../.src/Statistiques/StatFour.class#L185)
- [ ] STATFOUR-A05 — [anomalie] Table de travail `Total` partagée entre postes et écrans de
  structures différentes (= STATCOMM-A05, STATCAI-A04) · tests : T01 · sources : [StatFour.class:174](../../../../.src/Statistiques/StatFour.class#L174), [StatFour.class:175](../../../../.src/Statistiques/StatFour.class#L175)
