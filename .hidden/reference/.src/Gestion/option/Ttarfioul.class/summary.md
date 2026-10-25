# Ttarfioul — Synthèse

> Source : `.src/Gestion/option/Ttarfioul.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran des **tarifs dégressifs du fioul/GNR** pour particuliers : marge de zone, supplément petites
quantités et barème par tranches (`Fiches_tarpp`, `Fiches_ligtarpp`) d'un article.

## Points clés

- Prix normal HT d'une tranche = marge de tranche + prix de revient + marge de zone ; prix « sup »
  = normal + supplément ; TTC à la TVA de l'article.
- Bornes en litres, stockées ÷ 1 000 pour les articles en `M3`/`Tonne`.
- Enregistrement : suppression puis réécriture des deux tables dans une transaction.
- Ouvert par `menuopt` ou embarqué dans une fenêtre par `artopt` (code verrouillé).

## Dépendances principales

- Utilise : `TriArticles`, `Utils.db`, `Utils.FColr`, `Settings` ; tables `Fiches_tarpp`,
  `Fiches_ligtarpp`, `Fiches_Art`, `Fiches_Tvaav`.
- Utilisé par : `menuopt`, `artopt`.

## Risques

- Dernière tranche probablement non enregistrée (`While i < Rows.Max`).
- `Variables.Bsel` réinitialisé au lieu de `Me.Bsel`.
- `TextBox` orphelin créé à chaque clic de cellule ; couleurs lues dans `Settings`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 267 |
| Lignes de commentaire | 4 |
| Fonctions | 14 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 60 |
| Complexité max (fonction) | 10 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (TTARFIOUL-T01 à T05) : 4 replays (affichage, saisie et calcul, enregistrement, ouverture
depuis la fiche article) et 1 `gbtest` du calcul de tranche.

## Rework

5 étapes (TTARFIOUL-001 à 005) : documentation, calcul extrait, conversions HT/TTC communes, code
mort, `Cbase.Table`. 3 anomalies (A01 à A03).
