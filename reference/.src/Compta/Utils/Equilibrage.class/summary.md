# Equilibrage — Synthèse

> Source : `.src/Compta/Utils/Equilibrage.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Utilitaire de réparation lancé par `Prgm` (nom `Equilibrage`) : corrige le crédit de la dernière
ligne des écritures déséquilibrées du journal `70` dans `Fiches_Mvt`.

## Points clés

- Un seul traitement (`Button2_Click`, appelé par `Btn_Click`), cumuls tenus en chaînes.
- Journal `70` en dur ; aucune confirmation avant modification de masse.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `Utils.PointBase`.
- Table : `Fiches_Mvt` (en dur).
- Utilisé par : `Prgm` uniquement.

## Risques

- Clé d'intégrité `control` et soldes non recalculés après modification (EQUILIBRAGE-A02).
- Dernière écriture jamais traitée, écritures sans crédit ignorées, UPDATE trop large (A01, A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 30 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 7 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (EQUILIBRAGE-T01 à T03) depuis `Prgm`, comparaison du dump de `Fiches_Mvt` et
`Fiches_Comptes`.

## Rework

3 étapes (documentation, cumuls typés et constantes, séparation traitement/GUI) ; 3 anomalies.
