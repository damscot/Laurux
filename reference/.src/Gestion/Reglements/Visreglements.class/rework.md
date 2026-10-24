# Visreglements — Rework

> Source : `.src/Gestion/Reglements/Visreglements.class` · Message de commit (phase 4) : `reference/.src/Gestion/Reglements/Visreglements.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 191 |
| Lignes de commentaire | 29 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 8 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 191 | 24 | 8 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Les étapes suivantes ne s'appliquent que si l'anomalie VISREGLEMENTS-A01 (suppression du couple
mort) est **refusée**.

- [ ] VISREGLEMENTS-001 — [documentation] Corriger l'en-tête (« Visualisation des règlements
  clients », et non « Facturation fin de mois ») et documenter les tables de travail · appelants :
  aucun · tests : aucun · sources : [Visreglements.class:21](../../../../../.src/Gestion/Reglements/Visreglements.class#L21), [Visreglements.class:24](../../../../../.src/Gestion/Reglements/Visreglements.class#L24)
- [ ] VISREGLEMENTS-002 — [code mort] Supprimer les lectures inutiles de `Form_Open` (`rResult`,
  `Coulfond`, `Frmt`), les membres `Tab5`/`rResult` et les arguments SQL superflus (`&2`, `&5`
  l. 127 ; `&2`, `&3` l. 167) · SQL modifié (un `SELECT` en moins), dump identique · appelants :
  aucun · tests : T02, T03 · sources : [Visreglements.class:Form_Open](../../../../../.src/Gestion/Reglements/Visreglements.class#L39-L82), [Visreglements.class:127](../../../../../.src/Gestion/Reglements/Visreglements.class#L127), [Visreglements.class:167](../../../../../.src/Gestion/Reglements/Visreglements.class#L167)
- [ ] VISREGLEMENTS-003 — [complexité] `Coldetail_Keypress` : remplacer la boucle qui répète le même
  `UPDATE … lettree = 0 WHERE numlot` par un seul `UPDATE` · SQL modifié, dump identique ·
  appelants : aucun · tests : T04 · sources : [Visreglements.class:Coldetail_Keypress](../../../../../.src/Gestion/Reglements/Visreglements.class#L186-L214)
- [ ] VISREGLEMENTS-004 — [commonalisation] `Calc_solde` → `Csolde.Solde_caisse` (même calcul ;
  `Csolde` utilise les noms de table en dur, identiques à `Cbase.Table`) · appelants : aucun ·
  tests : T05 · sources : [Visreglements.class:Calc_solde](../../../../../.src/Gestion/Reglements/Visreglements.class#L216-L241), [Csolde.module:Solde_caisse](../../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] VISREGLEMENTS-005 — [séparation traitement/GUI] Extraire `ChargeReglements()` et
  `SupprimeReglement(…)` sans accès aux contrôles · appelants : aucun · tests : T02 à T04 ·
  sources : [Visreglements.class:recup_bl](../../../../../.src/Gestion/Reglements/Visreglements.class#L87-L154), [Visreglements.class:Coldetail_Keypress](../../../../../.src/Gestion/Reglements/Visreglements.class#L186-L214)
- [ ] VISREGLEMENTS-006 — [réduction de portée] `recup_bl`, `Calc_solde` → `Private` (handlers
  inchangés, `Colbl_Click` reste `Public`) · appelants : aucun · tests : T02 à T05 · sources : [Visreglements.class:recup_bl](../../../../../.src/Gestion/Reglements/Visreglements.class#L87-L154), [Visreglements.class:Calc_solde](../../../../../.src/Gestion/Reglements/Visreglements.class#L216-L241)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISREGLEMENTS-A01 — [anomalie][code mort] Supprimer `Visreglements.class` et
  `Visreglements.form` (aucun point d'entrée : ni menu, ni `Prgm`, ni `New`). ⚠️ Supprimer un
  `.form` déroge au principe « `.form` intouchable » : **validation utilisateur requise** ; à
  décider avec `VISIMPAYES-A01` (clone mort) · appelants : aucun · tests : T01 · sources : [Visreglements.class:Form_Open](../../../../../.src/Gestion/Reglements/Visreglements.class#L39-L82), [Visreglements.class:recup_bl](../../../../../.src/Gestion/Reglements/Visreglements.class#L87-L154)
- [ ] VISREGLEMENTS-A02 — [anomalie] `Colbl_Click` écrit `Coldetail.Item[7]` alors que la grille
  n'a que 7 colonnes (0 à 6) : erreur d'indice probable ; la colonne `lind` utilisée par la
  suppression n'existe pas · tests : T03, T04 · sources : [Visreglements.class:64](../../../../../.src/Gestion/Reglements/Visreglements.class#L64), [Visreglements.class:178](../../../../../.src/Gestion/Reglements/Visreglements.class#L178)
- [ ] VISREGLEMENTS-A03 — [anomalie] La suppression d'un règlement efface **une seule ligne** de
  `Fiches_Mvt` (par `lind`) sans contrôle de validation/clôture ni suppression de la contrepartie
  de trésorerie (écriture déséquilibrée), délettre tout le lot et ne recalcule que le solde client ·
  tests : T04 · sources : [Visreglements.class:Coldetail_Keypress](../../../../../.src/Gestion/Reglements/Visreglements.class#L186-L214), [Visreglements.class:199](../../../../../.src/Gestion/Reglements/Visreglements.class#L199)
- [ ] VISREGLEMENTS-A04 — [anomalie] `recup_bl` détruit et recrée la table de travail `Facturefm`,
  aussi utilisée par `Facturefm`/`FacturefmA` (facturation de fin de mois) : collision si les deux
  écrans sont utilisés · tests : T02 · sources : [Visreglements.class:106](../../../../../.src/Gestion/Reglements/Visreglements.class#L106), [Facturefm.class:242](../../../../../.src/Gestion/Facturation/Facturefm.class#L242)
