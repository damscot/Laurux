# VarEcr — Rework

> Source : `.src/Compta/Utils/VarEcr.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/VarEcr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 110 |
| Lignes de commentaire | 1 |
| Fonctions | 13 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 28 |
| Complexité max (fonction) | 4 (`somme`) |
| Variables globales | 0 |
| Variables Public | 19 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 110 | 28 | 4 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VARECR-001 — [documentation] En-tête : double rôle ligne/conteneur, signification des
  énumérations `L_*` et des types, champs obligatoires par type d'écriture · appelants : aucun ·
  tests : aucun · sources : [VarEcr.class:3-4](../../../../../.src/Compta/Utils/VarEcr.class#L3-L4), [VarEcr.class:16-38](../../../../../.src/Compta/Utils/VarEcr.class#L16-L38)
- [ ] VARECR-002 — [code mort] Supprimer `_put` (aucun utilisateur, bornes fausses) et le `_new`
  vide · appelants : aucun · tests : T01-T06 · sources : [VarEcr.class:_put](../../../../../.src/Compta/Utils/VarEcr.class#L61-L66), [VarEcr.class:_new](../../../../../.src/Compta/Utils/VarEcr.class#L68-L70)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VARECR-A01 — [anomalie] `_get` avec un indice négatif lève une erreur au lieu de renvoyer
  `Null` ; `trouve` renvoie tantôt une ligne, tantôt un entier · tests : T01, T04 · sources :
  [VarEcr.class:_get](../../../../../.src/Compta/Utils/VarEcr.class#L54-L59), [VarEcr.class:trouve](../../../../../.src/Compta/Utils/VarEcr.class#L103-L111)
