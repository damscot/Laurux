# Sdepots — Rework

> Source : `.src/Gestion/Depots/Sdepots.class` · Message de commit (phase 4) : `reference/.src/Gestion/Depots/Sdepots.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 307 |
| Lignes de commentaire | 13 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 83 |
| Complexité max (fonction) | 13 (`Rcpt_keypress`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 307 | 83 | 13 | 0 | 21 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SDEPOTS-001 — [documentation] En-tête (absent) : rôle (sorties manuelles hors magasin),
  tables mises à jour, suppression de la ligne de stock à 0, absence d'instrumentation · appelants :
  aucun · tests : aucun · sources : [Sdepots.class:_new](../../../../../.src/Gestion/Depots/Sdepots.class#L8-L39), [Sdepots.class:Maj_Qtedep](../../../../../.src/Gestion/Depots/Sdepots.class#L373-L398)
- [ ] SDEPOTS-002 — [code mort] Supprimer `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`
  (handlers inactifs, `Code` groupé dans `Rcpt`), `Dep_KeyPress` (groupe `Dep` absent du `.form`),
  `Coulfond` et `Tri` (affectés, jamais lus) · appelants : aucun · tests : T01-T05 · sources : [Sdepots.class:Code_KeyPress](../../../../../.src/Gestion/Depots/Sdepots.class#L97-L112), [Sdepots.class:Code_GotFocus](../../../../../.src/Gestion/Depots/Sdepots.class#L114-L118), [Sdepots.class:Code_LostFocus](../../../../../.src/Gestion/Depots/Sdepots.class#L120-L124), [Sdepots.class:Dep_KeyPress](../../../../../.src/Gestion/Depots/Sdepots.class#L281-L307), [Sdepots.class:3](../../../../../.src/Gestion/Depots/Sdepots.class#L3)
- [ ] SDEPOTS-003 — [séparation traitement/GUI] `SortieDepot(sDepot, sArt, fQte, sDate)` sans
  contrôle (SQL identique) · appelants : aucun · tests : T01, T02 · sources : [Sdepots.class:Maj_Qtedep](../../../../../.src/Gestion/Depots/Sdepots.class#L373-L398), [Sdepots.class:Button1_Click](../../../../../.src/Gestion/Depots/Sdepots.class#L315-L333)
- [ ] SDEPOTS-004 — [commonalisation] Module `Depot` partagé avec MvtDepots, ImpDepots, Depots
  (voir MVTDEPOTS-004) · appelants : aucun · tests : T01-T05 · sources : [Sdepots.class:aff_Depot](../../../../../.src/Gestion/Depots/Sdepots.class#L65-L79), [Sdepots.class:Cman](../../../../../.src/Gestion/Depots/Sdepots.class#L126-L142), [Sdepots.class:Maj_Colrcp](../../../../../.src/Gestion/Depots/Sdepots.class#L335-L368)
- [ ] SDEPOTS-005 — [réduction de portée] `aff_Depot`, `Cman`, `art_man`, `Maj_Colrcp`,
  `Maj_Qtedep`, `B` → `Private` ; `Coldep_Click`, `Coldepa_Click` restent `Public` (rejeu) ·
  appelants : aucun · tests : T01-T05 · sources : [Sdepots.class:6](../../../../../.src/Gestion/Depots/Sdepots.class#L6), [Sdepots.class:art_man](../../../../../.src/Gestion/Depots/Sdepots.class#L257-L279)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SDEPOTS-A01 — [anomalie] `ToggleButton2_Click` : `Start.Soc` inexistant (IMPRESSION-A03) →
  erreur à chaque ouverture de la liste des articles du dépôt ; la supprimer rend la liste
  fonctionnelle · tests : T04 · sources : [Sdepots.class:218](../../../../../.src/Gestion/Depots/Sdepots.class#L218)
- [ ] SDEPOTS-A02 — [anomalie] Sortie supérieure au stock : la ligne de stock est supprimée sans
  avertissement ; article sans ligne de stock : aucune sortie ni message ; drapeau `b` remis à vrai
  par `Maj_Colrcp` · tests : T02, T05 · sources : [Sdepots.class:387](../../../../../.src/Gestion/Depots/Sdepots.class#L387), [Sdepots.class:390](../../../../../.src/Gestion/Depots/Sdepots.class#L390), [Sdepots.class:344](../../../../../.src/Gestion/Depots/Sdepots.class#L344)
- [ ] SDEPOTS-A03 — [anomalie] `db.Exec` (classe `DB`, connexion courante) au lieu de
  `Utils.db.Exec` : requêtes non journalisées ni traduites pour SQLite · tests : T01 (SQLite) ·
  sources : [Sdepots.class:226](../../../../../.src/Gestion/Depots/Sdepots.class#L226), [Sdepots.class:262](../../../../../.src/Gestion/Depots/Sdepots.class#L262)
- [ ] SDEPOTS-A04 — [anomalie] Écran non instrumenté (`Utils.Observers` absent) : l'ajouter change
  le log de rejeu et les couleurs · tests : T01 · sources : [Sdepots.class:_new](../../../../../.src/Gestion/Depots/Sdepots.class#L8-L39)
