# RazHistoFac — Synthèse

> Source : `.src/Archivages/RazHistoFac.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Epuration des factures archivées » (`Fmenu.Menu259`, `Prgm` nom `eff`) : supprime les
factures clients (`Fiches_HistoFac` + lignes) antérieures à la date choisie et, en option matériel,
les factures entretien (`Fiches_HistoFacM` + lignes), après confirmation et sauvegarde `mysqldump`.

## Points clés

- `Fiches_HistoFac` est **la** table des factures émises : la purge supprime des justificatifs.
- Suppression exacte par `numfac` (clé primaire) ; borne `<` stricte.
- Tables liées non purgées (matériel, suivis, traites, LCR, BL facturés, GED…).
- Copie quasi exacte de `RazDevis` ; écran non instrumenté.

## Dépendances principales

- Appelé par `Fmenu.Menu259_Click` et `Prgm` ; utilise `Utils.db`, `Cbase.Table`, `ProgBar`,
  `Syntheses.Message`, `Shell mysqldump`, l'option `/Soc<XX>/Materiel`.

## Risques

- Pas de garde-fou légal ni comptable, recalcul de stock faussé (A01, décision utilisateur) ;
  orphelins (A02) ; sauvegarde non contrôlée (A03) ; SQLite sans effet (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 49 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 11 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (RAZHISTOFAC-T01 à T06) : nominal, option matériel cochée/décochée, abandon,
interruption, sauvegarde et SQLite ; dump avant/après, horloge figée, **à valider par
l'utilisateur**.

## Rework

4 étapes (RAZHISTOFAC-001 à 004) : documentation, factorisation des deux blocs, séparation
`Purge`, commonalisation avec `RazDevis` et les autres `Raz*`. 4 anomalies (A01 à A04).
