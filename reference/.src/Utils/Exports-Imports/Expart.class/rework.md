# Expart — Rework

> Source : `.src/Utils/Exports-Imports/Expart.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Expart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 22 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 79 | 12 | 8 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPART-001 — [documentation] Corriger l'en-tête (nom de fichier), décrire les 23 colonnes ·
  appelants : aucun · tests : aucun · sources : [Expart.class:21-24](../../../../../.src/Utils/Exports-Imports/Expart.class#L21-L24), [Expart.class:75](../../../../../.src/Utils/Exports-Imports/Expart.class#L75)
- [ ] EXPART-002 — [code mort] `Num` membre → variable locale ; variables intermédiaires remplacées
  par un `String[]` joint par `;` (sortie identique) · appelants : aucun · tests : T01, T02 · sources : [Expart.class:27](../../../../../.src/Utils/Exports-Imports/Expart.class#L27), [Expart.class:62-68](../../../../../.src/Utils/Exports-Imports/Expart.class#L62-L68)
- [ ] EXPART-003 — [séparation traitement/GUI] `ExporterArticles(sChemin) As Integer` sans accès aux
  contrôles · appelants : aucun · tests : T01-T04 · sources : [Expart.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Expart.class#L57-L119)
- [ ] EXPART-004 — [commonalisation] `Svs_Click`, écriture CSV et fin de traitement via le socle
  commun d'import/export (partagé avec `Expclient`) · appelants : aucun · tests : T01, T04 · sources : [Expart.class:Svs_Click](../../../../../.src/Utils/Exports-Imports/Expart.class#L39-L49), [Expart.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Expart.class#L57-L119)
- [ ] EXPART-005 — [réarchitecture] `Cbase.Table("TabArt")` au lieu de `Fiches_Art` · tests : T01 · sources : [Expart.class:70](../../../../../.src/Utils/Exports-Imports/Expart.class#L70)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] EXPART-A01 — [anomalie] Prix `Null` : `Format$` lève une erreur, export interrompu et fichier
  non fermé · tests : T03 · sources : [Expart.class:86-96](../../../../../.src/Utils/Exports-Imports/Expart.class#L86-L96)
- [ ] EXPART-A02 — [anomalie] Colonne « Nb dcm » = chaîne de format au lieu du nombre de
  décimales ; `;` non échappés dans les désignations · tests : T02 · sources : [Expart.class:85](../../../../../.src/Utils/Exports-Imports/Expart.class#L85), [Expart.class:106](../../../../../.src/Utils/Exports-Imports/Expart.class#L106)
- [ ] EXPART-A03 — [anomalie] Fichier créé (vide) même s'il n'y a aucun article · tests : T04 · sources : [Expart.class:71](../../../../../.src/Utils/Exports-Imports/Expart.class#L71), [Expart.class:113-116](../../../../../.src/Utils/Exports-Imports/Expart.class#L113-L116)
