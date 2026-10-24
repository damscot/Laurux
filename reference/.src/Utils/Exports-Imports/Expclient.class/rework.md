# Expclient — Rework

> Source : `.src/Utils/Exports-Imports/Expclient.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Expclient.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 22 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 59 | 9 | 5 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPCLIENT-001 — [documentation] En-tête : description des 10 colonnes · tests : aucun · sources : [Expclient.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Expclient.class#L57-L99)
- [ ] EXPCLIENT-002 — [code mort] `Num` membre → local ; suppression des variables intermédiaires ·
  appelants : aucun · tests : T01, T02 · sources : [Expclient.class:27](../../../../../.src/Utils/Exports-Imports/Expclient.class#L27), [Expclient.class:62-69](../../../../../.src/Utils/Exports-Imports/Expclient.class#L62-L69)
- [ ] EXPCLIENT-003 — [séparation traitement/GUI] `ExporterClients(sChemin) As Integer` · tests : T01-T03 · sources : [Expclient.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Expclient.class#L57-L99)
- [ ] EXPCLIENT-004 — [commonalisation] Socle commun d'import/export (partagé avec `Expart`,
  `Expcontact`) · tests : T01, T03 · sources : [Expclient.class:Svs_Click](../../../../../.src/Utils/Exports-Imports/Expclient.class#L39-L49), [Expclient.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Expclient.class#L57-L99)
- [ ] EXPCLIENT-005 — [réarchitecture] `Cbase.Table("TabCli")` au lieu de `Fiches_Cli` · tests : T01 · sources : [Expclient.class:71](../../../../../.src/Utils/Exports-Imports/Expclient.class#L71)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] EXPCLIENT-A01 — [anomalie] Pas d'`ORDER BY` : ordre d'export non déterministe ; ajouter
  `ORDER BY cli_code` · tests : T01 · sources : [Expclient.class:74](../../../../../.src/Utils/Exports-Imports/Expclient.class#L74)
- [ ] EXPCLIENT-A02 — [anomalie] `;` non échappés ; fichier vide créé si aucun client · tests : T02, T03 · sources : [Expclient.class:72](../../../../../.src/Utils/Exports-Imports/Expclient.class#L72), [Expclient.class:86](../../../../../.src/Utils/Exports-Imports/Expclient.class#L86)
