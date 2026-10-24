# Statut — Rework

> Source : `.src/Gestion/Tables/Statut.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Statut.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 136 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 136 | 47 | 6 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATUT-001 — [documentation] En-tête : rôle (statuts clients), lecteurs (`FClient`,
  `Emailing`…), ouverture par `EmailingCarte` via `Visible` · appelants : aucun · tests : aucun ·
  sources : [Statut.class:20](../../../../../.src/Gestion/Tables/Statut.class#L20), [EmailingCarte.class:649](../../../../../.src/Gestion/Mails/EmailingCarte.class#L649)
- [ ] STATUT-002 — [code mort] Supprimer `$bForceKey`, `Quitte_Cdtype`/`Quitte_Libeltype` (vides)
  et leurs appels, le `With utils`, le paramètre `hClass` de `SetObservers` · appelants : aucun ·
  tests : T01-T03 · sources : [Statut.class:IsValidKey](../../../../../.src/Gestion/Tables/Statut.class#L161-L166), [Statut.class:Quitte_Cdtype](../../../../../.src/Gestion/Tables/Statut.class#L197-L199), [Statut.class:Quitte_Libeltype](../../../../../.src/Gestion/Tables/Statut.class#L215-L217), [Statut.class:SetObservers](../../../../../.src/Gestion/Tables/Statut.class#L168-L180)
- [ ] STATUT-003 — [complexité] `UPdate … SET libelle = &2 WHERE code = &1` ; SQL modifié, dump
  identique · appelants : aucun · tests : T02 · sources : [Statut.class:120](../../../../../.src/Gestion/Tables/Statut.class#L120)
- [ ] STATUT-004 — [commonalisation] Socle « table code/libellé » commun (voir CENTRALES-005) ·
  appelants : aucun · tests : T01-T04 · sources : [Statut.class:Form_Open](../../../../../.src/Gestion/Tables/Statut.class#L60-L73), [Statut.class:Button2_Click](../../../../../.src/Gestion/Tables/Statut.class#L98-L110), [Statut.class:Button3_Click](../../../../../.src/Gestion/Tables/Statut.class#L112-L131), [Statut.class:OBS_GotFocus](../../../../../.src/Gestion/Tables/Statut.class#L139-L149)
- [ ] STATUT-005 — [séparation traitement/GUI] `EnregistreStatut`, `SupprimeStatut` sans contrôle
  (si le socle n'est pas retenu) · appelants : aucun · tests : T01-T03 · sources : [Statut.class:Button2_Click](../../../../../.src/Gestion/Tables/Statut.class#L98-L110), [Statut.class:Button3_Click](../../../../../.src/Gestion/Tables/Statut.class#L112-L131)
- [ ] STATUT-006 — [réduction de portée] `Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`,
  `Quitte_Cdtype`, `Quitte_Libeltype` → `Private` ; `Coltype_Click` reste `Public` (rejeu) ·
  appelants : aucun · tests : T01-T04 · sources : [Statut.class:Refresh](../../../../../.src/Gestion/Tables/Statut.class#L81-L88), [Statut.class:Maj_Zones](../../../../../.src/Gestion/Tables/Statut.class#L90-L96), [Statut.class:SetObservers](../../../../../.src/Gestion/Tables/Statut.class#L168-L180)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATUT-A01 — [anomalie] `SELECT … WHERE code = '<code>'` concaténé (apostrophe → erreur SQL) ·
  tests : CENTRALES-T04 (scénario transposé) · sources : [Statut.class:118](../../../../../.src/Gestion/Tables/Statut.class#L118)
- [ ] STATUT-A02 — [anomalie] Suppression de `Coltype.Current[0]` au lieu du code saisi ; erreur
  sans sélection ; aucun contrôle d'usage dans les fiches clients · tests : T03 · sources : [Statut.class:105](../../../../../.src/Gestion/Tables/Statut.class#L105)
