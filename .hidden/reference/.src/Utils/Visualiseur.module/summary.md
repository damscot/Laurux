# Visualiseur — Synthèse

> Source : `.src/Utils/Visualiseur.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ouvre un document généré (PDF, document GED) avec la commande `CmdVis` des préférences de caisse,
ou avec l'application par défaut du bureau.

## Points clés

- Une fonction, environ 110 appels dans 98 fichiers (toutes les éditions).
- `mime_type` ignoré ; `$Exec` inutilisé ; déclarée `As String` sans retour.
- `CmdVis`, saisi dans les préférences de caisse, s'applique à toutes les éditions.

## Dépendances principales

- `Start.LocalSettings`, `Desktop` ; appelants : éditions de tous les domaines, `LGed`, `Impression`.

## Risques

- Chemins non quotés dans le `Shell`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 8 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Prog`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (VISUALISEUR-T01, T02) avec des programmes factices journalisés.

## Rework

2 étapes (VISUALISEUR-001, 002) : documentation et nettoyage. 1 anomalie (VISUALISEUR-A01) :
quotage du chemin.
