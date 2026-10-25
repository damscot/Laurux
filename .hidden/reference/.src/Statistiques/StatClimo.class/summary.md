# StatClimo — Synthèse

> Source : `.src/Statistiques/StatClimo.class` · Synthèse des autres documents.

## Rôle

Écran de critères et de calcul du « Chiffre d'affaires produits/mo par client » : cumule par
client le brut et les remises des lignes article (`A`) et main d'oeuvre (`M`) des factures
archivées **et** des BL/factures en cours, dans `Total`, puis ouvre `VisStatClimo`.

## Points clés

- Seul écran de la famille à inclure `Fiches_Bl` (case « Inclure les BL ») ; pas de N-1 mais
  `dateN1` toujours calculé (code mort).
- `Traitement` (CC 37) : deux blocs presque identiques (factures, BL), SQL ligne à ligne.
- Commentaires « Sans/avec les BL » inversés par rapport au code.

## Dépendances principales

- Ouvert par `Fmenu.Menu117_Click` (et `Menu201_Click`, séparateur) ; ouvre `VisStatClimo`.
- 8 tables de ventes en dur + `Fiches_Parametres` + `Total`.

## Risques

- **A01** : tous les BL de type `B`, hors période, sont comptés (priorité `AND`/`OR`).
- **A02** : factures en cours incluses sans contrôle de recouvrement.
- **A03** : `union` des lignes par numéro (mélange de factures, dédoublonnage).
- **A04** : `Val` sans `cpoint` sur les lignes `M` (erreur sur format point).
- **A05** : table `Total` partagée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 235 |
| Lignes de commentaire | 37 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 37 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests : 7 `replay` (sans BL, avec BL, union, format point, entretien, cas limites, SQLite),
1 `gbtest` après séparation. Jeu `statistiques_ventes`.

## Rework

7 étapes (STATCLIMO-001 à 007) : documentation, code mort, `Cbase.Table`, portée, socle
`StatCommun`, séparation, factorisation du calcul A/M. 5 anomalies (A01 à A05).
