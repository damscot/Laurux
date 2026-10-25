# Cclients — Synthèse

> Source : `.src/Reports/Cclients.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des listes de tiers : liste des clients (`EdClient`), des
fournisseurs en paysage (`EdFour`) et des clients créés par les imports comptables (`ImpJdv`,
`ImpSage`). Cadres portrait et paysage, en-têtes et lignes de clients (deux lignes par tiers),
clients Sage et fournisseurs.

## Points clés

- 13 méthodes `Public`, complexité 1, toutes utilisées (sauf `_free`, vide).
- Couples portrait/paysage (`Entete`/`EnteteP`, `Lines`/`LinesP`, `BasPage`/`BasPageP`) qui ne
  diffèrent que par la largeur (206 / 292 mm).
- `Level2S` reçoit 3 paramètres jamais imprimés.

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) ; lit `Start.R/G/B`.
- Appelants : `EdClient`, `EdFour` (Gestion), `ImpJdv`, `ImpSage` (Compta).

## Risques

- **CCLIENTS-A01** (= IMPJDV-A04 côté appelant) : `Level2` appelé avec 12 arguments par `ImpJdv`
  → « Not enough arguments » lors d'un import du journal des ventes qui crée des clients.
- `EdFour` termine un PDF paysage par le pied portrait (EDFOUR-A01).
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, accents, PDFWRITER-A01) et largeur de
  texte (alignements à droite décalés, PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 118 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 3 `gbtest` (portrait, Sage, paysage ; texte `pdftotext` et flux non compressé) et
2 `replay` (caractérisation de l'erreur d'`ImpJdv`, éditions réelles).

## Rework

5 étapes (CCLIENTS-001 à 005) : documentation, suppression de `_free`, base commune
`PdfLaurux` pour les couples portrait/paysage, simplification de la signature de `Level2S`
(avec `ImpSage`), helpers de colonnes. 1 anomalie (A01).
