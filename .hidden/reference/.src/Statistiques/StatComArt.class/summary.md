# StatComArt — Synthèse

> Source : `.src/Statistiques/StatComArt.class` · Synthèse des autres documents.

## Rôle

Écran de critères et de calcul du CA « Articles par commercial (sur factures archivées
exclusivement) » : remplit `Total` (article × commercial : net HT, quantité) à partir des lignes
article des factures archivées, puis ouvre `VisStatComArt`.

## Points clés

- Même squelette que les autres `Stat*` (dates, `Btn`, `Total`) ; pas de N-1 mais `dateN1`
  toujours calculé (code mort).
- `Traitement` (CC 16) : 1 requête client par facture et 2 par ligne.
- En-tête de commentaire copié de `StatComm` (nom de fichier faux).

## Dépendances principales

- Ouvert par `Fmenu.Menu314_Click` ; ouvre `VisStatComArt` (structure de `Total` partagée).
- Tables `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_Cli`,
  `Fiches_Parametres`, `Total`.

## Risques

- **A01** : la quantité cumulée est remplacée par le code du commercial (`qte = &4`).
- **A02** : lignes des factures d'entretien lues dans la mauvaise table.
- **A03** : table `Total` partagée.
- **A04** : client supprimé → erreur d'exécution.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 30 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 41 |
| Complexité max (fonction) | 16 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `replay` (simple, cumul, entretien, clients, cas limites, SQLite), 1 `gbtest` après
séparation. Jeu `statistiques_ventes`.

## Rework

7 étapes (STATCOMART-001 à 007) : en-tête, code mort (`dateN1`…), `Cbase.Table`, portée, socle
`StatCommun`, séparation, cumul en mémoire (après A01). 4 anomalies (A01 à A04).
