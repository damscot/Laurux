# TresorFac — Rework

> Source : `.src/Gestion/Reglements/TresorFac.class` · Message de commit (phase 4) : `reference/.src/Gestion/Reglements/TresorFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1081 |
| Lignes de commentaire | 33 |
| Fonctions | 45 |
| Fonctions Public | 45 |
| Complexité cyclomatique totale | 225 |
| Complexité max (fonction) | 44 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1081 | 225 | 44 | 0 | 45 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Les étapes suivantes ne s'appliquent que si l'anomalie TRESORFAC-A01 (suppression du couple mort)
est **refusée**.

- [ ] TRESORFAC-001 — [documentation] Corriger l'en-tête (« Tresor.class » → `TresorFac`, saisie des
  règlements clients) et signaler la parenté avec `Tresor` · appelants : aucun · tests : aucun ·
  sources : [TresorFac.class:21](../../../../../.src/Gestion/Reglements/TresorFac.class#L21)
- [ ] TRESORFAC-002 — [code mort] Supprimer `ecritv`, `Journal_GotFocus`, `Numcompte_GotFocus`
  (handler inactif, contrôle groupé), `ToggleButton6_Click`, `Necrit_Click` et les branches Tag 1
  de `Cmpt_KeyPress`/`Btn_Click`, ainsi que les membres inutilisés (`Vld`, `Prov`, `Gntva`,
  `ecriture`, `dte2`, `numlet`, `Prg`, `n`, `Montantsel`) et `Montand`/`Montanc` de
  `Button2_Click` · appelants : aucun · tests : T02 · sources : [TresorFac.class:ecritv](../../../../../.src/Gestion/Reglements/TresorFac.class#L324-L367), [TresorFac.class:Journal_GotFocus](../../../../../.src/Gestion/Reglements/TresorFac.class#L556-L560), [TresorFac.class:Numcompte_GotFocus](../../../../../.src/Gestion/Reglements/TresorFac.class#L588-L592), [TresorFac.class:ToggleButton6_Click](../../../../../.src/Gestion/Reglements/TresorFac.class#L912-L918), [TresorFac.class:Necrit_Click](../../../../../.src/Gestion/Reglements/TresorFac.class#L1214-L1219), [TresorFac.class:460](../../../../../.src/Gestion/Reglements/TresorFac.class#L460)
- [ ] TRESORFAC-003 — [commonalisation] `Calc_solde` → `Csolde.Solde_caisse` (même calcul) ·
  appelants : aucun · tests : T02 · sources : [TresorFac.class:Calc_solde](../../../../../.src/Gestion/Reglements/TresorFac.class#L1266-L1291), [Csolde.module:Solde_caisse](../../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] TRESORFAC-004 — [réduction de portée] Fonctions internes et pseudo-handlers des groupes
  `Btn`/`Cmpt` → `Private` (liste `scope_reducible` vérifiée) ; handlers réels, `EcritL_Click` et
  `Ecrit3_Click` restent `Public` · appelants : aucun · tests : T02 · sources : [TresorFac.class:Movt](../../../../../.src/Gestion/Reglements/TresorFac.class#L126-L185), [TresorFac.class:QuitteDate](../../../../../.src/Gestion/Reglements/TresorFac.class#L648-L706), [TresorFac.class:Button2_Click](../../../../../.src/Gestion/Reglements/TresorFac.class#L791-L878)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRESORFAC-A01 — [anomalie][code mort] Supprimer `TresorFac.class` et `TresorFac.form` (aucun
  point d'entrée ; recherche de compte et rappel d'écriture non fonctionnels ; remplacé par
  `Tresor`). ⚠️ Supprimer un `.form` déroge au principe « `.form` intouchable » : **validation
  utilisateur requise** (signalé aussi par COMPTABILITE-A01) · appelants : aucun · tests : T01 ·
  sources : [TresorFac.class:_new](../../../../../.src/Gestion/Reglements/TresorFac.class#L62-L71), [TresorFac.class:compte](../../../../../.src/Gestion/Reglements/TresorFac.class#L187-L202)
- [ ] TRESORFAC-A02 — [anomalie] `compte` lit `Comptabilite.Bsel`/`sCmpt` que `TriCpt` n'écrit pas ;
  `TriCpt` écrit `Bsel`/`Bval` sur la fenêtre appelante, propriétés absentes de `TresorFac` (erreur
  probable à la sélection) · tests : aucun (non testable) · sources : [TresorFac.class:193](../../../../../.src/Gestion/Reglements/TresorFac.class#L193), [TriCpt.class:112](../../../../../.src/Affichages/TriCpt.class#L112)
- [ ] TRESORFAC-A03 — [anomalie] `Ecrit1` a 6 colonnes mais `ToggleButton4_Click`, `DelEcr` et
  `Ecrit3_Click` utilisent `Item[6]` à `Item[9]` ; l'erreur est masquée par le `Catch`
  (« écriture déjà saisie ») · tests : T02 · sources : [TresorFac.class:75](../../../../../.src/Gestion/Reglements/TresorFac.class#L75), [TresorFac.class:767](../../../../../.src/Gestion/Reglements/TresorFac.class#L767), [TresorFac.class:1003](../../../../../.src/Gestion/Reglements/TresorFac.class#L1003), [TresorFac.class:1087](../../../../../.src/Gestion/Reglements/TresorFac.class#L1087)
- [ ] TRESORFAC-A04 — [anomalie] `Btn_KeyPress` : toute touche sur `ToggleButton4` valide la ligne ;
  `Ecrit3_Click` l. 1065 : condition `<> 51 OR <> 53` toujours vraie ; `QuitteDate` numérote sans
  verrou · tests : T02 · sources : [TresorFac.class:Btn_KeyPress](../../../../../.src/Gestion/Reglements/TresorFac.class#L484-L495), [TresorFac.class:1065](../../../../../.src/Gestion/Reglements/TresorFac.class#L1065), [TresorFac.class:QuitteDate](../../../../../.src/Gestion/Reglements/TresorFac.class#L648-L706)
- [ ] TRESORFAC-A05 — [anomalie] (signal `sql_params`, ajouté après le lot Gestion-2) l. 159 :
  l'`UPDATE` passe 14 arguments mais utilise `&1`…`&{15}` sans `&7` : `numdoc` n'est pas mis à jour
  et `Cloturee = &{15}` reçoit une valeur absente. Sans effet tant que la classe est morte
  (TRESORFAC-A01) · tests : T02 · sources : [TresorFac.class:159](../../../../../.src/Gestion/Reglements/TresorFac.class#L159)
