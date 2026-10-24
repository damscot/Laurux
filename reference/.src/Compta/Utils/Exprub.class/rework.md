# Exprub — Rework

> Source : `.src/Compta/Utils/Exprub.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Exprub.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 5 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 9 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 48 | 9 | 9 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPRUB-001 — [documentation] En-tête en français : format des deux fichiers (champs, `;`
  final, absence d'échappement, plages des seules rubriques `L`), lien avec l'import de `Rubresult`
  et lancement par `Prgm` · appelants : aucun · tests : aucun · sources : [Exprub.class:run](../../../../../.src/Compta/Utils/Exprub.class#L15-L60)
- [ ] EXPRUB-002 — [réduction de portée] Les six variables `Static` de classe deviennent des
  variables locales de `run` · appelants : aucun · tests : T01, T02 · sources : [Exprub.class:8-13](../../../../../.src/Compta/Utils/Exprub.class#L8-L13), [Exprub.class:run](../../../../../.src/Compta/Utils/Exprub.class#L15-L60)
- [ ] EXPRUB-003 — [séparation traitement/GUI] Extraire `Exporte(sRep As String)` (requêtes et
  écriture, sans message) ; `run` garde l'avertissement, `User.Home` et le message final. SQL
  identique · appelants : `Prgm` (inchangé) · tests : T01-T05 · sources : [Exprub.class:run](../../../../../.src/Compta/Utils/Exprub.class#L15-L60)
- [ ] EXPRUB-004 — [commonalisation] Regrouper `Exporte` et l'import de `Rubresult` dans un même
  module de paramétrage (format décrit une fois ; voir RUBRESULT-006) · appelants : `Prgm`,
  `Rubresult` · tests : T01, T05, RUBRESULT-T04 · sources : [Exprub.class:run](../../../../../.src/Compta/Utils/Exprub.class#L15-L60), [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)
- [ ] EXPRUB-005 — [commonalisation] `Cbase.Table("TabRubriques")`/`("TabRubCompt")` (clés
  ajoutées avec RUBCOMPT-006, SQL identique) · appelants : `Cbase` · tests : T01 · sources : [Exprub.class:30-31](../../../../../.src/Compta/Utils/Exprub.class#L30-L31)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EXPRUB-A01 — [anomalie] Format sans échappement : un `;` (ou un saut de ligne) dans un
  intitulé décale les champs à l'import de `Rubresult` · tests : T03 · sources : [Exprub.class:42](../../../../../.src/Compta/Utils/Exprub.class#L42)
- [ ] EXPRUB-A02 — [anomalie] Le drapeau `amortissement` est écrit sous la forme de conversion
  Gambas du moteur (`T`/vide sous MySQL, `1`/`0` probable sous SQLite) ; relu par `Rubresult` comme
  « chaîne non vide = vrai », un `0` devient vrai (à confirmer) · tests : T03, T04 · sources : [Exprub.class:49](../../../../../.src/Compta/Utils/Exprub.class#L49), [Exprub.class:50](../../../../../.src/Compta/Utils/Exprub.class#L50)
