# Enrgcp — Synthèse

> Source : `.src/Utils/Enrgcp.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ajoute un couple code postal / bureau distributeur dans `Fiches_Cpostaux` s'il n'existe pas encore.

## Points clés

- Une fonction pure SQL, paramétrée, conforme aux règles (`Cbase.Table`, `&1`/`&2`).
- 7 appels : `FClient`, `FFournisseur`, `FClientcarte`, `Facture`.
- Code dupliqué dans `Impcpostaux`.

## Dépendances principales

- `Utils.db`, `Cbase` ; table `Fiches_Cpostaux`.

## Risques

- Faibles. Doublons possibles en cas de saisies concurrentes (pas de clé unique).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 7 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`Ecp`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (ENRGCP-T01, T02) sur MariaDB et SQLite.

## Rework

2 étapes (ENRGCP-001, 002) : documentation et réutilisation par `Impcpostaux`. Aucune anomalie.
