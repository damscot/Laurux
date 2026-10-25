# CLcr — Rework

> Source : `.src/Gestion/Lcr/CLcr.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/CLcr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 179 |
| Lignes de commentaire | 11 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 10 (`Level2A`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 179 | 27 | 10 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CLCR-001 — [documentation] En-tête de classe en français (gabarit PDF des états LCR, tableau
  famille de niveaux → écran appelant, unités mm, seuil de saut de page géré par l'appelant) et
  commentaires `'''` sur chaque méthode publique · appelants : aucun · tests : T01-T06 ·
  sources : [CLcr.class:Entete](../../../../../.src/Gestion/Lcr/CLcr.class#L20-L28), [CLcr.class:Level1B](../../../../../.src/Gestion/Lcr/CLcr.class#L143-L172)
- [ ] CLCR-002 — [code mort] Supprimer `Level0`, `Level5A` (aucun appelant) et `_free` (vide) ·
  appelants : aucun · tests : T01-T04 · sources : [CLcr.class:Level0](../../../../../.src/Gestion/Lcr/CLcr.class#L40-L46), [CLcr.class:Level5A](../../../../../.src/Gestion/Lcr/CLcr.class#L221-L235),
  [CLcr.class:_free](../../../../../.src/Gestion/Lcr/CLcr.class#L16-L18)
- [ ] CLCR-003 — [commonalisation] Helper privé de ligne LCR utilisé par `Level1`/`Level1A` et
  `Level2`/`Level2A`, et helper `Adresse(…)` ; signatures publiques et positions inchangées (PDF
  identique) · appelants : aucun · tests : T02, T03 · sources : [CLcr.class:Level1](../../../../../.src/Gestion/Lcr/CLcr.class#L49-L64),
  [CLcr.class:Level2](../../../../../.src/Gestion/Lcr/CLcr.class#L67-L93), [CLcr.class:Level1A](../../../../../.src/Gestion/Lcr/CLcr.class#L96-L112), [CLcr.class:Level2A](../../../../../.src/Gestion/Lcr/CLcr.class#L115-L140)
- [ ] CLCR-004 — [complexité] `Lines(PosY As String)` → `Lines(PosY As Integer)` et suppression du
  `SetXY(7, PosY)` sans effet · appelants : `Lcr`, `Attribution`, `Preparation`, `Bordrx` (appels
  inchangés, entiers déjà passés) · tests : T06 · sources : [CLcr.class:Lines](../../../../../.src/Gestion/Lcr/CLcr.class#L238-L244)
- [ ] CLCR-005 — [commonalisation] (phase 3, lot Reports) Dériver `CLcr` d'une base commune des
  gabarits PDF (`Entete` paramétré, `BasPage` identique à `Ccompta.BasPage`) ; rendu identique ·
  appelants : aucun · tests : T01 · sources : [CLcr.class:BasPage](../../../../../.src/Gestion/Lcr/CLcr.class#L31-L38), [Ccompta.class:BasPage](../../../../../.src/Reports/Ccompta.class#L31-L38)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CLCR-A01 — [anomalie] `Level2`/`Level2A` formatent le montant par `Val(smontant)` sans
  `Utils.cpoint` : en locale française, un montant stocké avec un point (`"12.50"`) donne `Null`
  puis une erreur ou un montant vide ; `Level4B`/`Level5A` utilisent `cpoint`. Aligner sur
  `Val(Utils.cpoint(…))` (à confirmer selon le format réellement stocké dans `Fiches_Lcr.montant`) ·
  appelants : `Lcr`, `Attribution`, `Preparation`, `Glcr` · tests : T05 · sources : [CLcr.class:77](../../../../../.src/Gestion/Lcr/CLcr.class#L77),
  [CLcr.class:125](../../../../../.src/Gestion/Lcr/CLcr.class#L125)
- [ ] CLCR-A02 — [anomalie] `Level4B` imprime « Date de remise : » = date du jour, et non la date
  de remise du bordereau (`Fiches_Bordereaux.dateremise`) : une réimpression d'un ancien bordereau
  porte une date fausse. Correction : paramètre supplémentaire passé par `Bordrx.Gen_Bordereau` ·
  appelants : `Bordrx` · tests : T04 · sources : [CLcr.class:216](../../../../../.src/Gestion/Lcr/CLcr.class#L216), [Bordrx.class:375](../../../../../.src/Gestion/Lcr/Bordrx.class#L375)
