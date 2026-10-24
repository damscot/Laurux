# Cbase — Synthèse

> Source : `.src/Utils/Cbase.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Table de correspondance nom logique → nom physique des tables (`Cbase.Table("TabArt")` →
`"Fiches_Art"`), passage obligé de toute requête SQL selon AGENTS.md.

## Points clés

- Une seule fonction, un `Select Case` de 121 cas (119 clés distinctes, 2 doublons inatteignables).
- Clé inconnue → `""` sans trace ; comparaison sensible à la casse.
- 15 clés jamais utilisées ; 3 clés utilisées mais non définies (`TabBanques`, `TabCdocs`, `TabFdocs`).
- 6 cibles sont des tables de travail absentes de `db_control.csv`.

## Dépendances principales

- Utilisé par 190 fichiers, toujours avec une clé littérale.
- Aucune dépendance sortante : premier candidat au rework, sans contrainte d'ordre.

## Risques

- Rayon d'impact maximal (toutes les requêtes) mais logique triviale : les tests T01/T02 couvrent
  100 % du contrat.
- Les clés manquantes provoquent des erreurs SQL silencieuses dans `FClient`/`FFournisseur` et une
  liste vide dans `Glcr`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 248 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 122 (`Table`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (CBASE-T01 à T04) : correspondance complète des 119 clés extraite du source,
clés inconnues et casse, cohérence documentaire avec `db_control.csv`, performance.

## Rework

4 étapes (CBASE-001 à 004) : documentation, suppression des doublons, remplacement du `Select Case`
par une `Collection` statique, éventuelle suppression des clés inutilisées. 2 anomalies (CBASE-A01,
A02) : clés manquantes et absence de trace pour une clé inconnue.
