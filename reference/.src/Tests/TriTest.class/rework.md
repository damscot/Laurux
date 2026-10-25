# TriTest — Rework

> Source : `.src/Tests/TriTest.class` · Message de commit (phase 4) : `reference/.src/Tests/TriTest.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 5 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 43 | 7 | 2 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRITEST-001 — [documentation] En-tête : banc d'essai de `TriGen` (lien vers sa doc), lancement,
  sortie produite · appelants : aucun · tests : T01 · sources : [TriTest.class:_new](../../../../.src/Tests/TriTest.class#L10-L43)
- [ ] TRITEST-002 — [réarchitecture] Enrichir en banc de test de `TriGen` : un scénario par cas de
  TRIGEN-T01 à T09 (filtre/tri, pagination, sélection à colonnes `cle`, sélection multiple, filtre sans
  résultat, caractères spéciaux, impression, fenêtre propre), sortie texte déterministe et
  `Utils.Observers(Me)` pour le rejeu ; à réaliser avec la phase 2 (tests), sans modifier le
  comportement de `TriGen` · appelants : aucun · tests : T01-T03 + TRIGEN-T01..T09 · sources : [TriTest.class:_new](../../../../.src/Tests/TriTest.class#L10-L43), [TriTest.class:CheckBox1_Click](../../../../.src/Tests/TriTest.class#L64-L72), [TriGen.class:_new](../../../../.src/Affichages/TriGen.class#L50-L165)
- [ ] TRITEST-003 — [code mort] Retirer la requête et les deux créations de `TriGen` commentées ·
  appelants : aucun · tests : T01 · sources : [TriTest.class:17](../../../../.src/Tests/TriTest.class#L17), [TriTest.class:36-39](../../../../.src/Tests/TriTest.class#L36-L39)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune.
