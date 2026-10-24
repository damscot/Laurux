# ImptartypeC — Rework

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/ImptartypeC.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 52 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 52 | 14 | 6 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPTARTYPEC-001 — [documentation] En-tête : format du fichier (colonne 0 = article, colonne
  12 = coefficient), table mise à jour · tests : aucun · sources : [ImptartypeC.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L36-L69)
- [ ] IMPTARTYPEC-002 — [code mort] `Tlig` sans allocation inutile (`New String[15]`) · tests : T01 · sources : [ImptartypeC.class:42](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L42)
- [ ] IMPTARTYPEC-003 — [séparation traitement/GUI] `ImporterCoefficients(sChemin, sTypec) As
  Integer` · tests : T01-T03 · sources : [ImptartypeC.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L36-L69)
- [ ] IMPTARTYPEC-004 — [commonalisation] Socle commun d'import/export (`ChoisirFichier`,
  `LireCsv`, `FinTraitement`) · tests : T01 · sources : [ImptartypeC.class:Svs_Click](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L20-L28), [ImptartypeC.class:45-48](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L45-L48)
- [ ] IMPTARTYPEC-005 — [réarchitecture] `Cbase.Table` pour `Fiches_Typec` et `Fiches_TarTypcli` ·
  tests : T01, T04 · sources : [ImptartypeC.class:9](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L9), [ImptartypeC.class:53-57](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L53-L57)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] IMPTARTYPEC-A01 — [anomalie] Ligne de moins de 13 colonnes → erreur hors bornes, import
  partiel · tests : T03 · sources : [ImptartypeC.class:52](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L52)
- [ ] IMPTARTYPEC-A02 — [anomalie] Type vide accepté ; coefficient non numérique enregistré à NULL ·
  tests : T02 · sources : [ImptartypeC.class:47](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L47), [ImptartypeC.class:55](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L55)
- [ ] IMPTARTYPEC-A03 — [anomalie] Fichier jamais fermé ; musique sans `Music.Load` ni `Start.Son` ·
  tests : T01 · sources : [ImptartypeC.class:45](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L45), [ImptartypeC.class:60](../../../../../.src/Utils/Exports-Imports/ImptartypeC.class#L60)
