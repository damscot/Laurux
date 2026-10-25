# MvtProdcomp — Synthèse

> Source : `.src/Gestion/Stock/MvtProdcomp.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Entrées des produits composés » (Gestion › Stock) : fabrication (entrée) ou démontage
(sortie) d'un produit composé. Chaque saisie met à jour immédiatement le stock du produit et de
ses composants (`Fiches_PrdComp`) et écrit des mouvements `Fiches_Mvtexpdc` (types `P` et `C`)
regroupés par un identifiant de lot `mind`.

## Points clés

- Écriture en base à chaque « Enregistrer » ; la grille n'est qu'un journal, sans validation.
- `art_qte` écrit avec une valeur calculée côté client ; aucune transaction.
- Le `Catch` de `Maj_colrcp` confond doublon et erreur ; cumul et remplacement sont faux.
- `RazBl` (code mort) appelle `Comment.clear` : `Comment` y désigne le formulaire
  `Gestion/Tables/Comment` (pas de contrôle de ce nom ici), sans méthode `Clear` — défaut latent.
- `Colart_Click` doit rester `Public` (rejeu dynamique).

## Dépendances principales

- Appelé par `Fmenu.Menu230_Click`.
- `Cbase.Table` (`TabArt`, `TabMvtexpdc`, `TabPrdComp`), `Utils` (`db`, `Cdec`, `cpoint`,
  `Cdate_Dbase`, `Find_cbarre`, `SetEditColor`, `Observers`), `Doc`.
- Données relues par `Cstock`, `Stockmvt`, `Edregulprdc` ; nomenclature gérée par `Prodcomposes`.

## Risques

- A01/A02 : ressaisie d'un produit → stock faux, mouvements et composants absents.
- A03 : produit sans composant → écritures partielles.
- A04/A05 : `mind` non protégé contre la concurrence ; `UPDATE` latent qui écrirait le stock total
  dans un mouvement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 408 |
| Lignes de commentaire | 78 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 14 (`Rcpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (MVTPRODCOMP-T01 à T08) sur `Fiches_Art` et `Fiches_Mvtexpdc` : entrée,
sortie, cumul et remplacement (anomalies figées), contrôles d'article, sélection par liste,
bascule entrée/sortie, numérotation `mind`.

## Rework

8 étapes (MVTPRODCOMP-001 à 008) : documentation, code mort (`RazBl` avec `Comment.clear`,
`Quantite`), fusions des fonctions dupliquées, séparation des écritures, requête redondante,
réduction de portée de 10 fonctions, `Cbase.Table`, commonalisation avec `Mvtex`. 5 anomalies
(A01 à A05) soumises à validation.
