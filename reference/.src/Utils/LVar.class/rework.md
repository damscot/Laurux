# LVar — Rework

> Source : `.src/Utils/LVar.class` · Message de commit (phase 4) : `reference/.src/Utils/LVar.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 3 |
| Fonctions | 5 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 5 (`Evaluate`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 61 | 15 | 5 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LVAR-001 — [documentation] En-tête : liste des variables disponibles, partage de la
  collection par référence, utilisation d'`Eval`, comportement en cas d'erreur · appelants :
  aucun · tests : T01-T05 · sources : [LVar.class:_New](../../../../.src/Utils/LVar.class#L11-L29), [LVar.class:Evaluate](../../../../.src/Utils/LVar.class#L62-L78)
- [ ] LVAR-002 — [code mort] Supprimer la variable `out` de `ParseResult` et le détour
  `Format(CStr(x), "00")` → `Format(x, "00")` (résultat identique) · appelants : aucun ·
  tests : T02, T03 · sources : [LVar.class:ParseResult](../../../../.src/Utils/LVar.class#L31-L44), [LVar.class:AddDate](../../../../.src/Utils/LVar.class#L46-L60)
- [ ] LVAR-003 — [complexité] `Update_Tooltip` : construire le texte localement puis une seule
  affectation (texte final identique) · appelants : aucun · tests : T05 · sources : [LVar.class:Update_Tooltip](../../../../.src/Utils/LVar.class#L80-L92)
- [ ] LVAR-004 — [commonalisation] Ajouter un helper `Calcule(parent, vars, defout, dte, res,
  expr) As String` reproduisant la séquence New/AddDate/ParseResult/Evaluate ; la bascule des
  appelants se fait dans leurs reworks · appelants : `Saisecrit`, `Tresor`, `EcrAuto`, `ValidBR`,
  `ValidBR1` (optionnel) · tests : T01-T04, T06 · sources : [LVar.class:Evaluate](../../../../.src/Utils/LVar.class#L62-L78), [Saisecrit.class:411-414](../../../../.src/Compta/Saisecrit.class#L411-L414)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LVAR-A01 — [anomalie] `_New` : infobulle d'origine perdue si elle ne contient pas le
  séparateur (`Left(…, 0)`), et une ligne vide ajoutée à chaque nouvel `LVar` sur le même
  contrôle (`Left(…, Pos)` au lieu de `Pos - 1`) · tests : T05 · sources : [LVar.class:24-25](../../../../.src/Utils/LVar.class#L24-L25)
- [ ] LVAR-A02 — [anomalie] `$annee2` sans zéro de tête pour les années 2000-2009
  (`CStr(Year2)`) ; corriger par `Format(dte.Year2, "00")` · tests : T03 · sources : [LVar.class:49](../../../../.src/Utils/LVar.class#L49)
- [ ] LVAR-A03 — [anomalie] Le contexte est la collection de l'appelant (pas une copie) : les
  variables d'un `LVar` fuient dans le suivant (`Saisecrit`) ; à confirmer que ce n'est pas voulu ·
  tests : T02, T04 · sources : [LVar.class:19](../../../../.src/Utils/LVar.class#L19)
