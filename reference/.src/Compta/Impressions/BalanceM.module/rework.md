# BalanceM — Rework

> Source : `.src/Compta/Impressions/BalanceM.module` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/BalanceM.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 355 |
| Lignes de commentaire | 13 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 30 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 355 | 44 | 30 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BALANCEM-001 — [documentation] En-tête de module en français : rôle, paramètres d'`Imprime`,
  tableau des niveaux `Cbalances` (`Level0` … `Level4a`), définition des cumuls de période / hors
  période / classe, état de module et sa remise à zéro · appelants : aucun · tests : aucun · sources : [BalanceM.module:Imprime](../../../../../.src/Compta/Impressions/BalanceM.module#L50-L259)
- [ ] BALANCEM-002 — [code mort] Supprimer `Classe2` (aucun appel), la branche `Else` inatteignable
  d'`Imprime` (test sur `rrResult.count` toujours vrai), le `Shell "cd ~"` sans effet, et les variables
  sans lecture (`p`, `p1`, `PosX`, `Nbpage`, `solde`, `dte`, `debit`/`credit` intermédiaires,
  `totbalsld`, `Totdebclass`, `Totcredclass`) · appelants : aucun · tests : T01 à T10 · sources : [BalanceM.module:Classe2](../../../../../.src/Compta/Impressions/BalanceM.module#L330-L364), [BalanceM.module:182](../../../../../.src/Compta/Impressions/BalanceM.module#L182), [BalanceM.module:72](../../../../../.src/Compta/Impressions/BalanceM.module#L72)
- [ ] BALANCEM-003 — [complexité] Supprimer la requête d'écritures dupliquée (l. 102, identique à
  l. 106) ; SQL modifié (une requête de moins par compte), dump identique · appelants : aucun · tests :
  T01 à T07 · sources : [BalanceM.module:102](../../../../../.src/Compta/Impressions/BalanceM.module#L102), [BalanceM.module:106](../../../../../.src/Compta/Impressions/BalanceM.module#L106)
- [ ] BALANCEM-004 — [commonalisation] Helper privé `EntetePage(titre)` pour les en-têtes répétés
  (début d'`Imprime`, `Bas_page`, `Classe`), titres et positions inchangés, absence de `BasPage` dans
  `Classe` conservée · appelants : aucun · tests : T01, T03, T04 · sources : [BalanceM.module:Imprime](../../../../../.src/Compta/Impressions/BalanceM.module#L50-L259), [BalanceM.module:Bas_page](../../../../../.src/Compta/Impressions/BalanceM.module#L261-L279), [BalanceM.module:Classe](../../../../../.src/Compta/Impressions/BalanceM.module#L285-L325)
- [ ] BALANCEM-005 — [complexité] Extraire de la boucle d'`Imprime` : `CumulCompte(…) As Float[]`
  (lecture et ventilation période / hors période, sans PDF), `MontantOuVide(x)` (4 conversions
  identiques) et l'impression d'une ligne de compte ; CC 30 → ≤ 12 visé · appelants : aucun · tests :
  T01 à T10 · sources : [BalanceM.module:Imprime](../../../../../.src/Compta/Impressions/BalanceM.module#L50-L259)
- [ ] BALANCEM-006 — [réduction de portée] `Bas_page`, `Classe`, `Raz` → `Private` · appelants :
  aucun · tests : T01 à T05 · sources : [BalanceM.module:Bas_page](../../../../../.src/Compta/Impressions/BalanceM.module#L261-L279), [BalanceM.module:Classe](../../../../../.src/Compta/Impressions/BalanceM.module#L285-L325), [BalanceM.module:Raz](../../../../../.src/Compta/Impressions/BalanceM.module#L369-L386)
- [ ] BALANCEM-007 — [séparation traitement/GUI] `Imprime` reçoit le filtre `where As String` au
  lieu du contrôle `TypeClient` (même SQL), et la gestion de `Balance.Mouse` passe dans l'appelant ;
  commit commun avec BALANCE-008 · appelants : `Balance.Button1_Click` · tests : T01 à T09 · sources : [BalanceM.module:Imprime](../../../../../.src/Compta/Impressions/BalanceM.module#L50-L259), [BalanceM.module:78](../../../../../.src/Compta/Impressions/BalanceM.module#L78), [Balance.class:Button1_Click](../../../../../.src/Compta/Impressions/Balance.class#L618-L622)
- [ ] BALANCEM-008 — [commonalisation] `Fiches_Cli` → `Cbase.Table("TabCli")` dans la jointure du
  filtre client (SQL identique) · appelants : aucun · tests : T06 · sources : [BalanceM.module:82](../../../../../.src/Compta/Impressions/BalanceM.module#L82)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BALANCEM-A01 — [anomalie] `If rrResult.count <> 0` (l. 103) teste la liste des comptes au lieu
  des écritures : la branche des comptes sans écriture est morte et `Classe()` est appelée pour tous
  les comptes. Corriger change l'interligne des comptes vides (4 au lieu de 5 mm) et les ruptures ·
  tests : T05, T03 · sources : [BalanceM.module:103](../../../../../.src/Compta/Impressions/BalanceM.module#L103)
- [ ] BALANCEM-A02 — [anomalie] Le cumul « hors période » prend toutes les écritures hors
  `[dteN0, dteN1]`, y compris **postérieures** à la fin : le solde imprimé n'est pas le solde à la date
  de fin dès qu'il existe des écritures plus récentes · tests : T02 · sources : [BalanceM.module:117](../../../../../.src/Compta/Impressions/BalanceM.module#L117)
- [ ] BALANCEM-A03 — [anomalie] Rupture de classe en bas de page : nouvelle page sans `BasPage`
  (pas de pied « Page n/N ») et seuil 274 au lieu de 268 ; titres de page différents entre la 1re page
  (« Impression de la balance <nom> ») et les suivantes (« Impression des balances ») · tests : T04 · sources : [BalanceM.module:291](../../../../../.src/Compta/Impressions/BalanceM.module#L291), [BalanceM.module:265](../../../../../.src/Compta/Impressions/BalanceM.module#L265)
- [ ] BALANCEM-A04 — [anomalie] Pas de remise à zéro en cas d'erreur (`Catch`) : les cumuls de classe
  et de balance d'une impression interrompue sont repris par l'impression suivante · tests : T09 · sources : [BalanceM.module:252](../../../../../.src/Compta/Impressions/BalanceM.module#L252)
