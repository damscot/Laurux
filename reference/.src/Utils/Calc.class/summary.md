# Calc — Synthèse

> Source : `.src/Utils/Calc.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne calculatrice (formulaire `Calc.form`) dont le résultat était renvoyé dans
`Calc.Resultat`. Remplacée par `FCalc`.

## Points clés

- **Code mort intégral** : aucun écran ne l'ouvre, `Calc.Resultat` n'est lu nulle part ; seule
  référence : le type de retour de `FCalc.GetParent`, fonction elle-même jamais appelée.
- Défauts internes sans impact (pourcentage toujours nul, signe initial perdu, première opération
  combinée avec 0).

## Dépendances principales

- Utilise `Utils.cpoint`. Référencée uniquement par `FCalc.GetParent` (type).

## Risques

- Aucun à l'exécution ; la suppression doit être faite avec celle de `FCalc.GetParent` pour que la
  compilation passe.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 6 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 14 (`Box1_KeyPress`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Un seul test (CALC-T01) : compilation et suite gb.test après suppression.

## Rework

Une étape (CALC-A01) : suppression de `Calc.class` et `Calc.form`. Aucune anomalie retenue.
