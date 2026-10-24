# Recalcsolde — Synthèse

> Source : `.src/Compta/Utils/Recalcsolde.module` · Synthèse des autres documents.

## Rôle

Recalcul du solde de tous les comptes (`Fiches_Comptes.solde`) à partir des écritures validées de
`Fiches_Mvt`. Copie quasi identique de `Csolde.Recalc_solde` ; 3ᵉ variante dans `Calcsolde.Calcul`.

## Points clés

- **Module mort** : aucun appelant (grep, aucune chaîne `"Recalcsolde"`).
- Une seule fonction `Calc` (CC 5) ; variables `TotSldHP` et `Intit` inutilisées.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.PointBase` ; tables `Fiches_Comptes`, `Fiches_Mvt` en dur.
- Utilisé par : personne.

## Risques

- Aucun à l'exécution (jamais appelé) ; risque de maintenance (trois implémentations du même
  calcul).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 4 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`Calc`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` d'information (RECALCSOLDE-T01) : équivalence des dumps avec `Csolde.Recalc_solde`
avant suppression.

## Rework

1 étape (RECALCSOLDE-001) : suppression du module (code mort), en cohérence avec CSOLDE-004.
