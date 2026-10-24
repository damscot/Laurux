# Impcpostaux — Rework

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Impcpostaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 54 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 54 | 14 | 10 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPCPOSTAUX-001 — [documentation] En-tête : format attendu (`ville;cp`), règle du `0` initial ·
  tests : aucun · sources : [Impcpostaux.class:Button1_Click](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L10-L49)
- [ ] IMPCPOSTAUX-002 — [complexité] Découpage par une fonction `DecouperLigne` reproduisant
  exactement `InStr`/`Left$`/`Mid$` (y compris ligne sans `;`) · tests : T01, T03 · sources : [Impcpostaux.class:25-36](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L25-L36)
- [ ] IMPCPOSTAUX-003 — [séparation traitement/GUI] `ImporterCodesPostaux(sChemin) As Integer` ·
  tests : T01-T04 · sources : [Impcpostaux.class:Button1_Click](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L10-L49)
- [ ] IMPCPOSTAUX-004 — [commonalisation] Lecture fichier et fin de traitement via le socle commun
  d'import/export · tests : T01, T04 · sources : [Impcpostaux.class:21-24](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L21-L24)
- [ ] IMPCPOSTAUX-005 — [commonalisation] Remplacer le `SELECT`+`INSERT` par `Enrgcp.Ecp(cp, ville)`
  pour les cp non vides, en conservant l'insertion directe des cp vides (comportement identique) ·
  appelants : aucun · tests : T01, T02 · sources : [Impcpostaux.class:37-38](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L37-L38), [Enrgcp.module:Ecp](../../../../../.src/Utils/Enrgcp.module#L4-L13)
- [ ] IMPCPOSTAUX-006 — [code mort] Variable `x` remplacée, `Key` local inutile après IMPCPOSTAUX-002
  · tests : T01 · sources : [Impcpostaux.class:15](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L15), [Impcpostaux.class:17](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L17)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] IMPCPOSTAUX-A01 — [anomalie] Ligne sans `;` : valeurs incohérentes insérées · tests : T03 · sources : [Impcpostaux.class:26-28](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L26-L28)
- [ ] IMPCPOSTAUX-A02 — [anomalie] Fichier jamais fermé ; musique sans `Music.Load` ni test de
  `Start.Son` ; messages hors i18n · tests : T01 · sources : [Impcpostaux.class:21](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L21), [Impcpostaux.class:40-46](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L40-L46)
- [ ] IMPCPOSTAUX-A03 — [anomalie] Un code postal vide est inséré (alors que `Enrgcp.Ecp` l'ignore) ;
  aligner sur `Ecp` · tests : T03 · sources : [Impcpostaux.class:38](../../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L38)
