# RazDevis — Synthèse

> Source : `.src/Archivages/RazDevis.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Epuration des devis » (`Fmenu.Menu290`) : supprime les devis (`Fiches_Bl` de type `D` +
`Fiches_Ligbl`) antérieurs à la date choisie et, en option matériel, les devis entretien
(`Fiches_BlM` + `Fiches_LigblM`), après confirmation et sauvegarde `mysqldump`.

## Points clés

- Copie quasi exacte de `RazHistoFac` ; le `.form` en garde le titre « Epuration des factures
  archivées. ».
- Suppression exacte par `numbl` (clé primaire) ; borne `<` stricte ; filtre `type = 'D'`.
- Tables liées non purgées (`Fiches_AdrlivBL`, `Fiches_EntMat`, `Fiches_Suivis`, GED).
- Sauvegarde dans le même fichier que `RazClientd` ; écran non instrumenté.

## Dépendances principales

- Appelé par `Fmenu.Menu290_Click` ; utilise `Utils.db`, `Cbase.Table`, `ProgBar`,
  `Syntheses.Message`, `Shell mysqldump`, l'option `/Soc<XX>/Materiel`.

## Risques

- Orphelins (A01) ; sauvegarde écrasée et non contrôlée (A02) ; libellés erronés (A03) ; SQLite
  sans effet, pas de garde-fou (A04).

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

5 tests `replay` (RAZDEVIS-T01 à T05) ; dump avant/après, horloge figée, **à valider par
l'utilisateur**.

## Rework

4 étapes (RAZDEVIS-001 à 004) : documentation, factorisation des deux blocs, séparation `Purge`,
commonalisation avec `RazHistoFac`. 4 anomalies (A01 à A04).
