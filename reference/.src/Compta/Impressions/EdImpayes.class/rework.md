# EdImpayes — Rework

> Source : `.src/Compta/Impressions/EdImpayes.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EdImpayes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 314 |
| Lignes de commentaire | 65 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 15 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 314 | 49 | 15 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDIMPAYES-001 — [documentation] En-tête corrigé (porte le nom d'`EdNlettrees`) : écran
  obsolète, sans appelant, remplacé par `EdNlettrees` ; à n'exécuter que si EDIMPAYES-A01 est
  refusée · appelants : aucun · tests : aucun · sources : [EdImpayes.class:20-25](../../../../../.src/Compta/Impressions/EdImpayes.class#L20-L25)
- [ ] EDIMPAYES-002 — [code mort] (si A01 refusée) Supprimer `Cbl_GotFocus` (aucun groupe `Cbl`),
  `dte1`, `dte2`, `Tab0`, `montantd`, `montantc`, `libelle`, `Datj`, `Coulfond`, le `Shell "cd"` et
  le `DROP`/`CREATE TABLE Ctrln` (table jamais alimentée ; dump différent sur la seule table de
  travail, voir EDITCOMPTE-A06) · appelants : aucun · tests : T02 · sources : [EdImpayes.class:Cbl_GotFocus](../../../../../.src/Compta/Impressions/EdImpayes.class#L176-L182), [EdImpayes.class:300](../../../../../.src/Compta/Impressions/EdImpayes.class#L300), [EdImpayes.class:305](../../../../../.src/Compta/Impressions/EdImpayes.class#L305), [EdImpayes.class:328-338](../../../../../.src/Compta/Impressions/EdImpayes.class#L328-L338)
- [ ] EDIMPAYES-003 — [réduction de portée] (si A01 refusée) `Ex1`, `E0_Click`, `Bclient_Click`,
  `Raz` → `Private` ; `Bsel`/`Bval` restent `Public` (`TriCpt`) · appelants : aucun · tests : T02 ·
  sources : [EdImpayes.class:Ex1](../../../../../.src/Compta/Impressions/EdImpayes.class#L82-L95), [EdImpayes.class:E0_Click](../../../../../.src/Compta/Impressions/EdImpayes.class#L246-L251), [EdImpayes.class:Bclient_Click](../../../../../.src/Compta/Impressions/EdImpayes.class#L234-L241), [EdImpayes.class:Raz](../../../../../.src/Compta/Impressions/EdImpayes.class#L219-L229)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDIMPAYES-A01 — [anomalie] Couple `EdImpayes.class` + `EdImpayes.form` mort (aucun appelant,
  remplacé par `EdNlettrees`) : suppression des deux fichiers, sans autre impact · tests : T01 ·
  sources : [EdImpayes.class:_New](../../../../../.src/Compta/Impressions/EdImpayes.class#L65-L77), [EdImpayes.class:Button1_Click](../../../../../.src/Compta/Impressions/EdImpayes.class#L288-L435)
- [ ] EDIMPAYES-A02 — [anomalie] (si l'écran est rattaché à un menu) Titre « écritures non
  lettrées » et PDF `Enlettrees.pdf` identiques à `EdNlettrees` pour un écran « impayés » ; seul
  l'exercice en cours est lu ; comptes centralisateurs imprimés sans ligne · tests : T02 · sources : [EdImpayes.class:306](../../../../../.src/Compta/Impressions/EdImpayes.class#L306), [EdImpayes.class:311](../../../../../.src/Compta/Impressions/EdImpayes.class#L311), [EdImpayes.class:326](../../../../../.src/Compta/Impressions/EdImpayes.class#L326), [EdImpayes.class:353](../../../../../.src/Compta/Impressions/EdImpayes.class#L353)
