# Fusers — Rework

> Source : `.src/Communs/Fusers.class` · Message de commit (phase 4) : `reference/.src/Communs/Fusers.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 75 |
| Lignes de commentaire | 2 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 4 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 75 | 15 | 4 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FUSERS-001 — [documentation] En-tête en français : rôle (utilisateurs de la gestion des
  tâches), table `Fiches_Users`, lecteur `Facture` · appelants : aucun · tests : aucun · sources : [Fusers.class:_New](../../../../.src/Communs/Fusers.class#L6-L30)
- [ ] FUSERS-002 — [code mort] Supprimer `CoulZns`/`CoulFoc` et leurs deux lectures de couleur
  (jamais utilisées) · appelants : aucun · tests : T01 · sources : [Fusers.class:3](../../../../.src/Communs/Fusers.class#L3), [Fusers.class:_New](../../../../.src/Communs/Fusers.class#L6-L30)
- [ ] FUSERS-003 — [séparation traitement/GUI] `Charger()` (SQL + remplissage) appelé par
  `Form_Open` et `Refresh` au lieu de rappeler le handler ; `EnregistrerUtilisateur(nom, poste)`
  et `SupprimerUtilisateur(nom)` sans accès aux contrôles (SQL identique) · appelants : aucun ·
  tests : T01 à T06, T08 · sources : [Fusers.class:Form_Open](../../../../.src/Communs/Fusers.class#L32-L46), [Fusers.class:Refresh](../../../../.src/Communs/Fusers.class#L81-L87), [Fusers.class:Button3_Click](../../../../.src/Communs/Fusers.class#L62-L79), [Fusers.class:Button2_Click](../../../../.src/Communs/Fusers.class#L95-L107)
- [ ] FUSERS-004 — [réduction de portée] `MajZones`, `Refresh` → `Private` (aucun appelant
  externe ; couverts par replay) · appelants : aucun · tests : T03, T05 · sources : [Fusers.class:MajZones](../../../../.src/Communs/Fusers.class#L48-L54), [Fusers.class:Refresh](../../../../.src/Communs/Fusers.class#L81-L87)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FUSERS-A01 — [anomalie] `Button3_Click` : `SELECT … WHERE nom = '` & texte & `'` par
  concaténation (règle AGENTS.md n° 1) ; une apostrophe provoque une erreur SQL. Paramétrer (`&1`)
  change le résultat pour ces noms · tests : T07 · sources : [Fusers.class:67](../../../../.src/Communs/Fusers.class#L67)
- [ ] FUSERS-A02 — [anomalie] `UPdate … SET nom = &1 … WHERE nom = &1` : le renommage est
  impossible (une nouvelle ligne est créée) et toutes les lignes homonymes sont modifiées · tests : T03, T04 · sources : [Fusers.class:69](../../../../.src/Communs/Fusers.class#L69)
- [ ] FUSERS-A03 — [anomalie] `Button2_Click` supprime `Coluser.Current[0]` (ligne sélectionnée)
  et non le nom saisi ; sans sélection, `Current` est `Null` (erreur à confirmer) · tests : T05, T06 · sources : [Fusers.class:102](../../../../.src/Communs/Fusers.class#L102)
- [ ] FUSERS-A04 — [anomalie] `Utils.Observers(Me)` appelé deux fois (observateurs et
  `ReplayObserver` doublés) ; le bouton `Button1` « Doc HTML » n'a pas de handler (aide
  inaccessible). Retirer le doublon peut changer les journaux de replay · tests : T01 · sources : [Fusers.class:14](../../../../.src/Communs/Fusers.class#L14), [Fusers.class:19](../../../../.src/Communs/Fusers.class#L19)
