# Raz — Synthèse

> Source : `.src/Communs/Raz.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Utilitaire lancé par `Prgm` (`Raz`) qui passe tous les articles en « non stocké »
(`Fiches_Art.art_stocke = 0`) après confirmation.

## Points clés

- Une requête `UPdate` par article, sans transaction.
- Confirmation `Message.Warning` « OK » / « Non » ; message de fin seulement si la table contient des
  articles.

## Dépendances principales

- Appelé par `Prgm`. Utilise `Utils.db`, `Cbase.Table("TabArt")`.

## Risques

- Traitement de masse irréversible (une sauvegarde est demandée par le libellé de l'écran) ; pas
  d'anomalie relevée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (RAZ-T01 à T03) : confirmation, refus, table vide.

## Rework

3 étapes (RAZ-001 à 003) : documentation, UPDATE unique (dump identique), séparation du SQL.
Aucune anomalie.
