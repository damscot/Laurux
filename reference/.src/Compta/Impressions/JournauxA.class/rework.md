# JournauxA — Rework

> Source : `.src/Compta/Impressions/JournauxA.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/JournauxA.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 664 |
| Lignes de commentaire | 24 |
| Fonctions | 40 |
| Fonctions Public | 40 |
| Complexité cyclomatique totale | 128 |
| Complexité max (fonction) | 24 (`Button1_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 664 | 128 | 24 | 0 | 40 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] JOURNAUXA-001 — [documentation] En-tête en français : rôle, table `Fiches_MvtA`, deux
  ordres de tri, anomalies connues renvoyant à ce document · appelants : aucun · tests : aucun ·
  sources : [JournauxA.class:1-10](../../../../../.src/Compta/Impressions/JournauxA.class#L1-L10), [JournauxA.class:Button1_click](../../../../../.src/Compta/Impressions/JournauxA.class#L559-L765)
- [ ] JOURNAUXA-002 — [code mort] Supprimer `donnees1..3`, `filetxt`/`hfile`, `ordre` (et la
  branche morte du double test `RadioButton1`), `Datep`, `Shell "cd"`, la lecture de `dtepc`, les
  variables `Tab2`…`Tab5`, `i`, `p1` et les blocs vides ; SQL modifié (un `SELECT` en moins),
  dump identique · appelants : aucun · tests : T04, T05, T07 · sources : [JournauxA.class:donnees1](../../../../../.src/Compta/Impressions/JournauxA.class#L811-L815), [JournauxA.class:donnees3](../../../../../.src/Compta/Impressions/JournauxA.class#L823-L827), [JournauxA.class:597-614](../../../../../.src/Compta/Impressions/JournauxA.class#L597-L614), [JournauxA.class:689-697](../../../../../.src/Compta/Impressions/JournauxA.class#L689-L697), [JournauxA.class:729-732](../../../../../.src/Compta/Impressions/JournauxA.class#L729-L732)
- [ ] JOURNAUXA-003 — [commonalisation] `Ex1`, `Exo`…`Exo5` → `Bornes(index)` (BALANCE-004)
  (JOURNAUX-003) ; `Tab0` supprimé des handlers d'exercice (jamais lu) · appelants : aucun ·
  tests : T07 · sources : [JournauxA.class:Ex1](../../../../../.src/Compta/Impressions/JournauxA.class#L57-L81), [JournauxA.class:Exo5](../../../../../.src/Compta/Impressions/JournauxA.class#L172-L191), [JournauxA.class:E0_Click](../../../../../.src/Compta/Impressions/JournauxA.class#L496-L501), [JournauxA.class:N5_Click](../../../../../.src/Compta/Impressions/JournauxA.class#L538-L543)
- [ ] JOURNAUXA-004 — [commonalisation] `dteN0_LostFocus`/`dteN1_LostFocus` →
  `ControleDate` (BALANCE-005) de BALANCE-005 avec complétion des dates courtes (JOURNAUX-004) · appelants : aucun · tests : T06 ·
  sources : [JournauxA.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/JournauxA.class#L402-L426), [JournauxA.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/JournauxA.class#L434-L466)
- [ ] JOURNAUXA-005 — [commonalisation] `Create_table`, cumul et `Centralisation` →
  `ImpCompta.CentralisationCree/Cumule/Imprime` (JOURNAUXM-005/006), titres identiques ·
  appelants : aucun · tests : T04 · sources : [JournauxA.class:Create_table](../../../../../.src/Compta/Impressions/JournauxA.class#L545-L557), [JournauxA.class:699-713](../../../../../.src/Compta/Impressions/JournauxA.class#L699-L713), [JournauxA.class:Centralisation](../../../../../.src/Compta/Impressions/JournauxA.class#L782-L809)
- [ ] JOURNAUXA-006 — [complexité] Extraire les ruptures poste/journal (deux ordres) dans une
  fonction privée `EntetesRupture` (CC 24 → ≤ 12 visé) ; ordre des appels PDF et SQL inchangé ·
  appelants : aucun · tests : T04, T07 · sources : [JournauxA.class:631-677](../../../../../.src/Compta/Impressions/JournauxA.class#L631-L677)
- [ ] JOURNAUXA-007 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `Aff_Postes`, `Compdate`,
  `compdate2`, `Create_table`, `Raz`, `Centralisation` → `Private` · appelants : aucun ·
  tests : T01, T04-T07 · sources : [JournauxA.class:Aff_Postes](../../../../../.src/Compta/Impressions/JournauxA.class#L207-L242), [JournauxA.class:Raz](../../../../../.src/Compta/Impressions/JournauxA.class#L767-L780), [JournauxA.class:Centralisation](../../../../../.src/Compta/Impressions/JournauxA.class#L782-L809)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] JOURNAUXA-A01 — [anomalie] `pdf.level2J` appelé avec 9 arguments (paramètre `Nlot` absent,
  non optionnel dans `Ccompta`) : erreur à la première écriture de la période, impression
  impossible (à confirmer par T02) · tests : T02 · sources : [JournauxA.class:695](../../../../../.src/Compta/Impressions/JournauxA.class#L695), [Ccompta.class:level2J](../../../../../.src/Reports/Ccompta.class#L289-L307)
- [ ] JOURNAUXA-A02 — [anomalie] `Fiches_Postes` n'a pas de colonne `intitule` (c'est
  `intitulep`) : liste des postes en erreur, tri journaux/postes en erreur SQL · tests : T01, T03 ·
  sources : [JournauxA.class:233](../../../../../.src/Compta/Impressions/JournauxA.class#L233), [JournauxA.class:663](../../../../../.src/Compta/Impressions/JournauxA.class#L663)
- [ ] JOURNAUXA-A03 — [anomalie] Libellés de poste et de journal lus avec `>=` sans `ORDER BY` :
  libellé d'un autre poste/journal possible · tests : T02 · sources : [JournauxA.class:635](../../../../../.src/Compta/Impressions/JournauxA.class#L635), [JournauxA.class:644](../../../../../.src/Compta/Impressions/JournauxA.class#L644), [JournauxA.class:653](../../../../../.src/Compta/Impressions/JournauxA.class#L653), [JournauxA.class:663](../../../../../.src/Compta/Impressions/JournauxA.class#L663)
- [ ] JOURNAUXA-A04 — [anomalie] Centralisation : `Compt` est le **compte** de la ligne (et non le
  journal) écrit dans `njournal Char(2)` (erreur en mode strict, troncature sinon) ; la page de
  centralisation ne porte que sur le dernier compte ; `type_jour` jamais renseigné · tests : T02,
  T04 · sources : [JournauxA.class:628](../../../../../.src/Compta/Impressions/JournauxA.class#L628), [JournauxA.class:706](../../../../../.src/Compta/Impressions/JournauxA.class#L706), [JournauxA.class:710](../../../../../.src/Compta/Impressions/JournauxA.class#L710), [JournauxA.class:734](../../../../../.src/Compta/Impressions/JournauxA.class#L734)
- [ ] JOURNAUXA-A05 — [anomalie] Exercice ignoré (`Fiches_MvtA` toujours lue, `TabMvtA1..5`
  jamais utilisées) et filtre de période appliqué après l'impression des ruptures : titres de
  poste/journal imprimés pour des écritures hors période (même défaut qu'EditcompteA:633) · tests : T04, T07 · sources : [JournauxA.class:615-619](../../../../../.src/Compta/Impressions/JournauxA.class#L615-L619), [JournauxA.class:631-680](../../../../../.src/Compta/Impressions/JournauxA.class#L631-L680)
- [ ] JOURNAUXA-A06 — [anomalie] Saut de page : en-tête « Journal N° <compte> <intitulé du
  compte> » (variables de compte) · tests : T02 · sources : [JournauxA.class:716-725](../../../../../.src/Compta/Impressions/JournauxA.class#L716-L725)
