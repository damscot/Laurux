# Mvtex — Synthèse

> Source : `.src/Gestion/Stock/Mvtex.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Mouvement de stock exceptionnel » (Gestion › Stock) : saisie de régularisations de stock
(entrées/sorties) dans une grille, puis enregistrement dans `Fiches_Mvtexp` avec mise à jour de
`Fiches_Art.art_qte`, lignes de régie et vignette pour l'option boissons, édition PDF.

## Points clés

- Saisie par groupes de contrôles `Rcpt` (date, article, désignation, quantité, commentaire) et
  `Btn` (enregistrer, valider, quitter), dispatch par `Last.Tag`.
- `Enrgbl` (CC 16) : `INSERT` + `art_qte += qte` sous `LOCK TABLES`, **sans transaction** ;
  `Fiches_ligregie` + `nvign` en option `B`/`T` ; PDF `~/tmp/mvtex.pdf`.
- Pas de `Lockstock` (ni PAMP ni dépôt) : cohérent avec `Cstock`, qui relit `qtep - qtem`.
- `Quantite` morte ; `rcppt_keypress` jamais levé (F1/F2 inopérants).

## Dépendances principales

- Appelé par `Fmenu.Menu79_Click`.
- `TriArticles` (sélection, `Bsel`/`Bval`), `VerifDate.ClotDroi`, `Calculdroit`, `Visualiseur`,
  `Doc`, `Utils` (`db`, `Option`, `totobs`, `cpoint`, `Find_cbarre`, `Observers`).
- Données relues par `Cstock`, `Stockmvt`, `TriHistos`, `Edregul`, `ValidinvT` ; purgées par
  `Epurmvtexp`.

## Risques

- Enregistrement non atomique (A02) ; verrous et numérotation de régie fragiles en multi-poste
  (A03, à confirmer) ; signe inversé sur l'édition des volumes (A04, à confirmer).
- `nvign` hors schéma de référence (`modfichier.module`).
- `Colrcp` sans `Colrcp_Click` : rejeu par clavier/`Activate` seulement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 589 |
| Lignes de commentaire | 66 |
| Fonctions | 22 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 16 (`Enrgbl`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests `replay` (MVTEX-T01 à T09) : entrée, sortie, cumul/remplacement, rappel/suppression,
fermeture, contrôles d'article, option boissons (régie, vignette), période de droits close,
raccourcis F1/F2 (A01 figée).

## Rework

9 étapes (MVTEX-001 à 009) : documentation, code mort, factorisations locales, séparation de
l'enregistrement, réduction de portée de 8 fonctions, `Cbase.Table`, édition, commonalisations
« saisie d'article » (avec `MvtProdcomp`, `MvtDepots`, `Sdepots`) et « vignette » (avec
`commande1`). 4 anomalies (A01 à A04) soumises à validation.
