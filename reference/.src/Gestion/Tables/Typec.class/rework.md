# Typec — Rework

> Source : `.src/Gestion/Tables/Typec.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Typec.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 143 |
| Lignes de commentaire | 26 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 47 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 143 | 47 | 6 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TYPEC-001 — [documentation] En-tête corrigé (« Typeco.class » → Typec), rôle (types clients
  pour tarifs et remises), liste des tables utilisatrices · appelants : aucun · tests : aucun ·
  sources : [Typec.class:21](../../../../../.src/Gestion/Tables/Typec.class#L21)
- [ ] TYPEC-002 — [code mort] Supprimer `$bForceKey`, `Quitte_Cdtype`/`Quitte_Libeltype` (vides) et
  leurs appels, le `With utils`, le paramètre `hClass` de `SetObservers` · appelants : aucun ·
  tests : T01-T04 · sources : [Typec.class:IsValidKey](../../../../../.src/Gestion/Tables/Typec.class#L168-L173), [Typec.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Typec.class#L204-L206), [Typec.class:Quitte_Libeltype](../../../../../.src/Gestion/Tables/Typec.class#L222-L224), [Typec.class:SetObservers](../../../../../.src/Gestion/Tables/Typec.class#L175-L187)
- [ ] TYPEC-003 — [réarchitecture] `Cbase.Table("TabTypec")` au lieu du nom en dur (SQL identique) ·
  appelants : aucun · tests : T01-T03 · sources : [Typec.class:Form_Open](../../../../../.src/Gestion/Tables/Typec.class#L60-L75), [Typec.class:Button2_Click](../../../../../.src/Gestion/Tables/Typec.class#L100-L115), [Typec.class:Button3_Click](../../../../../.src/Gestion/Tables/Typec.class#L117-L138)
- [ ] TYPEC-004 — [complexité] `UPdate … SET libelle = &2 WHERE code = &1` ; SQL modifié, dump
  identique · appelants : aucun · tests : T02 · sources : [Typec.class:127](../../../../../.src/Gestion/Tables/Typec.class#L127)
- [ ] TYPEC-005 — [commonalisation] Socle « table code/libellé » commun (voir CENTRALES-005) ·
  appelants : aucun · tests : T01-T04 · sources : [Typec.class:Form_Open](../../../../../.src/Gestion/Tables/Typec.class#L60-L75), [Typec.class:OBS_GotFocus](../../../../../.src/Gestion/Tables/Typec.class#L146-L156), [Typec.class:OBS_LostFocus](../../../../../.src/Gestion/Tables/Typec.class#L158-L166)
- [ ] TYPEC-006 — [séparation traitement/GUI] `EnregistreTypec`, `SupprimeTypec` sans contrôle
  (si le socle n'est pas retenu) · appelants : aucun · tests : T01-T03 · sources : [Typec.class:Button2_Click](../../../../../.src/Gestion/Tables/Typec.class#L100-L115), [Typec.class:Button3_Click](../../../../../.src/Gestion/Tables/Typec.class#L117-L138)
- [ ] TYPEC-007 — [réduction de portée] `Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`,
  `Quitte_Cdtype`, `Quitte_Libeltype` → `Private` ; `Coltype_Click` reste `Public` (rejeu) ·
  appelants : aucun · tests : T01-T04 · sources : [Typec.class:Refresh](../../../../../.src/Gestion/Tables/Typec.class#L83-L90), [Typec.class:Maj_Zones](../../../../../.src/Gestion/Tables/Typec.class#L92-L98), [Typec.class:SetObservers](../../../../../.src/Gestion/Tables/Typec.class#L175-L187)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TYPEC-A01 — [anomalie] `SELECT … WHERE code = '<code>'` concaténé (apostrophe → erreur SQL) ·
  tests : T04 · sources : [Typec.class:125](../../../../../.src/Gestion/Tables/Typec.class#L125)
- [ ] TYPEC-A02 — [anomalie] Suppression de `Coltype.Current[0]` au lieu du code saisi (erreur sans
  sélection) et sans contrôle d'usage (remises/coefficients par type, fiches clients) : données
  orphelines · tests : T03 · sources : [Typec.class:110](../../../../../.src/Gestion/Tables/Typec.class#L110)
