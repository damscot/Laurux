# Cticket — Synthèse

> Source : `.src/Caisse/Reports/Cticket.class` · Synthèse des autres documents.

## Rôle

Ébauche abandonnée d'un gabarit PDF de ticket (`Inherits PdfWriter`), importée avec Laurux-Pos
en 2018. Le ticket est produit par `Cfacture`.

## Points clés

- Classe **jamais référencée** (aucun appelant, aucun `.form`, nom absent des chaînes) :
  signal `jamais_reference` confirmé par `grep`.
- `Entete2` appelle `Me.seto`, membre inexistant de `PdfWriter`.

## Dépendances principales

- Parent : `PdfWriter`. Aucun appelant, aucune table.

## Risques

- Aucun en production (jamais exécutée). Seul risque : confusion avec `Cfacture`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 3 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun test : la suppression est validée par `gbc3 -agt` et `./Laurux -T all`.

## Rework

1 étape (CTICKET-001) : suppression du fichier [code mort]. Aucune anomalie.
