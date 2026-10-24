# Centrales — Rework

> Source : `.src/Gestion/Tables/Centrales.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Centrales.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 27 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 135 | 47 | 6 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CENTRALES-001 — [documentation] En-tête : rôle, tables utilisatrices (articles,
  fournisseurs), effet de `Button3_KeyPress` (toute touche enregistre) et de `Button1_Click` vide ·
  appelants : aucun · tests : aucun · sources : [Centrales.class:20](../../../../../.src/Gestion/Tables/Centrales.class#L20), [Centrales.class:Button3_KeyPress](../../../../../.src/Gestion/Tables/Centrales.class#L131-L135), [Centrales.class:Button1_Click](../../../../../.src/Gestion/Tables/Centrales.class#L226-L229)
- [ ] CENTRALES-002 — [code mort] Supprimer `$bForceKey` (jamais affecté), `Quitte_Cdtype` et
  `Quitte_Libeltype` (vides) et leurs appels dans les deux `*_LostFocus` (handlers conservés), le
  `With utils` inutile ; supprimer le paramètre inutilisé `hClass` de `SetObservers` · appelants :
  aucun · tests : T01-T05 · sources : [Centrales.class:IsValidKey](../../../../../.src/Gestion/Tables/Centrales.class#L159-L164), [Centrales.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Centrales.class#L195-L197), [Centrales.class:Quitte_Libeltype](../../../../../.src/Gestion/Tables/Centrales.class#L213-L215), [Centrales.class:SetObservers](../../../../../.src/Gestion/Tables/Centrales.class#L166-L178)
- [ ] CENTRALES-003 — [complexité] `UPdate … SET libelle = &2 WHERE code = &1` (la clé n'est plus
  réécrite) ; SQL modifié, dump identique · appelants : aucun · tests : T02 · sources : [Centrales.class:118](../../../../../.src/Gestion/Tables/Centrales.class#L118)
- [ ] CENTRALES-004 — [séparation traitement/GUI] `EnregistreCentrale(sCode, sLib)` et
  `SupprimeCentrale(sCode)` sans contrôle (SQL inchangé, concaténation conservée jusqu'à A01) ·
  appelants : aucun · tests : T01-T04 · sources : [Centrales.class:Button2_Click](../../../../../.src/Gestion/Tables/Centrales.class#L96-L108), [Centrales.class:Button3_Click](../../../../../.src/Gestion/Tables/Centrales.class#L110-L129)
- [ ] CENTRALES-005 — [commonalisation] Socle « table code/libellé » partagé avec Identite, Statut
  et Typec (chargement, existence, enregistrement, suppression, couleurs `OBS_*`, `SetObservers`) ;
  remplace CENTRALES-004 si le socle est créé en phase 3 · appelants : aucun · tests : T01-T05,
  IDENTITE-T01-T05, STATUT-T01-T04, TYPEC-T01-T04 · sources : [Centrales.class:Form_Open](../../../../../.src/Gestion/Tables/Centrales.class#L58-L71), [Centrales.class:OBS_GotFocus](../../../../../.src/Gestion/Tables/Centrales.class#L137-L147), [Centrales.class:OBS_LostFocus](../../../../../.src/Gestion/Tables/Centrales.class#L149-L157), [Identite.class:Form_Open](../../../../../.src/Gestion/Tables/Identite.class#L60-L76), [Statut.class:Form_Open](../../../../../.src/Gestion/Tables/Statut.class#L60-L73), [Typec.class:Form_Open](../../../../../.src/Gestion/Tables/Typec.class#L60-L75)
- [ ] CENTRALES-006 — [réduction de portée] `Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`,
  `Quitte_Cdtype`, `Quitte_Libeltype` → `Private` (si non supprimés par 002) ; `Coltype_Click`
  reste `Public` (rejeu) · appelants : aucun · tests : T01-T05 · sources : [Centrales.class:Refresh](../../../../../.src/Gestion/Tables/Centrales.class#L79-L86), [Centrales.class:Maj_Zones](../../../../../.src/Gestion/Tables/Centrales.class#L88-L94), [Centrales.class:IsValidKey](../../../../../.src/Gestion/Tables/Centrales.class#L159-L164), [Centrales.class:SetObservers](../../../../../.src/Gestion/Tables/Centrales.class#L166-L178)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CENTRALES-A01 — [anomalie] `SELECT … WHERE code = '<code>'` par concaténation : une
  apostrophe dans le code provoque une erreur SQL (règle AGENTS.md n° 1) ; paramétrer `&1` ·
  tests : T04 · sources : [Centrales.class:116](../../../../../.src/Gestion/Tables/Centrales.class#L116)
- [ ] CENTRALES-A02 — [anomalie] Suppression : le test porte sur `Cdtype.Text` mais le `DELETE`
  utilise `Coltype.Current[0]` (ligne sélectionnée) ; sans sélection, erreur `Null` ; Identite
  utilise le code saisi · tests : T03 · sources : [Centrales.class:103](../../../../../.src/Gestion/Tables/Centrales.class#L103)
- [ ] CENTRALES-A03 — [anomalie] Suppression sans contrôle d'usage (articles, fournisseurs
  rattachés à la centrale ; colonne exacte à confirmer) · tests : T03 · sources : [Centrales.class:Button2_Click](../../../../../.src/Gestion/Tables/Centrales.class#L96-L108)
