# Imp_Sig — Rework

> Source : `.src/Compta/Impressions/Imp_Sig.module` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Imp_Sig.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 403 |
| Lignes de commentaire | 66 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 61 |
| Complexité max (fonction) | 60 (`Lancement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 403 | 61 | 60 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMP_SIG-001 — [documentation] En-tête en français : rôle, blocs, table de travail, chaîne des
  soldes codée par numéro de rubrique (tableau d'architecture.md), paramètres sans effet ·
  appelants : aucun · tests : aucun · sources : [Imp_Sig.module:Lancement](../../../../../.src/Compta/Impressions/Imp_Sig.module#L39-L480)
- [ ] IMP_SIG-002 — [code mort] Supprimer `Button1_Click`, le bloc « type `O` » jamais exécuté
  (`RubE` reste `"0"`), la branche `Resultat = "Bénéfice"` (jamais affecté), `Shell "cd …"`, les
  variables inutilisées (`Tab2`, `Tab4`, `Tab6`, `RubO`, `cpt3`, `Ltot1`, `Etot2`, `Etot4`, `Stot*`,
  `Otot1`, `Ttot1`, `Imp3`, `Imp4`, `Brub`, `resexo`, `plusmoins`, `dtes1`, `dtes2`, `Nbpage`,
  `dateedition`) et les blocs commentés · appelants : aucun · tests : T01-T04 · sources : [Imp_Sig.module:Button1_Click](../../../../../.src/Compta/Impressions/Imp_Sig.module#L485-L489), [Imp_Sig.module:230-240](../../../../../.src/Compta/Impressions/Imp_Sig.module#L230-L240), [Imp_Sig.module:383-387](../../../../../.src/Compta/Impressions/Imp_Sig.module#L383-L387), [Imp_Sig.module:255](../../../../../.src/Compta/Impressions/Imp_Sig.module#L255)
- [ ] IMP_SIG-003 — [commonalisation] Choix des tables Mvt et en-tête société par les helpers de
  IMP_BILAN-003/004 (SQL identique) · appelants : aucun · tests : T01, T02 · sources : [Imp_Sig.module:109-134](../../../../../.src/Compta/Impressions/Imp_Sig.module#L109-L134)
- [ ] IMP_SIG-004 — [complexité] Impression pilotée par deux tables (rubriques de calcul de solde,
  rubriques d'impression d'un solde) et `Select Case`, expressions recopiées à l'identique (variables
  `String` conservées) ; CC 60 → ≤ 15 par procédure · appelants : aucun · tests : T01, T03, T04,
  T07 · sources : [Imp_Sig.module:286-446](../../../../../.src/Compta/Impressions/Imp_Sig.module#L286-L446)
- [ ] IMP_SIG-005 — [complexité] Découper `Lancement` en `CreeCentralisation`, `Centralise`,
  `Imprime` (même SQL, même ordre ; diff `Exec_SQL` bloquant) · appelants : aucun · tests : T01-T06 ·
  sources : [Imp_Sig.module:Lancement](../../../../../.src/Compta/Impressions/Imp_Sig.module#L39-L480)
- [ ] IMP_SIG-006 — [commonalisation] Noms de tables par `Cbase.Table` (`TabSoc`, `TabMvt*`,
  `TabRubriques`, `TabRubCompt`), SQL identique · appelants : `Cbase` · tests : T01 · sources : [Imp_Sig.module:103-132](../../../../../.src/Compta/Impressions/Imp_Sig.module#L103-L132)
- [ ] IMP_SIG-007 — [réduction de portée] Variables de module `pdf`, `PosY`, `PosYdeb`, `Filename`,
  `Ste`, `exo`, `Det` → locales ; `dtes1`, `dtes2`, `Nbpage`, `dateedition` supprimées (T05 doit
  rester vert) · appelants : aucun · tests : T05 · sources : [Imp_Sig.module:27-37](../../../../../.src/Compta/Impressions/Imp_Sig.module#L27-L37)
- [ ] IMP_SIG-008 — [séparation traitement/GUI] `Lancement` renvoie le chemin du PDF (ou `""`) ;
  message « Rien a imprimer » et visualiseur dans `RubImp` (avec IMP_BILAN-010) · appelants :
  `RubImp` · tests : T01, T06 · sources : [Imp_Sig.module:473-477](../../../../../.src/Compta/Impressions/Imp_Sig.module#L473-L477), [RubImp.class:591](../../../../../.src/Compta/Impressions/RubImp.class#L591)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMP_SIG-A01 — [anomalie] Les écritures sont lues sans filtre `validee = 1`, contrairement au
  bilan et au compte de résultat : les SIG incluent les écritures non validées · tests : T02 ·
  sources : [Imp_Sig.module:193](../../../../../.src/Compta/Impressions/Imp_Sig.module#L193)
- [ ] IMP_SIG-A02 — [anomalie] Compte `709` : `Otot3 = "-" & otot3` produit `--x` si le cumul est
  négatif → erreur de conversion (édition interrompue, à confirmer) ; utiliser `-otot3` comme pour
  `609` · tests : T03 · sources : [Imp_Sig.module:333](../../../../../.src/Compta/Impressions/Imp_Sig.module#L333), [Imp_Sig.module:347](../../../../../.src/Compta/Impressions/Imp_Sig.module#L347)
- [ ] IMP_SIG-A03 — [anomalie] La ligne de rubrique garde le **dernier** compte lu (`UPdate … WHERE
  numrub = &1`) : la règle de signe `709`/`609` dépend de l'ordre des écritures, pas de la
  composition de la rubrique · tests : T03 · sources : [Imp_Sig.module:204-210](../../../../../.src/Compta/Impressions/Imp_Sig.module#L204-L210)
- [ ] IMP_SIG-A04 — [anomalie] Résultat exceptionnel négatif non imprimé (branche commentée) ;
  `S0380` (résultat de l'exercice) et `S0410` (plus/moins-values) calculés mais jamais imprimés ·
  tests : T03 · sources : [Imp_Sig.module:310-316](../../../../../.src/Compta/Impressions/Imp_Sig.module#L310-L316), [Imp_Sig.module:394-401](../../../../../.src/Compta/Impressions/Imp_Sig.module#L394-L401)
- [ ] IMP_SIG-A05 — [anomalie] Chaîne des soldes codée en dur par numéro de rubrique (`S0060`,
  `S0105`, `S0130`, `S0150`…) : toute renumérotation du paramétrage (`Rubresult`) casse l'édition
  sans message · tests : T01 · sources : [Imp_Sig.module:288-320](../../../../../.src/Compta/Impressions/Imp_Sig.module#L288-L320), [Imp_Sig.module:364-401](../../../../../.src/Compta/Impressions/Imp_Sig.module#L364-L401)
- [ ] IMP_SIG-A06 — [anomalie] Table de travail `centralisation` recréée par `DROP`/`CREATE` sous un
  nom partagé avec six autres éditions (voir IMP_BILAN-A06) · tests : T01 · sources : [Imp_Sig.module:149-161](../../../../../.src/Compta/Impressions/Imp_Sig.module#L149-L161)
