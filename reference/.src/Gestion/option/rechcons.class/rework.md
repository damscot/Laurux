# rechcons — Rework

> Source : `.src/Gestion/option/rechcons.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/rechcons.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 73 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 8 (`GridView1_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 73 | 18 | 8 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECHCONS-001 — [documentation] En-tête : rôle, valeurs de `choix` (`T`, `P`, `C`, `B`),
  événement `trouver`, appelants · appelants : aucun · tests : T01-T03 · sources : [rechcons.class:_new](../../../../../.src/Gestion/option/rechcons.class#L8-L31)
- [ ] RECHCONS-002 — [code mort] Supprimer `rechcons_KeyPress` (jamais levé) et le bloc
  `If $rescons.Available Then … Endif` vide de `_new` · appelants : aucun · tests : T01-T03 ·
  sources : [rechcons.class:rechcons_KeyPress](../../../../../.src/Gestion/option/rechcons.class#L86-L90), [rechcons.class:25](../../../../../.src/Gestion/option/rechcons.class#L25)
- [ ] RECHCONS-003 — [séparation traitement/GUI] Fonction privée `Filtrer(colonne, texte) As
  Result` utilisée par `_new`, `Textcode_Change`, `Texlib_Change` (SQL identique) · appelants :
  aucun · tests : T01, T02 · sources : [rechcons.class:Textcode_Change](../../../../../.src/Gestion/option/rechcons.class#L64-L73), [rechcons.class:Texlib_Change](../../../../../.src/Gestion/option/rechcons.class#L75-L84)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RECHCONS-A01 — [anomalie] Fenêtre non journalisée (`Utils.Observers(Me)` absent) : à ajouter
  pour permettre le rejeu (change le journal, voir SUPPRART-A06) · tests : T04 · sources : [rechcons.class:_new](../../../../../.src/Gestion/option/rechcons.class#L8-L31)
