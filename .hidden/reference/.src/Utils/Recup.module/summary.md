# Recup — Synthèse

> Source : `.src/Utils/Recup.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Renvoie le nom de l'utilisateur (`Utilisateur` = `User.Name`) et le nom du groupe principal (`Group`,
via `getent`).

## Points clés

- `Group` n'est jamais appelé et lit un fichier temporaire de façon fragile.
- `Utilisateur` est une simple enveloppe, appelée une fois (`FRestore`).

## Dépendances principales

- `FRestore` (appelant unique).

## Risques

- Aucun : module quasi mort.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 20 |
| Lignes de commentaire | 2 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 3 (`Group`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (RECUP-T01, T02).

## Rework

3 étapes (RECUP-001 à 003) aboutissant à la suppression du module. Aucune anomalie (le défaut de
`Group` disparaît avec sa suppression).
