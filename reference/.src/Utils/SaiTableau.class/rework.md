# SaiTableau — Rework

> Source : `.src/Utils/SaiTableau.class` · Message de commit (phase 4) : `reference/.src/Utils/SaiTableau.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 284 |
| Lignes de commentaire | 2 |
| Fonctions | 19 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 9 (`ligne_SupLig`) |
| Variables globales | 0 |
| Variables Public | 19 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 284 | 67 | 9 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAITABLEAU-001 — [documentation] En-tête de classe (rôle, cycle `Visible*` → `show` → `ajout`,
  événements relayés, contrat avec les héritiers) ; documenter que `$prop`/`$parent` sont publics
  · appelants : aucun · tests : aucun · sources : [SaiTableau.class:_new](../../../../.src/Utils/SaiTableau.class#L37-L49), [SaiTableau.class:show](../../../../.src/Utils/SaiTableau.class#L63-L136)
- [ ] SAITABLEAU-002 — [code mort] Supprimer `Pentete_Scroll` (jamais déclenché), la locale `obj`
  inutilisée d'`ajout`, la ligne commentée d'`ligne_InsLig`, la variable `lg` inutilisée d'`Extract`
  · tests : T01-T06 · sources : [SaiTableau.class:Pentete_Scroll](../../../../.src/Utils/SaiTableau.class#L138-L142), [SaiTableau.class:ajout](../../../../.src/Utils/SaiTableau.class#L144-L158), [SaiTableau.class:ligne_InsLig](../../../../.src/Utils/SaiTableau.class#L286-L305), [SaiTableau.class:Extract](../../../../.src/Utils/SaiTableau.class#L176-L193)
- [ ] SAITABLEAU-003 — [commonalisation] Helpers privés `Echange(i, j)` et `Recolorie(depuis)` pour
  `ligne_Haut`, `ligne_Bas`, `ligne_SupLig`, `ligne_InsLig`, `ajout` (couleurs identiques) · tests :
  T02, T04, T07 · sources : [SaiTableau.class:ligne_Haut](../../../../.src/Utils/SaiTableau.class#L307-L330), [SaiTableau.class:ligne_Bas](../../../../.src/Utils/SaiTableau.class#L332-L355), [SaiTableau.class:ligne_SupLig](../../../../.src/Utils/SaiTableau.class#L262-L284), [SaiTableau.class:ligne_InsLig](../../../../.src/Utils/SaiTableau.class#L286-L305), [SaiTableau.class:ajout](../../../../.src/Utils/SaiTableau.class#L144-L158)
- [ ] SAITABLEAU-004 — [complexité] `show` : une fonction privée `CreLigneFixe(type, alignement)` pour
  l'en-tête et les totaux · tests : T01 · sources : [SaiTableau.class:show](../../../../.src/Utils/SaiTableau.class#L63-L136)
- [ ] SAITABLEAU-005 — [réduction de portée] `Extract`, `entete`, `total`, `pchoix`, `tuto`,
  `Pentete`, `Ptot` → `Private` (aucun usage externe ni héritier, vérifié par grep) · appelants :
  aucun · tests : T01-T08 · sources : [SaiTableau.class:Extract](../../../../.src/Utils/SaiTableau.class#L176-L193), [SaiTableau.class:12-22](../../../../.src/Utils/SaiTableau.class#L12-L22)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAITABLEAU-A01 — [anomalie] `ligne_InsLig:288` : la ligne est créée par `Dim … As New` avant le
  test d'état (panneau orphelin en lecture) ; elle ne lève pas `ajou` · tests : T05, T07 · sources : [SaiTableau.class:288](../../../../.src/Utils/SaiTableau.class#L288), [SaiTableau.class:ligne_InsLig](../../../../.src/Utils/SaiTableau.class#L286-L305)
- [ ] SAITABLEAU-A02 — [anomalie] Défilement de l'en-tête non synchronisé (`Pentete` sans nom
  d'événement, `tableau_Scroll` absent) · tests : T01 · sources : [SaiTableau.class:98](../../../../.src/Utils/SaiTableau.class#L98), [SaiTableau.class:Pentete_Scroll](../../../../.src/Utils/SaiTableau.class#L138-L142)
- [ ] SAITABLEAU-A03 — [anomalie] `Extract` ne recalcule pas l'alternance des couleurs (différent de
  `ligne_SupLig`) · tests : T03 · sources : [SaiTableau.class:Extract](../../../../.src/Utils/SaiTableau.class#L176-L193), [SaiTableau.class:ligne_SupLig](../../../../.src/Utils/SaiTableau.class#L262-L284)
