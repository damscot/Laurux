# Cdocuments2 — Synthèse

> Source : `.src/Reports/Cdocuments2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne variante de `Cdocuments` (`Inherits PdfWriter`) qui imprimait une facture en deux
exemplaires côte à côte sur une page A4 paysage.

## Points clés

- **Jamais instanciée** depuis le commit `a2e027f1` (2019-07-12), qui a confié les éditions de
  facture au report `Editfac` ; seule subsiste la déclaration inutilisée
  `Private pdf2 As Cdocuments2` dans `Facture.class:200`.
- 59 méthodes `Public`, aucune exécutée ; 25 identiques à `Cdocuments`, 32 variantes
  « deux exemplaires », 2 propres (`_free`, `SignatureD2`).
- Duplication mesurée avec `Cdocuments` : 528 lignes communes (ratio 0,55).
- Défauts internes sans effet (copie de droite d'`Entete` : `ville`/`mail` au lieu de
  `cap`/`iban`).

## Dépendances principales

- Hérite de `PdfWriter` ; lit `Start.R/G/B`, `Start.LocalSettings`, `Variables.bRemise`.
- Référencée seulement par la déclaration de `Facture.class:200`.

## Risques

- Aucun à l'exécution. Risque de maintenance : copie divergente de `Cdocuments` qui fausse les
  recherches (homonymes `Level*`) et les métriques de duplication.
- Outillage : `deps.py` ne la signale pas comme jamais référencée (la déclaration de type compte
  comme une référence).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 926 |
| Lignes de commentaire | 58 |
| Fonctions | 59 |
| Fonctions Public | 59 |
| Complexité cyclomatique totale | 182 |
| Complexité max (fonction) | 31 (`Level10F`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests (CDOCUMENTS2-T01, T02) : replay des éditions de vente avec trace `gbx3 -t` (aucune ligne
exécutée, PDF identiques) et compilation après suppression.

## Rework

1 étape : CDOCUMENTS2-001, suppression de la classe et de la déclaration de `Facture.class:200`
(rework [code mort], pas d'anomalie car la classe n'a pas de `.form`). Aucune anomalie.
