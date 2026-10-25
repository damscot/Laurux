# StatTypCli — Synthèse

> Source : `.src/Statistiques/StatTypCli.class` · Synthèse des autres documents.

## Rôle

Écran de critères et de calcul du « Chiffre d'affaires par type clients (sur factures archivées
exclusivement) » : remplit la table de travail `Total` (une ligne par type client : brut,
remises, net, net N-1) à partir de `Fiches_HistoFac`/`Fiches_HistoFacM`, puis ouvre
`VisStatTypCli`.

## Points clés

- Copie de `StatComm` à 80 % (même `_New`, mêmes handlers de dates, même schéma de
  `Traitement`) : socle `StatCommun` proposé (voir StatComm).
- `Traitement` (CC 25) : SQL ligne à ligne, tables en dur, lecture des contrôles.
- Le N-1 est calculé **dans** la boucle des factures N.

## Dépendances principales

- Ouvert par `Fmenu.Menu176_Click` ; ouvre `VisStatTypCli` (structure de `Total` partagée).
- Tables `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Cli`, `Fiches_Typec`, `Fiches_Parametres`,
  `Total`.

## Risques

- **A01** : N-1 multiplié par le nombre de factures N du client.
- **A02** : N-1 limité à `HistoFac` quelle que soit la source.
- **A03** : client ou type supprimé → erreur d'exécution.
- **A04** : table `Total` partagée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 208 |
| Lignes de commentaire | 33 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 25 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `replay` (source hors entretien, sources, N-1 multiplié, absents, cas limites,
SQLite) et 1 `gbtest` après séparation. Jeu `statistiques_ventes` (voir StatComm).

## Rework

7 étapes (STATTYPCLI-001 à 007) : documentation, code mort, `Cbase.Table`, portée de 4
fonctions, socle `StatCommun`, séparation `CalculTotal`, cumul en mémoire (après A01).
4 anomalies (A01 à A04).
