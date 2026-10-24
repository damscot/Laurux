# EdNlettrees — Rework

> Source : `.src/Compta/Impressions/EdNlettrees.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EdNlettrees.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 424 |
| Lignes de commentaire | 75 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 17 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 424 | 63 | 17 | 0 | 27 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDNLETTREES-001 — [documentation] En-tête en français (rôle, sélection, usage de
  `Listextcpt` multi-exercices, contrat `Bsel`/`Bval` avec `TriCpt`, groupe `Cmpt`) ;
  commentaires `'''` · appelants : aucun · tests : aucun · sources : [EdNlettrees.class:1-25](../../../../../.src/Compta/Impressions/EdNlettrees.class#L1-L25), [EdNlettrees.class:Button1_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L347-L487)
- [ ] EDNLETTREES-002 — [code mort] Supprimer les méthodes `Draw` `Level0`…`Level5`, les variables
  `dte1`, `dte2`, `Tab0`, `montantd`, `montantc`, `libelle`, `Datj` (branche centralisateur sans
  effet : seul `jour` reste écrit), `req`, `Nbpage`, `p`, l'affectation morte `ste =
  TypeClient1.where` et le `Shell "cd"` · appelants : aucun · tests : T02, T06 · sources : [EdNlettrees.class:Level0](../../../../../.src/Compta/Impressions/EdNlettrees.class#L490-L499), [EdNlettrees.class:Level5](../../../../../.src/Compta/Impressions/EdNlettrees.class#L577-L591), [EdNlettrees.class:365-366](../../../../../.src/Compta/Impressions/EdNlettrees.class#L365-L366), [EdNlettrees.class:429-435](../../../../../.src/Compta/Impressions/EdNlettrees.class#L429-L435)
- [ ] EDNLETTREES-003 — [complexité] `_New` : une seule initialisation des dates (suppression de
  l'appel redondant `ex1()` après `E0_click()` ; SQL modifié, dump identique) et suppression de
  `E0_Click` (non-handler) au profit d'`Ex1` · appelants : aucun · tests : T01 · sources : [EdNlettrees.class:_New](../../../../../.src/Compta/Impressions/EdNlettrees.class#L63-L75), [EdNlettrees.class:E0_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L305-L310)
- [ ] EDNLETTREES-004 — [complexité] Une seule requête de comptes (jointure `Fiches_Cli` et
  `TypeClient1.where` conditionnels, tables par `Cbase.Table`) et helper `SautPage()` pour les
  quatre blocs `PosY >= 280` · appelants : aucun · tests : T02-T04, T09 · sources : [EdNlettrees.class:381-385](../../../../../.src/Compta/Impressions/EdNlettrees.class#L381-L385), [EdNlettrees.class:Button1_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L347-L487)
- [ ] EDNLETTREES-005 — [réduction de portée] `Ex1`, `Raz` → `Private` ; `Bsel`/`Bval` restent
  `Public` (écrits par `TriCpt`) · appelants : aucun · tests : T01, T07 · sources : [EdNlettrees.class:Ex1](../../../../../.src/Compta/Impressions/EdNlettrees.class#L80-L93), [EdNlettrees.class:Raz](../../../../../.src/Compta/Impressions/EdNlettrees.class#L248-L258), [EdNlettrees.class:57-58](../../../../../.src/Compta/Impressions/EdNlettrees.class#L57-L58)
- [ ] EDNLETTREES-006 — [séparation traitement/GUI] `Lignes_Compte(sCompte, sDu, sAu,
  bCentralisateur)` (appel `Listextcpt`, filtre de dates, cumuls) sans contrôle ; `Button1_Click`
  ne fait que le rendu · appelants : aucun · tests : T02, T06, T10 · sources : [EdNlettrees.class:Button1_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L347-L487)
- [ ] EDNLETTREES-007 — [commonalisation] (transverse) Socle commun des éditions (en-tête société,
  PDF, `Termine`, saisie de date) et sélection de plage de comptes partagée avec `EdNjustifiees`
  (`PlageComptes`, `ChoisirCompte`, `Comptes_Plage`) · appelants : aucun · tests : T01-T04, T07,
  EDNJUSTIFIEES-T01-T03 · sources : [EdNlettrees.class:Bclient_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L263-L272), [EdNlettrees.class:ToggleButton3_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L315-L326), [EdNjustifiees.class:Bclient_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L175-L184), [EdNlettrees.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/EdNlettrees.class#L211-L223)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDNLETTREES-A01 — [anomalie] Les dates ne sont normalisées et contrôlées que sur Entrée/Tab
  (groupe `Cmpt`, aucun `Cmpt_LostFocus`) : une date saisie puis un clic sur « Imprimer » part
  brute vers `Listextcpt` (« 3112 » non converti) · tests : T01 · sources : [EdNlettrees.class:Cmpt_KeyPress](../../../../../.src/Compta/Impressions/EdNlettrees.class#L98-L154), [EdNlettrees.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/EdNlettrees.class#L211-L223)
- [ ] EDNLETTREES-A02 — [anomalie] Compte centralisateur (`cent_cc = 1`) : en-tête et total à 0
  imprimés, aucune ligne (les valeurs lues sont jetées) · tests : T06 · sources : [EdNlettrees.class:407](../../../../../.src/Compta/Impressions/EdNlettrees.class#L407), [EdNlettrees.class:429-435](../../../../../.src/Compta/Impressions/EdNlettrees.class#L429-L435)
- [ ] EDNLETTREES-A03 — [anomalie] « Aucune ecriture » n'est affiché qu'en l'absence de compte :
  si les comptes existent sans écriture non lettrée, un PDF vide est produit ; pied de page sur la
  dernière page seulement ; PDF au même nom que `EdNjustifiees` · tests : T08, T09 · sources : [EdNlettrees.class:367](../../../../../.src/Compta/Impressions/EdNlettrees.class#L367), [EdNlettrees.class:472](../../../../../.src/Compta/Impressions/EdNlettrees.class#L472), [EdNlettrees.class:479](../../../../../.src/Compta/Impressions/EdNlettrees.class#L479)
