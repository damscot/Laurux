# Cstocks — Synthèse

> Source : `.src/Reports/Cstocks.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des éditions d'inventaire (feuille de comptage, valorisation,
non saisis, écarts ; fin d'année et tournant) et du stock et des mouvements des dépôts. Squelette
d'édition paginée commun à 11 écrans.

## Points clés

- 24 méthodes `Public`, complexité 1 : titre (`Entete`), pied (`BasPage`), trait (`Lines`),
  7 couples en-tête/ligne, 3 totaux PA/PMP, bandeau et sous-total de famille.
- Couleur du thème appliquée à chaque en-tête (pas dans `_new`).
- Aucune méthode morte, même après suppression des écrans morts `Edinv1`/`EdinvT`.
- Chaque écran appelant recopie le bloc de saut de page (seuils 270 à 288 mm).

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) ; lit `Start.R/G/B`, `/Soc<XX>/Taxe`.
- Appelants : `Ecarts`, `EcartsT`, `Ednsaisis`, `EdnsaisisT`, `Edinv`, `Edinv1`, `EdinvT`,
  `Geninv`, `GeninvT`, `ImpDepots`, `Edsdepots`.

## Risques

- Faible : rendu pur. Le rework touche le flux PDF de 11 éditions, d'où la comparaison du flux
  non compressé en plus du texte.
- CSTOCKS-A01 (cosmétique) : libellé de sous-total de famille partiellement masqué.
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, accents, PDFWRITER-A01) et largeur de
  texte (alignements à droite décalés, PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 241 |
| Lignes de commentaire | 22 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `gbtest` (texte `pdftotext` et flux non compressé, dont la séquence de saut de page
du squelette proposé) et 1 `replay` qui reprend les scénarios des écrans d'inventaire et de
dépôts.

## Rework

6 étapes (CSTOCKS-001 à 006) : documentation, suppression de `_free`, base commune `PdfLaurux`,
helpers de colonnes et de total PA/PMP, squelette `DebutEdition`/`SautDePageSi` partagé par
9 écrans. 1 anomalie cosmétique (A01).
