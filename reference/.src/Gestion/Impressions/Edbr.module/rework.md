# Edbr — Rework

> Source : `.src/Gestion/Impressions/Edbr.module` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edbr.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 228 |
| Lignes de commentaire | 14 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 19 (`Ed`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 228 | 37 | 19 | 1 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDBR-001 — [documentation] En-tête : deux contextes d'appel (`Edbl`, `ValidBR`), format de
  `Nbls`, état de module et rôle d'`Init`, dépendance à `Totalisation`, archivage GED · appelants :
  aucun · tests : aucun · sources : [Edbr.module:Init](../../../../../.src/Gestion/Impressions/Edbr.module#L13-L18), [Edbr.module:Ed](../../../../../.src/Gestion/Impressions/Edbr.module#L111-L256)
- [ ] EDBR-002 — [code mort] Supprimer la variable `Public Cdocuments As String` (jamais lue,
  homonyme de la classe), `son` (jamais affectée : le `Music.Play` n'est jamais exécuté), la branche
  `Valcom` (aucun appelant), `Shell "cd …"`, les locales inutiles et le code commenté ; la création
  de `~/BR` (répertoire jamais utilisé) est retirée seulement après accord (effet de bord sur le
  disque) · appelants : aucun · tests : T01-T07 · sources : [Edbr.module:9](../../../../../.src/Gestion/Impressions/Edbr.module#L9), [Edbr.module:11](../../../../../.src/Gestion/Impressions/Edbr.module#L11), [Edbr.module:141](../../../../../.src/Gestion/Impressions/Edbr.module#L141), [Edbr.module:150](../../../../../.src/Gestion/Impressions/Edbr.module#L150), [Edbr.module:177](../../../../../.src/Gestion/Impressions/Edbr.module#L177)
- [ ] EDBR-003 — [réduction de portée] `Calc_tva` → `Private` (appelé seulement par `Ed`) ·
  appelants : aucun · tests : T03, T05, T06 · sources : [Edbr.module:Calc_tva](../../../../../.src/Gestion/Impressions/Edbr.module#L23-L109)
- [ ] EDBR-004 — [commonalisation] Archivage GED par `LGed.Archive(…)` (après LGED-007), séquence
  et documents produits identiques · appelants : aucun · tests : T02, T03 · sources : [Edbr.module:228](../../../../../.src/Gestion/Impressions/Edbr.module#L228), [LGed.class:PDFDupli](../../../../../.src/Utils/LGed.class#L990-L1009)
- [ ] EDBR-005 — [complexité] Requête `tag_def` paramétrée (`fo_code = &1` au lieu de la
  concaténation ; `fo_code` entier : résultat identique) et `Cbase.Table` pour `TabTvav`,
  `Totalisation`, `TabLigrecpt`, `TabFour` (SQL identique) · appelants : aucun · tests : T01-T03 ·
  sources : [Edbr.module:247](../../../../../.src/Gestion/Impressions/Edbr.module#L247), [Edbr.module:52](../../../../../.src/Gestion/Impressions/Edbr.module#L52), [Edbr.module:160](../../../../../.src/Gestion/Impressions/Edbr.module#L160)
- [ ] EDBR-006 — [séparation traitement/GUI] `TotauxTva() As Collection` (lecture `Fiches_Tvaav` /
  `Totalisation`, cumul) séparé de l'impression dans `Calc_tva` · appelants : aucun · tests : T03,
  T05, T06 · sources : [Edbr.module:Calc_tva](../../../../../.src/Gestion/Impressions/Edbr.module#L23-L109)
- [ ] EDBR-007 — [complexité] `Ed` (CC 19) : extraire `ImprimeBon(pdf, nbl, codef)` et
  `ArchiveGed(…)`, sortie PDF identique · appelants : `Edbl`, `ValidBR` (signature d'`Ed`
  inchangée) · tests : T01-T04, T07 · sources : [Edbr.module:Ed](../../../../../.src/Gestion/Impressions/Edbr.module#L111-L256)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDBR-A01 — [anomalie] Validation de plusieurs BR (`ValidBR`) : l'archivage GED utilise `nbl`
  et `Totalbl` du **dernier** BR de la boucle (un seul document GED, numéro et HT du dernier BR,
  pour un PDF qui les contient tous) · tests : T03 · sources : [Edbr.module:230](../../../../../.src/Gestion/Impressions/Edbr.module#L230), [Edbr.module:236](../../../../../.src/Gestion/Impressions/Edbr.module#L236), [ValidBR.class:693](../../../../../.src/Gestion/Stock/ValidBR.class#L693)
- [ ] EDBR-A02 — [anomalie] En-tête des pages suivantes : `Level1br` reçoit `dater` (date de
  validation ou texte transmis par `Edbl`) au lieu de la date de réception de la première page ·
  tests : T04 · sources : [Edbr.module:173](../../../../../.src/Gestion/Impressions/Edbr.module#L173), [Edbr.module:200](../../../../../.src/Gestion/Impressions/Edbr.module#L200)
- [ ] EDBR-A03 — [anomalie] `son` déclaré `String` et jamais affecté : le signal sonore du message
  « Aucun mouvement » n'est jamais joué, contrairement aux autres éditions (`Start.Son`) · tests :
  T07 · sources : [Edbr.module:9](../../../../../.src/Gestion/Impressions/Edbr.module#L9), [Edbr.module:208](../../../../../.src/Gestion/Impressions/Edbr.module#L208)
- [ ] EDBR-A04 — [anomalie] BR sans ligne : l'en-tête de page est émis avant la requête, le PDF
  contient une page vide en plus du message · tests : T07 · sources : [Edbr.module:158](../../../../../.src/Gestion/Impressions/Edbr.module#L158), [Edbr.module:211](../../../../../.src/Gestion/Impressions/Edbr.module#L211)
