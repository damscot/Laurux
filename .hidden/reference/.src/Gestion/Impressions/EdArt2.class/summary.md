# EdArt2 — Synthèse

> Source : `.src/Gestion/Impressions/EdArt2.class` · Synthèse des autres documents.

## Rôle

Ancien écran d'impression du **tarif client** (PV HT, TVA, PV TTC ; `~/tmp/Tarif2.pdf`). **Plus
appelé** : le menu Tarif > Client ouvre `Edart4` depuis le commit `29df3a6d`.

## Points clés

- Copie d'`EdArt1` à 81 % (mêmes 23 fonctions) ; seul `Button2_Click` diffère (`Level8`/`Level9`).
- Aucun appelant (grep) : couple `.class` + `.form` mort.
- Les méthodes `Carticles.Level8`, `Level8bis`, `Level9`, `Level9bis`, `Ligne2` ne servent qu'ici.

## Dépendances principales

- Aucun appelant. Utilise `Carticles`, `TriArticles`, `Utils`, `Cbase`, `Visualiseur`.

## Risques

- Aucun en exploitation (inaccessible). Défauts latents si réactivé : tris 2 à 4 sans filtre
  fournisseur, prix consommateur non imprimé, défauts hérités d'`EdArt1`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 489 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 112 |
| Complexité max (fonction) | 21 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle statique (EDART2-T01) vérifiant l'absence d'appelant ; aucun scénario de rejeu possible.

## Rework

1 étape de documentation (EDART2-001). 3 anomalies : EDART2-A01 (suppression du couple mort et
des 5 méthodes `Carticles` associées, −489 lignes), A02 et A03 (défauts latents si conservé).
