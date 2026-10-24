# Expbase — Synthèse

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Synthèse des autres documents.

## Rôle

Envoi par courriel de la dernière sauvegarde SQL (`.sql` ou `.sql.gz`) de la base à l'adresse
configurée pour la société (`/Soc<XX>/Adr-base`).

## Points clés

- Aucun export réel : la sauvegarde doit avoir été faite par `FSauve`/`SauvesAuto`.
- Envoi délégué à `EnvMail.Envoi2`.
- `Button1_Click` vide (lié au `.form`, conservé).

## Dépendances principales

- `Fmenu.Menu171_Click` (non vu par deps.py) ; `EnvMail`, `Start.LocalSettings`, `Utils.db.Name`.

## Risques

- Envoi tenté même si le fichier de sauvegarde n'existe pas.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 42 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (EXPBASE-T01 à T03) avec envoi de courriel neutralisé.

## Rework

4 étapes (documentation, séparation, simplification, chemin de sauvegarde commun) et 1 anomalie (A01).
