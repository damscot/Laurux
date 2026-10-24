# Agenda — Rework

> Source : `.src/Utils/Agenda.class` · Message de commit (phase 4) : `reference/.src/Utils/Agenda.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 116 |
| Lignes de commentaire | 16 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 5 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 116 | 23 | 5 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] AGENDA-001 — [documentation] En-tête : rôle de l'écran, structure de `Fiches_Agenda`,
  format des créneaux · appelants : aucun · tests : T01-T04 · sources : [Agenda.class:_New](../../../../.src/Utils/Agenda.class#L8-L16)
- [ ] AGENDA-002 — [code mort] Supprimer l'ancienne `Ecr_action` commentée, la variable
  `Date_action`, l'affectation `V1.Text = ""` et l'appel redondant à `Init()` dans `_New` ·
  appelants : aucun · tests : T01, T04 · sources : [Agenda.class:92-100](../../../../.src/Utils/Agenda.class#L92-L100), [Agenda.class:Maj_Zones](../../../../.src/Utils/Agenda.class#L116-L138), [Agenda.class:Timer2_Timer](../../../../.src/Utils/Agenda.class#L18-L23)
- [ ] AGENDA-003 — [commonalisation] `Format$(DateChooser1.Value, "yyyy-mm-dd")` →
  `LDate(DateChooser1.Value).D` ; helper privé `Heure()` pour l'horloge · appelants : aucun ·
  tests : T01-T04 · sources : [Agenda.class:Ecr_action](../../../../.src/Utils/Agenda.class#L102-L113), [Agenda.class:Timer2_Timer](../../../../.src/Utils/Agenda.class#L18-L23)
- [ ] AGENDA-004 — [séparation traitement/GUI] Fonctions SQL pures `EnregistrerAction(jour,
  creneau, texte, user)` et `LireActions(jour)` appelées par `Ecr_action`/`Maj_Zones` (requêtes
  identiques, filtres inchangés) · appelants : aucun · tests : T01-T04 · sources : [Agenda.class:Ecr_action](../../../../.src/Utils/Agenda.class#L102-L113), [Agenda.class:Maj_Zones](../../../../.src/Utils/Agenda.class#L116-L138)
- [ ] AGENDA-005 — [complexité] `Maj_Zones` : `Available` au lieu de `Count > 0`, recherche du
  créneau par `Collection` libellé → ligne · appelants : aucun · tests : T02, T03, T04 · sources : [Agenda.class:Maj_Zones](../../../../.src/Utils/Agenda.class#L116-L138)
- [ ] AGENDA-006 — [réduction de portée] `Init`, `Ecr_action`, `Maj_Zones` → `Private` ·
  appelants : aucun · tests : T01-T04 · sources : [Agenda.class:Init](../../../../.src/Utils/Agenda.class#L25-L52), [Agenda.class:Ecr_action](../../../../.src/Utils/Agenda.class#L102-L113), [Agenda.class:Maj_Zones](../../../../.src/Utils/Agenda.class#L116-L138)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] AGENDA-A01 — [anomalie] `Ecr_action` : l'`UPDATE` ne filtre pas sur `nuser` et modifie les
  actions de tous les utilisateurs pour le créneau · tests : T03 · sources : [Agenda.class:110](../../../../.src/Utils/Agenda.class#L110)
- [ ] AGENDA-A02 — [anomalie] `Maj_Zones` affiche les actions de tous les utilisateurs (pas de
  filtre `nuser`), alors que l'existence est testée par utilisateur ; une seule action visible par
  créneau (la dernière lue) · tests : T03 · sources : [Agenda.class:124](../../../../.src/Utils/Agenda.class#L124)
- [ ] AGENDA-A03 — [anomalie] Quantième et semaine affichés pour la date du jour, pas pour la date
  sélectionnée · tests : manuel · sources : [Agenda.class:48-49](../../../../.src/Utils/Agenda.class#L48-L49)
- [ ] AGENDA-A04 — [anomalie] Bouton météo pointant vers un site local
  (`meteolafleche.com`) ; à remplacer ou retirer (modification du `.form` exclue : seule l'URL peut
  changer) · tests : manuel · sources : [Agenda.class:180](../../../../.src/Utils/Agenda.class#L180)
