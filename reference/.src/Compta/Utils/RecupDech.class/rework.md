# RecupDech — Rework

> Source : `.src/Compta/Utils/RecupDech.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/RecupDech.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 17 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 17 | 5 | 4 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECUPDECH-001 — [documentation] En-tête : format de `~/tmp/Dtech.txt`, lien avec `Renech`,
  formulaire jamais affiché · appelants : aucun · tests : T01 · sources : [RecupDech.class:run](../../../../../.src/Compta/Utils/RecupDech.class#L5-L20)
- [ ] RECUPDECH-002 — [code mort] Supprimer le `Print rResult.count` (sortie standard) et passer le
  fichier en variable locale · appelants : aucun · tests : T01, T03 · sources : [RecupDech.class:3](../../../../../.src/Compta/Utils/RecupDech.class#L3), [RecupDech.class:12](../../../../../.src/Compta/Utils/RecupDech.class#L12)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RECUPDECH-A01 — [anomalie] Formulaire `RecupDech.form` et `Button2_Click` jamais utilisés
  (aucune ouverture, `Button1` sans handler) : suppression du `.form` et du handler, la classe
  restant statique · tests : T03 · sources : [RecupDech.class:Button2_Click](../../../../../.src/Compta/Utils/RecupDech.class#L22-L26)
- [ ] RECUPDECH-A02 — [anomalie] Date exportée par conversion implicite (heure incluse si non
  nulle, illisible par `Renech`) et répertoire `~/tmp` supposé existant ; chemin différent de celui
  lu par `Renech` (voir RENECH-A02) · tests : T01, T02 · sources : [RecupDech.class:9](../../../../../.src/Compta/Utils/RecupDech.class#L9), [RecupDech.class:14](../../../../../.src/Compta/Utils/RecupDech.class#L14)
