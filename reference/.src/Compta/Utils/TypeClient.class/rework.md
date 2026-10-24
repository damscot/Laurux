# TypeClient — Rework

> Source : `.src/Compta/Utils/TypeClient.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/TypeClient.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 24 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 3 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 24 | 6 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TYPECLIENT-001 — [documentation] En-tête : contrôle `TreeView` des types de clients,
  contrat de `where` (jointure `Fiches_Cli` attendue chez l'appelant) · appelants : aucun · tests :
  T01, T02 · sources : [TypeClient.class:_new](../../../../../.src/Compta/Utils/TypeClient.class#L9-L20), [TypeClient.class:where_Read](../../../../../.src/Compta/Utils/TypeClient.class#L22-L36)
- [ ] TYPECLIENT-002 — [commonalisation] `Cbase.Table("TabTypec")` au lieu de `Fiches_Typec` en
  dur (même SQL) · appelants : aucun · tests : T01 · sources : [TypeClient.class:13](../../../../../.src/Compta/Utils/TypeClient.class#L13)
- [ ] TYPECLIENT-003 — [séparation traitement/GUI] Fonction statique pure
  `WhereTypes(aCodes As String[]) As String` appelée par `where_Read` (même texte produit) ·
  appelants : aucun · tests : T02, T03 · sources : [TypeClient.class:where_Read](../../../../../.src/Compta/Utils/TypeClient.class#L22-L36)
