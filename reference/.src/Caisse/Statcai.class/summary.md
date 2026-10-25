# Statcai — Synthèse

> Source : `.src/Caisse/Statcai.class` · Synthèse des autres documents.

## Rôle

Écran « CA horaire des caisses » : chiffre d'affaires HT d'une journée, par caisse et par heure
(8 h à 19 h, bornes cumulant les heures extérieures), avec total général. Ouvert par
`Fmenu.Menu204_Click` (auto-instance).

## Points clés

- Calcul par une table de travail `Total` détruite et recréée à chaque rafraîchissement, à partir
  de `Fiches_EntTicketz` (tickets en cours) et `Fiches_HisEntTickets` (archivés).
- Lecture seule pour les données métier.
- Fonctions les plus complexes : `Traitement` (CC 17), `Recup_ca` (CC 10).

## Dépendances principales

- Appelant : `Fmenu.Menu204_Click`.
- Utilise : `Utils.db` (`Exec`, `Engine`), `Utils.cpoint`, `LDate`.
- Tables : `Fiches_Caisses`, `Fiches_EntTicketz`, `Fiches_HisEntTickets` (en dur), `Total`
  (partagée par nom avec `.src/Statistiques`).

## Risques

- Tickets en cours jamais comptés (`IN` avec une seule chaîne, STATCAI-A01).
- Inutilisable sous SQLite (`HOUR`, A02) ; `union` fusionne des lignes identiques (A03).
- Table de travail `Total` en conflit avec d'autres statistiques (A04) ; erreurs en
  `Message.Info` (A05).
- Grille `Liste` sans `Liste_Click` : ne pas la cliquer dans les scénarios de rejeu.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 146 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 17 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 scénarios `replay` (STATCAI-T01 à T05 : CA horaire, tickets en cours, doublon `union`, cas
limites, SQLite) et 1 `gbtest` après séparation (T06).

## Rework

5 étapes sans changement de comportement (STATCAI-001 à 005) : documentation, code mort et
`Cbase.Table`, simplification de `Traitement`, séparation traitement/GUI, réduction de portée.
5 anomalies (STATCAI-A01 à A05).
