# EdReg — Rework

> Source : `.src/Gestion/Impressions/EdReg.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdReg.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 10 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 59 | 22 | 10 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDREG-001 — [documentation] En-tête : état gb.report du bordereau de règlements, valeurs de
  `choix` (`tous`/`ajout`), rôle des handlers `Data` (`dte_Data`, `cde_Data`, `nom_Data`,
  `montant_Data`, signalés `unused` par `deps.py` à tort : ils restent `Public`) · appelants :
  aucun · tests : T01-T03 · sources : [EdReg.class:_new](../../../../../.src/Gestion/Impressions/EdReg.class#L7-L39), [EdReg.class:dte_Data](../../../../../.src/Gestion/Impressions/EdReg.class#L41-L50)
- [ ] EDREG-002 — [complexité] Calculer la couleur de fond une seule fois (même expression
  `Val("&H" & Hex(…))`, comportement identique) et `Cbase.Table("TabSoc")` à la place de
  `Fiches_Societes` (SQL identique) · appelants : aucun · tests : T01, T05 · sources : [EdReg.class:14](../../../../../.src/Gestion/Impressions/EdReg.class#L14), [EdReg.class:15](../../../../../.src/Gestion/Impressions/EdReg.class#L15), [EdReg.class:16](../../../../../.src/Gestion/Impressions/EdReg.class#L16)
- [ ] EDREG-003 — [commonalisation] Helper privé `Ligne(Index)` + `Police(Index)` pour les quatre
  handlers `_Data` (noms et portée `Public` conservés) · appelants : aucun · tests : T01, T02 ·
  sources : [EdReg.class:dte_Data](../../../../../.src/Gestion/Impressions/EdReg.class#L41-L50), [EdReg.class:cde_Data](../../../../../.src/Gestion/Impressions/EdReg.class#L52-L61), [EdReg.class:nom_Data](../../../../../.src/Gestion/Impressions/EdReg.class#L63-L72), [EdReg.class:montant_Data](../../../../../.src/Gestion/Impressions/EdReg.class#L74-L83)
- [ ] EDREG-004 — [séparation traitement/GUI] Extraire `Selection(Lecr, choix) As VarEcr` (filtre
  sur `etat`) et `RaisonSociale() As String` du constructeur ; `InputBox` reste dans `_new` ·
  appelants : aucun · tests : T01-T04 · sources : [EdReg.class:_new](../../../../../.src/Gestion/Impressions/EdReg.class#L7-L39)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDREG-A01 — [anomalie] `SELECT * FROM Fiches_Societes` sans filtre : en multi-société, le
  bordereau porte la raison sociale de la première société (correction : `WHERE cd_sc = &1`,
  `Start.Societe`, comme `Edcom`) · tests : T04 · sources : [EdReg.class:16](../../../../../.src/Gestion/Impressions/EdReg.class#L16), [Edcom.class:211](../../../../../.src/Gestion/Impressions/Edcom.class#L211)
- [ ] EDREG-A02 — [anomalie] Couleur de fond `Hex(Start.R) & Hex(Start.G) & Hex(Start.B)` sans
  remplissage à deux chiffres : couleur fausse dès qu'une composante est < 16 (correction :
  `Color.RGB(Start.R, Start.G, Start.B)`) · tests : T05 · sources : [EdReg.class:14](../../../../../.src/Gestion/Impressions/EdReg.class#L14), [EdReg.class:15](../../../../../.src/Gestion/Impressions/EdReg.class#L15)
