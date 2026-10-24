# EditcompteA — Rework

> Source : `.src/Compta/Impressions/EditcompteA.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EditcompteA.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 695 |
| Lignes de commentaire | 106 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 114 |
| Complexité max (fonction) | 19 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 695 | 114 | 19 | 0 | 35 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITCOMPTEA-001 — [documentation] En-tête en français : extrait de comptes **analytiques**
  (et non archive), tables lues (`Fiches_Analytiques`, `Fiches_MvtA`), table de travail `Ctrlnc`,
  parenté avec `Editcompte` · appelants : aucun · tests : aucun · sources : [EditcompteA.class:_New](../../../../../.src/Compta/Impressions/EditcompteA.class#L60-L85)
- [ ] EDITCOMPTEA-002 — [code mort] Supprimer `Button2_Click` (aucun contrôle « Exporter » dans le
  `.form`) et le `Case 1` de `Btn_Click`, puis `content1`, `donnees`, `donnees2`, `Coulfc`/`Frmt`,
  `filetxt`, `Tab2`, et dans `Button1_Click` `Lib`, `Libel`, `Nbpage`, `p`, `Shell "cd"`,
  `totdeb = totdeb`/`totcred = totcred` · appelants : aucun · tests : T01, T03 à T05 · sources : [EditcompteA.class:Button2_Click](../../../../../.src/Compta/Impressions/EditcompteA.class#L821-L929), [EditcompteA.class:Btn_Click](../../../../../.src/Compta/Impressions/EditcompteA.class#L299-L318), [EditcompteA.class:content1](../../../../../.src/Compta/Impressions/EditcompteA.class#L566-L570), [EditcompteA.class:donnees2](../../../../../.src/Compta/Impressions/EditcompteA.class#L578-L582), [EditcompteA.class:_New](../../../../../.src/Compta/Impressions/EditcompteA.class#L60-L85), [EditcompteA.class:604](../../../../../.src/Compta/Impressions/EditcompteA.class#L604)
- [ ] EDITCOMPTEA-003 — [complexité] `Button1_Click` : helper privé `SautPage(titre)` pour les 4 blocs
  de saut de page (titres actuels conservés) · appelants : aucun · tests : T03 (après A01), T04 · sources : [EditcompteA.class:Button1_Click](../../../../../.src/Compta/Impressions/EditcompteA.class#L587-L772)
- [ ] EDITCOMPTEA-004 — [commonalisation] `Centralisation`, `finmois`, `Raz`, DDL de `Ctrlnc` → helper
  commun « centralisation » (voir EDITCOMPTE-006), table `Ctrlnc` en paramètre · appelants : aucun ·
  tests : T03, EDITCOMPTE-T06 · sources : [EditcompteA.class:Centralisation](../../../../../.src/Compta/Impressions/EditcompteA.class#L777-L800), [EditcompteA.class:finmois](../../../../../.src/Compta/Impressions/EditcompteA.class#L805-L816), [EditcompteA.class:Raz](../../../../../.src/Compta/Impressions/EditcompteA.class#L418-L431)
- [ ] EDITCOMPTEA-005 — [commonalisation] Fonctions d'écran identiques à `Editcompte` (`Ex1`,
  `Exo`…`Exo5`, `Compdate`, `compdate2`) → helpers communs de bornes et de contrôle de date
  (BALANCE-004/005) · appelants : aucun · tests : T01, T02 · sources : [EditcompteA.class:Ex1](../../../../../.src/Compta/Impressions/EditcompteA.class#L90-L109), [EditcompteA.class:Exo5](../../../../../.src/Compta/Impressions/EditcompteA.class#L218-L237), [EditcompteA.class:Compdate](../../../../../.src/Compta/Impressions/EditcompteA.class#L389-L400)
- [ ] EDITCOMPTEA-006 — [séparation traitement/GUI] `dteN0_LostFocus`/`dteN1_LostFocus` : helper pur
  `PretraiteDate(texte, aujourdhui)` qui reproduit le prétraitement actuel (A03 comprise) ;
  `Button1_Click` : parcours SQL + centralisation dans une fonction sans contrôle · appelants : aucun ·
  tests : T02 à T05 · sources : [EditcompteA.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/EditcompteA.class#L331-L354), [EditcompteA.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/EditcompteA.class#L356-L387), [EditcompteA.class:Button1_Click](../../../../../.src/Compta/Impressions/EditcompteA.class#L587-L772)
- [ ] EDITCOMPTEA-007 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Raz`,
  `Centralisation`, `finmois` → `Private` (`Bsel`/`Bval`, `dteN*_LostFocus` restent `Public`) ·
  appelants : aucun · tests : T01 à T07 · sources : [EditcompteA.class:Exo](../../../../../.src/Compta/Impressions/EditcompteA.class#L114-L133), [EditcompteA.class:compdate2](../../../../../.src/Compta/Impressions/EditcompteA.class#L402-L413), [EditcompteA.class:Centralisation](../../../../../.src/Compta/Impressions/EditcompteA.class#L777-L800)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITCOMPTEA-A01 — [anomalie] `pdf.level4C(totdeb, totcred, totsld, Posy)` : 4 arguments pour 5
  paramètres (`Ccompta.Level4C(…, compte, posy)`) → erreur d'exécution non interceptée au premier
  compte mouvementé, l'extrait analytique n'aboutit jamais (à confirmer par T03). Correction :
  passer `Compt` ; débloque la fusion avec `EditcompteM` · tests : T03 · sources : [EditcompteA.class:726](../../../../../.src/Compta/Impressions/EditcompteA.class#L726)
- [ ] EDITCOMPTEA-A02 — [anomalie] L'impression lit toujours `Fiches_MvtA` (`TabMvtA`) : le choix
  d'exercice N-1…N-5 ne change que les dates, pas la table (`TabMvtA1`…`TabMvtA5` existent dans
  `Cbase`) ; même défaut dans `JournauxA` · tests : T06 · sources : [EditcompteA.class:633](../../../../../.src/Compta/Impressions/EditcompteA.class#L633), [EditcompteA.class:N1_Click](../../../../../.src/Compta/Impressions/EditcompteA.class#L484-L489), [JournauxA.class:616](../../../../../.src/Compta/Impressions/JournauxA.class#L616)
- [ ] EDITCOMPTEA-A03 — [anomalie] Prétraitement des dates : `jjmmaa` perd l'année saisie, une
  saisie de 3 caractères donne une date fausse ; `Utils.Cdate_calc` seul traite correctement ces
  formats · tests : T02 · sources : [EditcompteA.class:336](../../../../../.src/Compta/Impressions/EditcompteA.class#L336), [EditcompteA.class:361](../../../../../.src/Compta/Impressions/EditcompteA.class#L361), [EditcompteA.class:335](../../../../../.src/Compta/Impressions/EditcompteA.class#L335)
- [ ] EDITCOMPTEA-A04 — [anomalie] `Compdate`/`compdate2` remettent la période sur `Exo` et cochent
  `E0` (même défaut que BALANCE-A04) ; curseur final `Mouse.Pointing` au lieu de `Mouse.Default` ·
  tests : T01, T02 · sources : [EditcompteA.class:Compdate](../../../../../.src/Compta/Impressions/EditcompteA.class#L389-L400), [EditcompteA.class:770](../../../../../.src/Compta/Impressions/EditcompteA.class#L770)
