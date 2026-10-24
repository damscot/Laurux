# FCalc — Rework

> Source : `.src/Utils/FCalc.class` · Message de commit (phase 4) : `reference/.src/Utils/FCalc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 124 |
| Lignes de commentaire | 8 |
| Fonctions | 12 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 20 (`ManageKeys`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 124 | 39 | 20 | 1 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCALC-001 — [documentation] En-tête : contrat avec les appelants (F5, `ShowModal`, lecture de
  `FCalc.Resultat` au format localisé `0.00000`), syntaxe acceptée · appelants : aucun · tests :
  aucun · sources : [FCalc.class:Export_Click](../../../../.src/Utils/FCalc.class#L165-L178)
- [ ] FCALC-002 — [code mort] Supprimer `GetParent() As Calc` (jamais appelé), dans le même commit
  que CALC-A01 ; supprimer la condition toujours vraie `If skey <> ")"` et la propriété `Value`
  (jamais lue) · appelants : aucun · tests : T01-T05 · sources : [FCalc.class:GetParent](../../../../.src/Utils/FCalc.class#L101-L105), [FCalc.class:127](../../../../.src/Utils/FCalc.class#L127), [FCalc.class:Value_Read](../../../../.src/Utils/FCalc.class#L159-L163)
- [ ] FCALC-003 — [complexité] `form_keypress` : fusion `Key.Return`/`Key.Enter` et simplification
  de `$Export` (même séquence calcul → export) · tests : T04, T06, T07 · sources : [FCalc.class:form_keypress](../../../../.src/Utils/FCalc.class#L68-L99)
- [ ] FCALC-004 — [séparation traitement/GUI] Extraire `ManageKeys` en fonction statique pure
  (formule, résultat, compteur de parenthèses, touche) ; le formulaire ne fait plus que l'affichage
  · tests : T01-T03 · sources : [FCalc.class:ManageKeys](../../../../.src/Utils/FCalc.class#L107-L157)
- [ ] FCALC-005 — [commonalisation] Méthode statique `FCalc.Saisir(...)` encapsulant ouverture
  modale et lecture de `Resultat`, adoptée par les 7 appelants **en conservant leur formatage
  respectif** · appelants : `Caisse`, `Saisecrit`, `Tresor`, `Abont`, `Facture`, `TresorFac`,
  `Saisiedecons` · tests : T06, T07 + replays des appelants · sources : [FCalc.class:Export_Click](../../../../.src/Utils/FCalc.class#L165-L178), [Caisse.class:1647](../../../../.src/Caisse/Caisse.class#L1647)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCALC-A01 — [anomalie] `Resultat` (statique) n'est jamais réinitialisé : fermer la calculette
  sans exporter réinjecte le résultat précédent dans la zone appelante · tests : T05 · sources : [FCalc.class:13](../../../../.src/Utils/FCalc.class#L13), [FCalc.class:Export_Click](../../../../.src/Utils/FCalc.class#L165-L178)
- [ ] FCALC-A02 — [anomalie] Erreur d'évaluation → résultat `1` (valeur arbitraire, exportable) ;
  la virgule décimale, acceptée à la saisie, fait échouer `Eval` (à confirmer) · tests : T02 · sources : [FCalc.class:112-114](../../../../.src/Utils/FCalc.class#L112-L114), [FCalc.class:ManageKeys](../../../../.src/Utils/FCalc.class#L107-L157)
