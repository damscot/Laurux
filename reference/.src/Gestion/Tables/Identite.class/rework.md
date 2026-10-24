# Identite — Rework

> Source : `.src/Gestion/Tables/Identite.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Identite.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 156 |
| Lignes de commentaire | 28 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 6 (`OBS_GotFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 156 | 48 | 6 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IDENTITE-001 — [documentation] En-tête : rôle (formes juridiques et civilités), lecteurs
  (`Fsoc`, `Utils`), commentaire de `Button3_KeyPress` (toute touche enregistre) · appelants :
  aucun · tests : aucun · sources : [Identite.class:20](../../../../../.src/Gestion/Tables/Identite.class#L20), [Identite.class:Button3_KeyPress](../../../../../.src/Gestion/Tables/Identite.class#L143-L147)
- [ ] IDENTITE-002 — [code mort] Supprimer `$bForceKey`, `Quitte_Libeltype` (vide) et son appel,
  le `DELETE` commenté, le `With utils` inutile, le paramètre `hClass` de `SetObservers` ·
  appelants : aucun · tests : T01-T05 · sources : [Identite.class:IsValidKey](../../../../../.src/Gestion/Tables/Identite.class#L171-L176), [Identite.class:Quitte_Libeltype](../../../../../.src/Gestion/Tables/Identite.class#L239-L241), [Identite.class:112](../../../../../.src/Gestion/Tables/Identite.class#L112), [Identite.class:SetObservers](../../../../../.src/Gestion/Tables/Identite.class#L178-L190)
- [ ] IDENTITE-003 — [réarchitecture] `Cbase.Table("TabIdentite")` au lieu du nom en dur dans
  `Form_Open`, `Button2_Click`, `Button3_Click`, `Quitte_Cdtype` (SQL identique) · appelants :
  aucun · tests : T01-T04 · sources : [Identite.class:Form_Open](../../../../../.src/Gestion/Tables/Identite.class#L60-L76), [Identite.class:Button2_Click](../../../../../.src/Gestion/Tables/Identite.class#L102-L118), [Identite.class:Button3_Click](../../../../../.src/Gestion/Tables/Identite.class#L120-L141), [Identite.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Identite.class#L207-L223)
- [ ] IDENTITE-004 — [complexité] `UPdate … SET libelle = &2 WHERE code = &1` ; SQL modifié, dump
  identique · appelants : aucun · tests : T02 · sources : [Identite.class:130](../../../../../.src/Gestion/Tables/Identite.class#L130)
- [ ] IDENTITE-005 — [commonalisation] Socle « table code/libellé » commun (voir CENTRALES-005) ;
  `Quitte_Cdtype` → `Libelle(sTable, sCode)` du socle · appelants : aucun · tests : T01-T05 ·
  sources : [Identite.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Identite.class#L207-L223), [Identite.class:OBS_GotFocus](../../../../../.src/Gestion/Tables/Identite.class#L149-L159), [Centrales.class:Button3_Click](../../../../../.src/Gestion/Tables/Centrales.class#L110-L129)
- [ ] IDENTITE-006 — [séparation traitement/GUI] `EnregistreIdentite`, `SupprimeIdentite`,
  `LibelleIdentite(sCode) As String` sans contrôle (si le socle n'est pas retenu) · appelants :
  aucun · tests : T01-T04 · sources : [Identite.class:Button2_Click](../../../../../.src/Gestion/Tables/Identite.class#L102-L118), [Identite.class:Button3_Click](../../../../../.src/Gestion/Tables/Identite.class#L120-L141), [Identite.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Identite.class#L207-L223)
- [ ] IDENTITE-007 — [réduction de portée] `Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`,
  `Quitte_Cdtype`, `Quitte_Libeltype` → `Private` ; `Coltype_Click` reste `Public` (rejeu) ·
  appelants : aucun · tests : T01-T05 · sources : [Identite.class:Refresh](../../../../../.src/Gestion/Tables/Identite.class#L84-L91), [Identite.class:Maj_Zones](../../../../../.src/Gestion/Tables/Identite.class#L93-L100), [Identite.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Identite.class#L207-L223)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IDENTITE-A01 — [anomalie] `SELECT … WHERE code = '<code>'` par concaténation dans
  `Button3_Click` et `Quitte_Cdtype` : une apostrophe provoque une erreur SQL · tests : T05 ·
  sources : [Identite.class:128](../../../../../.src/Gestion/Tables/Identite.class#L128), [Identite.class:214](../../../../../.src/Gestion/Tables/Identite.class#L214)
- [ ] IDENTITE-A02 — [anomalie] L'aide (bouton et F1) ouvre la page `Familles` au lieu d'une page
  propre à l'écran · tests : aucun · sources : [Identite.class:254](../../../../../.src/Gestion/Tables/Identite.class#L254)
