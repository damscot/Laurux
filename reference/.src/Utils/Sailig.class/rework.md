# Sailig — Rework

> Source : `.src/Utils/Sailig.class` · Message de commit (phase 4) : `reference/.src/Utils/Sailig.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 200 |
| Lignes de commentaire | 1 |
| Fonctions | 15 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 68 |
| Complexité max (fonction) | 27 (`groupe_keypress`) |
| Variables globales | 0 |
| Variables Public | 9 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 200 | 68 | 27 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAILIG-001 — [documentation] En-tête : rôle, états `lecture/ecriture/reception`, table des
  touches → événements, sens réel de `valide` · appelants : aucun · tests : aucun · sources : [Sailig.class:_new](../../../../.src/Utils/Sailig.class#L39-L90), [Sailig.class:groupe_keypress](../../../../.src/Utils/Sailig.class#L133-L198)
- [ ] SAILIG-002 — [code mort] Variables inutilisées : `obj` de `groupe_keypress` et la variable
  privée `$Height` jamais lue · tests : T01, T03, T04 · sources : [Sailig.class:groupe_keypress](../../../../.src/Utils/Sailig.class#L133-L198), [Sailig.class:14](../../../../.src/Utils/Sailig.class#L14)
- [ ] SAILIG-003 — [complexité] `groupe_keypress` : helper privé `RetLigneSiDernier()` pour les 3
  blocs identiques (CC 27 → ≤ 18 visé) · tests : T05 · sources : [Sailig.class:groupe_keypress](../../../../.src/Utils/Sailig.class#L133-L198)
- [ ] SAILIG-004 — [complexité] `_new` : table de correspondance type d'`ObjProp` → création,
  observer, chaînage, en conservant **exactement** l'appel `chain.add(clas)` du cas TextBox · tests :
  T01, T02 · sources : [Sailig.class:_new](../../../../.src/Utils/Sailig.class#L39-L90)
- [ ] SAILIG-005 — [séparation traitement/GUI] Fonction pure `ActionTouche(code, ctrl, alt,
  estDernier, etat)` utilisée par `groupe_keypress` ; testable en gb.test · tests : T05 + nouveau
  gbtest de la fonction · sources : [Sailig.class:groupe_keypress](../../../../.src/Utils/Sailig.class#L133-L198)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAILIG-A01 — [anomalie] `_new:60` : `chain.add(clas)` au lieu de `chain.add([clas])` pour
  `ObjProp.TextBox` (type attendu `Object[]`) · tests : T02 · sources : [Sailig.class:60](../../../../.src/Utils/Sailig.class#L60), [Sailig.class:_new](../../../../.src/Utils/Sailig.class#L39-L90)
- [ ] SAILIG-A02 — [anomalie] `valide` passe à `False` à chaque perte de focus, sans modification
  réelle : les lignes sont toujours considérées modifiées (impact `VarMajTar.affecttar`, `GesTar`)
  · tests : T05, SAITABLEAU-T08 · sources : [Sailig.class:122](../../../../.src/Utils/Sailig.class#L122), [Sailig.class:groupe_lostfocus](../../../../.src/Utils/Sailig.class#L120-L125)
