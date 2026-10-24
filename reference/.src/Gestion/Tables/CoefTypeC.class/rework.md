# CoefTypeC — Rework

> Source : `.src/Gestion/Tables/CoefTypeC.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/CoefTypeC.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 281 |
| Lignes de commentaire | 36 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 10 (`Rem_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 281 | 62 | 10 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COEFTYPEC-001 — [documentation] En-tête en français : table `Fiches_CoeffTypec` (type
  client × famille → coefficient), lecteurs (`TarArt`, `Facture`, `EdArt3`), mode article piloté
  par `Variables.OrgCoefTypeCli`, groupe `rem` et `Tag` des zones · appelants : aucun · tests :
  aucun · sources : [CoefTypeC.class:_New](../../../../../.src/Gestion/Tables/CoefTypeC.class#L32-L45), [CoefTypeC.class:Form_Open](../../../../../.src/Gestion/Tables/CoefTypeC.class#L47-L72), [CoefTypeC.class:AffProduit](../../../../../.src/Gestion/Tables/CoefTypeC.class#L380-L395)
- [ ] COEFTYPEC-002 — [code mort] Supprimer `CoulZns`/`CoulfOC` et leur calcul, `Frmt` de
  `Form_Open`, `Tab` de `Button2_Click`, `skey` et le commentaire de `Button3_Click`, le second
  `Cdt.SetFocus/Select` de `Maj_TabTypec`, le handler vide `Tabtypec_Select` (événement `Select`,
  jamais appelé dynamiquement : `ReplayObserver` ne rejoue que `_Click`) · appelants : aucun ·
  tests : T01-T05 · sources : [CoefTypeC.class:27](../../../../../.src/Gestion/Tables/CoefTypeC.class#L27), [CoefTypeC.class:28](../../../../../.src/Gestion/Tables/CoefTypeC.class#L28), [CoefTypeC.class:Tabtypec_Select](../../../../../.src/Gestion/Tables/CoefTypeC.class#L114-L120), [CoefTypeC.class:Button2_Click](../../../../../.src/Gestion/Tables/CoefTypeC.class#L275-L294), [CoefTypeC.class:Maj_TabTypec](../../../../../.src/Gestion/Tables/CoefTypeC.class#L74-L96)
- [ ] COEFTYPEC-003 — [réarchitecture] `Cbase.Table("TabCtcli")`, `("TabTypec")`, `("TabFam")` à la
  place des noms en dur de `Quitte_Cdt`, `Quitte_Cdf`, `Button3_Click` (SQL identique) ·
  appelants : aucun · tests : T01-T03 · sources : [CoefTypeC.class:Quitte_Cdt](../../../../../.src/Gestion/Tables/CoefTypeC.class#L202-L227), [CoefTypeC.class:Quitte_Cdf](../../../../../.src/Gestion/Tables/CoefTypeC.class#L229-L255), [CoefTypeC.class:Button3_Click](../../../../../.src/Gestion/Tables/CoefTypeC.class#L302-L332)
- [ ] COEFTYPEC-004 — [réduction de portée] `Maj_TabTypec`, `Cleanchamps`, `Quitte_Cdt`,
  `Quitte_Cdf`, `Quitte_Coeff`, `AffProduit` → `Private` (aucun appel externe, vérifié par
  `grep -rn`) ; `Coltype_Click`, `Colfam_Click`, `Tabtypec_Click` (`replay_dynamic`) inchangés ·
  appelants : aucun · tests : T01-T05 · sources : [CoefTypeC.class:Maj_TabTypec](../../../../../.src/Gestion/Tables/CoefTypeC.class#L74-L96), [CoefTypeC.class:Quitte_Coeff](../../../../../.src/Gestion/Tables/CoefTypeC.class#L257-L273), [CoefTypeC.class:AffProduit](../../../../../.src/Gestion/Tables/CoefTypeC.class#L380-L395)
- [ ] COEFTYPEC-005 — [séparation traitement/GUI] `EnregistreCoef(type, famille, coeff)`,
  `SupprimeCoef(lind)` et `PrixProduit(pa, coeff, tva) As String[]` (calcul pur d'`AffProduit`,
  mêmes chaînes) · appelants : aucun · tests : T01, T02, T04, T05 · sources : [CoefTypeC.class:Button3_Click](../../../../../.src/Gestion/Tables/CoefTypeC.class#L302-L332), [CoefTypeC.class:Button2_Click](../../../../../.src/Gestion/Tables/CoefTypeC.class#L275-L294), [CoefTypeC.class:AffProduit](../../../../../.src/Gestion/Tables/CoefTypeC.class#L380-L395)
- [ ] COEFTYPEC-006 — [commonalisation] Gabarit commun avec `Remisec` (et `Remisecli`) : listes
  type/famille, contrôles `Quitte_*`, enregistrement/suppression, paramétrés par table, colonne
  de valeur et libellés (phase 3, même commit que REMISEC-005) · appelants : aucun · tests :
  T01-T04, REMISEC-T01 à T04 · sources : [CoefTypeC.class:ToggleButton1_Click](../../../../../.src/Gestion/Tables/CoefTypeC.class#L122-L149), [CoefTypeC.class:Quitte_Cdt](../../../../../.src/Gestion/Tables/CoefTypeC.class#L202-L227), [Remisec.class:Quitte_Cdt](../../../../../.src/Gestion/Tables/Remisec.class#L196-L221)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COEFTYPEC-A01 — [anomalie] `Button3_Click` enregistre même si `Quitte_Cdt`/`Quitte_Cdf`/
  `Quitte_Coeff` ont signalé une erreur (type ou famille inexistants, coefficient invalide →
  `NULL`) · tests : T03 · sources : [CoefTypeC.class:311](../../../../../.src/Gestion/Tables/CoefTypeC.class#L311), [CoefTypeC.class:314](../../../../../.src/Gestion/Tables/CoefTypeC.class#L314)
- [ ] COEFTYPEC-A02 — [anomalie] `Variables.OrgCoefTypeCli` n'est jamais remis à vide : après une
  ouverture depuis la fiche article, l'écran ouvert depuis le menu affiche le panneau article
  avec des données périmées · tests : T05 · sources : [CoefTypeC.class:67](../../../../../.src/Gestion/Tables/CoefTypeC.class#L67), [Articles.class:4555](../../../../../.src/Gestion/Tables/Articles.class#L4555)
- [ ] COEFTYPEC-A03 — [anomalie] `Cleanchamps` réinitialise les libellés du panneau article sur
  des contrôles décalés par rapport à `AffProduit` (`Label4` « PA HT : », `Label6` « Coeff : »,
  `Label2` non réinitialisé) · tests : T05 · sources : [CoefTypeC.class:107](../../../../../.src/Gestion/Tables/CoefTypeC.class#L107), [CoefTypeC.class:108](../../../../../.src/Gestion/Tables/CoefTypeC.class#L108), [CoefTypeC.class:109](../../../../../.src/Gestion/Tables/CoefTypeC.class#L109), [CoefTypeC.class:386](../../../../../.src/Gestion/Tables/CoefTypeC.class#L386)
