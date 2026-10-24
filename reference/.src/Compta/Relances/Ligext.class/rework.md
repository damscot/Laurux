# Ligext — Rework

> Source : `.src/Compta/Relances/Ligext.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/Ligext.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 7 |
| Fonctions | 4 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 9 |
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
| initial | `6b6b9dfc` | 2026-10-24 | 61 | 9 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LIGEXT-001 — [documentation] En-tête : rôle (ligne d'extrait dans `FEditrel`), arguments de
  construction, lien avec `Fiches_relances` · appelants : aucun · tests : aucun · sources : [Ligext.class:_new](../../../../../.src/Compta/Relances/Ligext.class#L9-L36)
- [ ] LIGEXT-002 — [code mort] Supprimer la variable `av` et le test toujours faux de
  `selection_Write`, ainsi que les commentaires morts de `_new` · appelants : aucun · tests : T03 ·
  sources : [Ligext.class:selection_Write](../../../../../.src/Compta/Relances/Ligext.class#L78-L86), [Ligext.class:17-22](../../../../../.src/Compta/Relances/Ligext.class#L17-L22)
- [ ] LIGEXT-003 — [séparation traitement/GUI] `EstRelancee(lind)`, `Inscrit(rescli, resext)`,
  `Desinscrit(lind)` privés, SQL identique · appelants : aucun · tests : T01, T02 · sources :
  [Ligext.class:_new](../../../../../.src/Compta/Relances/Ligext.class#L9-L36), [Ligext.class:CheckBox1_Click](../../../../../.src/Compta/Relances/Ligext.class#L38-L70)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LIGEXT-A01 — [anomalie] `CheckBox1_Click` : pas de `Catch`/`Rollback`, une erreur SQL laisse
  la transaction ouverte · tests : T02 · sources : [Ligext.class:CheckBox1_Click](../../../../../.src/Compta/Relances/Ligext.class#L38-L70)
- [ ] LIGEXT-A02 — [anomalie] Ligne réinsérée différente de celle générée par `FEditrel` :
  `intitule` sans le prénom et `niveau` = `relance` au lieu de `relance + 1` (borné à 3) ; la lettre
  imprimée peut changer de niveau · tests : T02 · sources : [Ligext.class:48](../../../../../.src/Compta/Relances/Ligext.class#L48), [Ligext.class:62](../../../../../.src/Compta/Relances/Ligext.class#L62), [FEditrel.class:358-366](../../../../../.src/Compta/Relances/FEditrel.class#L358-L366)
