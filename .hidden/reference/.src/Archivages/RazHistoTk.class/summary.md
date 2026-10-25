# RazHistoTk — Synthèse

> Source : `.src/Archivages/RazHistoTk.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Epuration des tickets de caisse » (`Fmenu.Menu260`, `Prgm` nom `eft`) : supprime les
tickets archivés par le moulinage (`Fiches_HisEntTickets` + `Fiches_HisLigTickets`) dont la date est
strictement antérieure à la date choisie, après confirmation et sauvegarde `mysqldump`.

## Points clés

- Boucle ticket par ticket avec `ProgBar` interruptible ; aucune transaction.
- Suppression **par numéro seul** : un ticket de même numéro hors période est supprimé aussi.
- Données purgées utilisées par `ArchivesTck`, `Statcai`, `HitCarte`, `EdRup`, `FClientcarte`,
  `Moulinage` (livre de caisse) ; chaîne d'intégrité `control`/`prev_numero` entamée.
- Clés `Cbase` en doublon (`TabHEntTck`/`TabHisEntTck`) ; écran non instrumenté.

## Dépendances principales

- Appelé par `Fmenu.Menu260_Click` et `Prgm` ; utilise `Utils.db`, `Cbase.Table`, `ProgBar`,
  `Syntheses.Message`, `Shell mysqldump`.

## Risques

- Purge hors période par doublon de numéro (A01, à confirmer) ; pas de garde-fou réglementaire
  (A02, décision utilisateur) ; sauvegarde non contrôlée (A03) ; SQLite sans effet (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (RAZHISTOTK-T01 à T06) : nominal, abandon, doublon de numéro, interruption,
sauvegarde, SQLite ; dump avant/après, horloge figée, **à valider par l'utilisateur**.

## Rework

4 étapes (RAZHISTOTK-001 à 004) : documentation, clés `Cbase`, séparation `Purge`, commonalisation
(`Epuration`, `Utils.DumpBase`). 4 anomalies (A01 à A04).
