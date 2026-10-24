# Csolde — Synthèse

> Source : `.src/Utils/Csolde.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Recalcule le solde d'un compte (`Solde_caisse`) ou de tous les comptes (`Recalc_solde`) à partir des
écritures validées de `Fiches_Mvt` et met à jour `Fiches_Comptes.solde`.

## Points clés

- Cumul en `Float` côté Gambas, dans des variables de module inutilement partagées.
- `Recalc_solde` : une requête et un `UPDATE` par compte.
- Noms de tables en dur ; `SELECT *` pour deux colonnes.
- Triple implémentation du même calcul (`Csolde`, `Recalcsolde`, `Calcsolde`).

## Dépendances principales

- Appelants : `Moulinage` (5), `BordereauxC` (3), `Epurjdv`, `Fmontant`.
- `Utils.db`, `Utils.PointBase` ; tables `Fiches_Mvt`, `Fiches_Comptes`.

## Risques

- Écarts d'arrondi possibles entre les trois implémentations : toute commonalisation exige T03.
- Lenteur de `Recalc_solde` sur un grand plan comptable.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 53 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 3 (`Recalc_solde`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (CSOLDE-T01 à T04) : solde d'un compte, recalcul global, équivalence avec
`Calcsolde.Calcul`, performance.

## Rework

4 étapes (CSOLDE-001 à 004) : documentation, variables locales, simplification des requêtes,
commonalisation avec `Recalcsolde`/`Calcsolde` sous condition. Aucune anomalie.
