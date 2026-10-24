# Jourcent — Rework

> Source : `.src/Compta/Impressions/Jourcent.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Jourcent.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 780 |
| Lignes de commentaire | 45 |
| Fonctions | 44 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 137 |
| Complexité max (fonction) | 22 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 780 | 137 | 22 | 0 | 44 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] JOURCENT-001 — [documentation] En-tête en français : rôle, règles de centralisation
  (OD inclus, 401/411 détaillés exclus, collectifs « Clients »), différences avec `JournauxM` ·
  appelants : aucun · tests : aucun · sources : [Jourcent.class:1-25](../../../../../.src/Compta/Impressions/Jourcent.class#L1-L25), [Jourcent.class:Button1_Click](../../../../../.src/Compta/Impressions/Jourcent.class#L637-L809)
- [ ] JOURCENT-002 — [code mort] Supprimer `Button2_Click` (aucune commande `Tag` 2) et le
  `Case 2` de `Btn_Click`, `Centralisation`, `Donnees0..3`, `filetxt`, `hfile`, `P`, `Datep`,
  `Shell "cd"`, `copt`/`p1`, la ligne `totsld = totdeb - totdeb`, le 3e argument `"OD"` et le code
  commenté ; `Coulfond` si `Utils.Coulfd` est sans effet de bord · appelants : aucun · tests :
  T01-T07 · sources : [Jourcent.class:Button2_Click](../../../../../.src/Compta/Impressions/Jourcent.class#L878-L985), [Jourcent.class:Centralisation](../../../../../.src/Compta/Impressions/Jourcent.class#L826-L843), [Jourcent.class:Donnees0](../../../../../.src/Compta/Impressions/Jourcent.class#L599-L603), [Jourcent.class:Donnees3](../../../../../.src/Compta/Impressions/Jourcent.class#L617-L621), [Jourcent.class:341-342](../../../../../.src/Compta/Impressions/Jourcent.class#L341-L342), [Jourcent.class:672](../../../../../.src/Compta/Impressions/Jourcent.class#L672), [Jourcent.class:686](../../../../../.src/Compta/Impressions/Jourcent.class#L686), [Jourcent.class:783](../../../../../.src/Compta/Impressions/Jourcent.class#L783)
- [ ] JOURCENT-003 — [commonalisation] Saisie par le socle `ImpCompta` : `Bornes` (BALANCE-004),
  `TableMvt` (JOURNAUX-003), `ControleDate` (BALANCE-005) (JOURNAUX-004), `ListeJournaux` (JOURNAUX-005) ;
  handlers conservés · appelants : aucun · tests : T10 · sources : [Jourcent.class:Ex1](../../../../../.src/Compta/Impressions/Jourcent.class#L80-L104), [Jourcent.class:Exo5](../../../../../.src/Compta/Impressions/Jourcent.class#L195-L214), [Jourcent.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/Jourcent.class#L386-L407), [Jourcent.class:ToggleButton3_Click](../../../../../.src/Compta/Impressions/Jourcent.class#L216-L246)
- [ ] JOURCENT-004 — [commonalisation] `Create_table` → `ImpCompta.CentralisationCree` (le `Try`
  du socle ne change rien si la création réussit, à vérifier sous SQLite) ; cumuls →
  `ImpCompta.CentralisationCumule` ; `Centralisation2` → `ImpCompta.CentralisationImprime` en
  variante « en-tête complet » ; l'`UPDATE` concaténé devient paramétré (SQL modifié, dump
  identique pour les intitulés sans apostrophe) · appelants : aucun · tests : T01-T06 · sources : [Jourcent.class:Create_table](../../../../../.src/Compta/Impressions/Jourcent.class#L623-L635), [Jourcent.class:734-766](../../../../../.src/Compta/Impressions/Jourcent.class#L734-L766), [Jourcent.class:Centralisation2](../../../../../.src/Compta/Impressions/Jourcent.class#L845-L876)
- [ ] JOURCENT-005 — [complexité] Extraire de `Button1_Click` la décision de cumul d'une ligne
  et l'en-tête de page (CC 22 → ≤ 12 visé) ; ordre des appels inchangé · appelants : aucun ·
  tests : T01-T06 · sources : [Jourcent.class:696-701](../../../../../.src/Compta/Impressions/Jourcent.class#L696-L701), [Jourcent.class:703-767](../../../../../.src/Compta/Impressions/Jourcent.class#L703-L767)
- [ ] JOURCENT-006 — [séparation traitement/GUI] Extraire `CumuleJournal(sJournal, sDeb, sFin,
  sTab) As Boolean` (lecture + cumul, sans contrôle) ; le handler garde PDF, curseur et messages ·
  appelants : aucun · tests : T01-T07 · sources : [Jourcent.class:Button1_Click](../../../../../.src/Compta/Impressions/Jourcent.class#L637-L809)
- [ ] JOURCENT-007 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`,
  `Create_table`, `Centralisation2`, `Raz` → `Private` · appelants : aucun · tests : T01-T10 ·
  sources : [Jourcent.class:Ex1](../../../../../.src/Compta/Impressions/Jourcent.class#L80-L104), [Jourcent.class:Centralisation2](../../../../../.src/Compta/Impressions/Jourcent.class#L845-L876), [Jourcent.class:Raz](../../../../../.src/Compta/Impressions/Jourcent.class#L811-L824)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] JOURCENT-A01 — [anomalie] Collectif hors `401`/`411` (ex. `453`) : cumulé avec `debit`/
  `credit` de la **ligne non collective précédente** au lieu de ses propres montants · tests :
  T03 · sources : [Jourcent.class:712-724](../../../../../.src/Compta/Impressions/Jourcent.class#L712-L724), [Jourcent.class:734-748](../../../../../.src/Compta/Impressions/Jourcent.class#L734-L748)
- [ ] JOURCENT-A02 — [anomalie] Collectifs `401` et `411` insérés sous le libellé « Clients » ;
  `UPDATE` par concaténation : erreur SQL si l'intitulé du collectif contient une apostrophe ·
  tests : T02, T08 · sources : [Jourcent.class:757](../../../../../.src/Compta/Impressions/Jourcent.class#L757), [Jourcent.class:761](../../../../../.src/Compta/Impressions/Jourcent.class#L761)
- [ ] JOURCENT-A03 — [anomalie] Curseur final `Mouse.Custom` au lieu de `Mouse.Default` ·
  tests : T09 · sources : [Jourcent.class:807](../../../../../.src/Compta/Impressions/Jourcent.class#L807)
- [ ] JOURCENT-A04 — [anomalie] Règles de centralisation divergentes de `JournauxM` (OD
  centralisés, `453` traités comme comptes ordinaires, 401/411 détaillés exclus) : deux éditions
  « centralisation » différentes pour le même journal ; à arbitrer par l'utilisateur · tests :
  T04, JOURNAUXM-T01 · sources : [Jourcent.class:734](../../../../../.src/Compta/Impressions/Jourcent.class#L734), [JournauxM.module:207](../../../../../.src/Compta/Impressions/JournauxM.module#L207)
