# Conditions — Synthèse

> Source : `.src/Utils/Conditions.class` · Synthèse des autres documents.

## Rôle

Mise en forme conditionnelle de `RichDataGrid` : liste de `Condition` combinées par ET sur la ligne
courante d'un `Result`, renvoyant `IfTrue`/`IfFalse`.

## Points clés

- **Fonctionnellement morte** : `RichDataGrid.CondFormats` n'est jamais alimentée.
- Nécessaire à la compilation tant que `RichDataGrid` la référence.
- Deux jeux de constantes équivalents (anglais/français).

## Dépendances principales

- Utilise `Condition` ; utilisée (type) par `RichDataGrid`.

## Risques

- Aucun à la suppression si elle est faite avec `Condition` et la partie morte de `RichDataGrid`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 6 |
| Fonctions | 9 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 13 (`Compute`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test de compilation (T01), 2 `gbtest` si la classe est conservée (T02, T03), 1 replay `Remisec` (T04).

## Rework

3 étapes (suppression coordonnée avec `RichDataGrid`, ou réduction de portée et simplification) et
1 anomalie (A01).
