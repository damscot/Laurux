# ImportStk — Rework

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/ImportStk.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 55 | 14 | 10 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPORTSTK-001 — [documentation] Remplacer le commentaire d'en-tête recopié de `CompArt` par la
  description réelle (format `code;qté`, colonnes mises à jour, rapport `Diff.txt`) · tests : aucun · sources : [ImportStk.class:3](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L3)
- [ ] IMPORTSTK-002 — [séparation traitement/GUI] `ImporterStock(sSource, sRapport) As Integer`
  sans contrôle · appelants : aucun · tests : T01-T04 · sources : [ImportStk.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L29-L72)
- [ ] IMPORTSTK-003 — [commonalisation] Boucle de lecture et rapport `Diff.txt` partagés avec
  `CompArt` (socle `ImpExp`) · appelants : aucun · tests : T01 + COMPART-T01 · sources : [ImportStk.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L29-L72), [CompArt.class:Button2_Click](../../../../../.src/Utils/CompArt.class#L29-L70)
- [ ] IMPORTSTK-004 — [réarchitecture] `Cbase.Table("TabArt")` au lieu de `Fiches_Art` · tests : T01 · sources : [ImportStk.class:52](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L52), [ImportStk.class:54](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L54)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] IMPORTSTK-A01 — [anomalie] Code nettoyé pour le `SELECT` mais brut pour l'`UPDATE` (l.52/54) :
  mise à jour silencieusement perdue · tests : T02 · sources : [ImportStk.class:52](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L52), [ImportStk.class:54](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L54)
- [ ] IMPORTSTK-A02 — [anomalie] `Close` sur fichiers non ouverts si le chemin n'existe pas (l.66-67)
  · tests : T04 · sources : [ImportStk.class:66-67](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L66-L67)
- [ ] IMPORTSTK-A03 — [anomalie] Ligne mal formée → erreur hors bornes, import partiel sans
  transaction ; quantité non convertie (`Utils.cpoint`) · tests : T03 · sources : [ImportStk.class:51-54](../../../../../.src/Utils/Exports-Imports/ImportStk.class#L51-L54)
