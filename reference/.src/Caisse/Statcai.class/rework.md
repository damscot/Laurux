# Statcai — Rework

> Source : `.src/Caisse/Statcai.class` · Message de commit (phase 4) : `reference/.src/Caisse/Statcai.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 146 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 17 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 146 | 31 | 17 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATCAI-001 — [documentation] En-tête en français : rôle, bornage 8 h-19 h, table de
  travail `Total` et ses autres utilisateurs, anomalies A01-A03 signalées · appelants : aucun ·
  tests : T01-T05 · sources : [Statcai.class:Recup_ca](../../../../.src/Caisse/Statcai.class#L83-L138), [Statcai.class:Traitement](../../../../.src/Caisse/Statcai.class#L140-L193)
- [ ] STATCAI-002 — [code mort] Supprimer le membre `Tot` (jamais relu), le test
  `If IsNull(vah)` (toujours faux) ; tables en dur → `Cbase.Table("TabEntTck")` /
  `Cbase.Table("TabHisEntTck")` (SQL identique) · appelants : aucun · tests : T01 · sources : [Statcai.class:33](../../../../.src/Caisse/Statcai.class#L33), [Statcai.class:107](../../../../.src/Caisse/Statcai.class#L107), [Statcai.class:158](../../../../.src/Caisse/Statcai.class#L158)
- [ ] STATCAI-003 — [complexité] `Traitement` : colonne = `heure - 7` au lieu du `Select Case`
  de 12 cas (CC 17 → ≤ 5 visé) · appelants : aucun · tests : T01 · sources : [Statcai.class:Traitement](../../../../.src/Caisse/Statcai.class#L140-L193)
- [ ] STATCAI-004 — [séparation traitement/GUI] Extraire `CaHoraire(dJour) As Collection`
  (alimentation de `Total` et relecture, sans `DateBox1` ni `Liste`) et un remplissage de grille
  séparé · appelants : aucun · tests : T01, T06 · sources : [Statcai.class:Recup_ca](../../../../.src/Caisse/Statcai.class#L83-L138), [Statcai.class:Traitement](../../../../.src/Caisse/Statcai.class#L140-L193)
- [ ] STATCAI-005 — [réduction de portée] `Recup_ca`, `Traitement` → `Private` (aucun appelant
  externe, vérifié par `grep`) · appelants : aucun · tests : T01-T05 · sources : [Statcai.class:Recup_ca](../../../../.src/Caisse/Statcai.class#L83-L138), [Statcai.class:Traitement](../../../../.src/Caisse/Statcai.class#L140-L193)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATCAI-A01 — [anomalie] `statut IN(&2)` reçoit la chaîne `"V","0"` : `Subst` la cite comme
  une seule valeur, aucun ticket en cours (`Fiches_EntTicketz`) n'est compté ; seul le CA archivé
  apparaît. Correction : `statut IN (&2, &3)` avec deux arguments · tests : T02 · sources : [Statcai.class:109](../../../../.src/Caisse/Statcai.class#L109)
- [ ] STATCAI-A02 — [anomalie] `HOUR()` n'est pas traduit pour SQLite par `DB_Connection.Exec` :
  l'écran est inutilisable sur une base SQLite (message « problème sur une ligne de CA ») ;
  correction dans la traduction (`strftime('%H', …)`) ou dans la requête · tests : T05 · sources : [Statcai.class:109](../../../../.src/Caisse/Statcai.class#L109)
- [ ] STATCAI-A03 — [anomalie] `union` au lieu de `union all` : une ligne (heure, CA) identique
  dans les tickets en cours et archivés n'est comptée qu'une fois (visible seulement après A01) ·
  tests : T03 · sources : [Statcai.class:109](../../../../.src/Caisse/Statcai.class#L109)
- [ ] STATCAI-A04 — [anomalie] Table de travail `Total` détruite et recréée sous un nom partagé
  avec les statistiques de `.src/Statistiques` (structures différentes) : exécutions simultanées
  (deux postes ou deux écrans) incohérentes ; un nom propre ou une table temporaire change le
  dump · tests : T01 · sources : [Statcai.class:96](../../../../.src/Caisse/Statcai.class#L96), [Statcai.class:98](../../../../.src/Caisse/Statcai.class#L98), [StatTypCli.class:188](../../../../.src/Statistiques/StatTypCli.class#L188)
- [ ] STATCAI-A05 — [anomalie] Les erreurs de calcul sont signalées par `Message.Info` (icône
  d'information) au lieu de `Message.Error` · tests : T05 · sources : [Statcai.class:136](../../../../.src/Caisse/Statcai.class#L136)
