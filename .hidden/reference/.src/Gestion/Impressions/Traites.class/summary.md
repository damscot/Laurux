# Traites — Synthèse

> Source : `.src/Gestion/Impressions/Traites.class` · Synthèse des autres documents.

## Rôle

Écran d'impression du **listing des traites** (`~/tmp/Traites.pdf`) à partir de la table de
travail `Fiches_Traites` alimentée par `EcrAuto`, avec purge facultative de la table quand
l'option LCR de la société est inactive.

## Points clés

- Un handler `Button1_Click` fait tout : lecture, N+1 lectures client, PDF `Ccompta`, purge.
- Purge par `DROP TABLE` puis `CREATE TABLE` codé en dur, structure différente de la référence.
- `Level1`/`Level2` : ancienne mise en page `Draw`, code mort.
- Copie quasi conforme de `Lcr.Imp_Traites` (≈ 107 lignes communes).

## Dépendances principales

- Appelé par `Fmenu` (`Menu265`). Utilise `Ccompta`, `Visualiseur`, `Utils`, `Cbase("TabCli")`.
- Table `Fiches_Traites` partagée avec `EcrAuto` (écriture), `Lcr` (transfert, purge),
  `LauruxMaj` (création).

## Risques

- TRAITES-A01 : la purge modifie le schéma (colonne `imp` perdue, types changés) et peut supprimer
  la table sans la recréer.
- TRAITES-A02 : texte d'accueil trompeur (« mois en cours »).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 132 |
| Lignes de commentaire | 5 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 8 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (TRAITES-T01 à T05) : impression, purge (A01 figée, structure dans le dump),
option LCR, table vide, saut de page ; comparaison `pdftotext` + dump + `Exec_SQL`.

## Rework

5 étapes (TRAITES-001 à 005) : documentation, code mort, procédure commune avec `Lcr.Imp_Traites`,
séparation traitement/GUI, jointure. 2 anomalies (TRAITES-A01, A02).
