# barselection — Rework

> Source : `.src/Gestion/option/barselection.class` · Message de commit (phase 4) : `.hidden/reference/.src/Gestion/option/barselection.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 173 |
| Lignes de commentaire | 1 |
| Fonctions | 10 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 10 (`affichechoix`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 173 | 37 | 10 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BARSELECTION-001 — [documentation] En-tête : format de `choix`, liste et ordre des
  événements, cycle navigation → validation, contrat `Stop Event` sur `valide`/`annule`,
  conteneur dédié (vidé par `efface`) · appelants : aucun · tests : aucun · sources : [barselection.class:_new](../../../../../../.src/Gestion/option/barselection.class#L25-L32), [barselection.class:butval_Click](../../../../../../.src/Gestion/option/barselection.class#L192-L211)
- [ ] BARSELECTION-002 — [complexité] `affichechoix` : tableau `[icône, infobulle]` et boucle
  sur `choix` (même ordre, mêmes `Tag`) (CC 10 → ≤ 3 visé) · appelants : `Mreglement`,
  `Tconsigne`, `Tregie`, `Tregion`, `Ttourne`, `Tchauffeur` (inchangés) · tests : T01-T03 ·
  sources : [barselection.class:affichechoix](../../../../../../.src/Gestion/option/barselection.class#L34-L93)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BARSELECTION-A01 — [anomalie] La barre passe en mode validation avant de lever
  `creer`/`modif`/`suprimer` et ignore leur retour : un écran qui refuse l'action laisse
  l'utilisateur en mode validation sans opération en cours (cas MREGLEMENT-A02) ; correction
  proposée : tenir compte de `Stop Event` sur ces événements · tests : T04 · sources : [barselection.class:bout_click](../../../../../../.src/Gestion/option/barselection.class#L161-L190)
- [ ] BARSELECTION-A02 — [amélioration][tests] Tests portés par les classes appelantes : BARSELECTION-T01, BARSELECTION-T02, BARSELECTION-T03 ne sont couverts que par des tests d'autres classes (BARSELECTION-T01 : couvert par ttourne_navigation et tregion_navigation, au lieu de Tconsigne ; BARSELECTION-T02 : couvert par tregie_creation, ttourne_creation, ttourne_annulation, tregion_annulation ; BARSELECTION-T03 : couvert par tregie_modif_*, ttourne_modification, ttourne_suppression, tregion_suppression) ; à rapatrier dans la classe (module .test ou scénarios dans ses assets), puis à alléger dans les appelants pour éviter le double comptage (phase 2, vague 6, 2026-11-14, décision utilisateur du 2026-11-14) · tests : BARSELECTION-T01, BARSELECTION-T02, BARSELECTION-T03 · sources : [test.md](test.md)
