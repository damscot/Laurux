# StatPromo — Synthèse

> Source : `.src/Statistiques/StatPromo.class` · Synthèse des autres documents.

## Rôle

Écran « Statistiques promotions » : choix d'une promotion puis affichage des articles de
`Fiches_ArtPromo` (PMP, PV HT/TTC, quantité vendue en caisse, marge) et de leurs totaux.

## Points clés

- Lecture seule (`Fiches_Promo`, `Fiches_ArtPromo`) ; pas de table `Total`, pas de `VisStat*`.
- Quantités alimentées par la caisse (`ArtPromo.Maj_qteplus`), sans date.
- `ColPromo_Click` appelé dynamiquement par le rejeu : reste `Public`.
- Couleurs lues et jamais utilisées.

## Dépendances principales

- Ouvert par `Fmenu.Menu223_Click` (modal).
- `Cbase.Table("TabPromo"/"TabArtPromo")`, `Utils`.

## Risques

- **A01** : prix NULL → erreur probable.
- **A02** : totaux HT/TTC non pondérés par la quantité.
- **A03** : code affiché ≠ code validé si `CodeP` est retapé sans Entrée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 142 |
| Lignes de commentaire | 33 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 12 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `replay` (liste, saisie, sans code, code modifié, valeurs NULL), 1 `gbtest`.
Ne pas cliquer dans `Liste` (`replay_missing`).

## Rework

5 étapes (STATPROMO-001 à 005) : documentation, code mort, portée de `Affichage`, séparation,
liste des promotions commune avec `FpromoArt`. 3 anomalies (A01 à A03).
