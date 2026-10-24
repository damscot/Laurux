# Syntheses — Synthèse

> Source : `.src/Utils/Syntheses.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Synthèse vocale des messages d'information (fin de purge, promotions, rendez-vous) via `pico2wave` et
`aplay`, précédée d'un son d'alerte, si l'option `/son2` est activée.

## Points clés

- Une fonction, 17 appels dans 13 fichiers (`Raz*`, `Fmenu`, `Fsoc`, `Facture`, `AffRdv`…).
- `Shell` final qui relance `pico2wave` sans argument ; WAV laissé dans le répertoire courant.
- Déclarée `As String` sans valeur renvoyée.

## Dépendances principales

- `Start.LocalSettings["/son2"]`, `Music`, programmes `pico2wave` et `aplay`.

## Risques

- Faibles : effet uniquement sonore ; les appels sont asynchrones.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 4 (`Message`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (SYNTHESES-T01, T02) avec des programmes factices journalisés.

## Rework

2 étapes (SYNTHESES-001, 002) : documentation et nettoyage des déclarations. 1 anomalie
(SYNTHESES-A01) : commande `Shell` et fichier temporaire.
