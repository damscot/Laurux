# Remisec — Rework

> Source : `.src/Gestion/Tables/Remisec.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Remisec.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 243 |
| Lignes de commentaire | 41 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 10 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 243 | 53 | 10 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] REMISEC-001 — [documentation] Corriger l'en-tête (« remises par type de client et par
  famille », et non « types clients ») ; documenter l'usage de `RichDataGrid`/`CFormat`, le
  groupe `rem` et les lecteurs de la table (`TarArt`, `Facture`, `Moulinage`, `TriEqu`) ·
  appelants : aucun · tests : aucun · sources : [Remisec.class:24](../../../../../.src/Gestion/Tables/Remisec.class#L24), [Remisec.class:Form_Open](../../../../../.src/Gestion/Tables/Remisec.class#L51-L78)
- [ ] REMISEC-002 — [code mort] Supprimer `CoulZns`/`CoulfOC` et leur calcul, `Frmt` de
  `Form_Open`, les variables `Tab` redondantes · appelants : aucun · tests : T01-T05 · sources : [Remisec.class:30](../../../../../.src/Gestion/Tables/Remisec.class#L30), [Remisec.class:31](../../../../../.src/Gestion/Tables/Remisec.class#L31), [Remisec.class:Form_Open](../../../../../.src/Gestion/Tables/Remisec.class#L51-L78)
- [ ] REMISEC-003 — [réarchitecture] `Cbase.Table("TabRemTypec")`, `("TabTypec")`, `("TabFam")`
  à la place des noms en dur (membre `Tabtype`, `Maj_Zones`, `Quitte_*`, `Button2/3_Click`) ;
  SQL identique · appelants : aucun · tests : T01-T05 · sources : [Remisec.class:Form_Open](../../../../../.src/Gestion/Tables/Remisec.class#L51-L78), [Remisec.class:Maj_Zones](../../../../../.src/Gestion/Tables/Remisec.class#L80-L94), [Remisec.class:Button3_Click](../../../../../.src/Gestion/Tables/Remisec.class#L295-L324)
- [ ] REMISEC-004 — [réduction de portée] `Maj_Zones`, `Cleanchamps`, `Quitte_Cdt`, `Quitte_Cdf`,
  `Quitte_Remise` → `Private` (aucun appel externe, vérifié par `grep -rn`) ; `Coltype_Click`,
  `Colfam_Click` (`replay_dynamic`) inchangés · appelants : aucun · tests : T01-T04 · sources : [Remisec.class:Maj_Zones](../../../../../.src/Gestion/Tables/Remisec.class#L80-L94), [Remisec.class:Quitte_Remise](../../../../../.src/Gestion/Tables/Remisec.class#L251-L267)
- [ ] REMISEC-005 — [commonalisation] Gabarit commun avec `CoefTypeC` et `Remisecli` (listes,
  contrôles, enregistrement, suppression) paramétré par table, colonne et libellés (phase 3,
  même commit que COEFTYPEC-006) ; `EnregistreRemise`/`SupprimeRemise` sans contrôle ·
  appelants : aucun · tests : T01-T04, COEFTYPEC-T01 à T04 · sources : [Remisec.class:Button3_Click](../../../../../.src/Gestion/Tables/Remisec.class#L295-L324), [Remisec.class:Quitte_Cdt](../../../../../.src/Gestion/Tables/Remisec.class#L196-L221), [CoefTypeC.class:Quitte_Cdt](../../../../../.src/Gestion/Tables/CoefTypeC.class#L202-L227)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] REMISEC-A01 — [anomalie] `Button3_Click` enregistre même si les contrôles `Quitte_*` ont
  échoué (type ou famille inexistants, remise invalide → `NULL`) · tests : T03 · sources : [Remisec.class:304](../../../../../.src/Gestion/Tables/Remisec.class#L304), [Remisec.class:307](../../../../../.src/Gestion/Tables/Remisec.class#L307)
- [ ] REMISEC-A02 — [anomalie] Colonne « Remise » : le format `0.000` est converti en `0` par
  `CFormat._Get` (CFORMAT-A01) et appliqué à toute valeur Float (RICHDATAGRID-A04) → remise
  affichée arrondie (à confirmer par T05) ; la correction se fait dans `CFormat` · tests : T05 ·
  sources : [Remisec.class:73](../../../../../.src/Gestion/Tables/Remisec.class#L73), [CFormat.class:51](../../../../../.src/Utils/CFormat.class#L51)
- [ ] REMISEC-A03 — [anomalie] Après enregistrement, `Tabtypec.MoveTo(skey, 0)` reçoit le code du
  type comme numéro de ligne (création) : sélection arbitraire, qui relance `Tabtypec_Select`
  avant `CleanChamps` · tests : T01 · sources : [Remisec.class:310](../../../../../.src/Gestion/Tables/Remisec.class#L310), [Remisec.class:314](../../../../../.src/Gestion/Tables/Remisec.class#L314), [Remisec.class:317](../../../../../.src/Gestion/Tables/Remisec.class#L317)
- [ ] REMISEC-A04 — [anomalie] `Maj_Zones` lit la ligne sans tester `Available` (ligne supprimée par
  un autre poste → erreur) · tests : T04 · sources : [Remisec.class:86](../../../../../.src/Gestion/Tables/Remisec.class#L86), [Remisec.class:88](../../../../../.src/Gestion/Tables/Remisec.class#L88)
