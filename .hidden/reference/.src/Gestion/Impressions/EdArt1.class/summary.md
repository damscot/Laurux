# EdArt1 — Synthèse

> Source : `.src/Gestion/Impressions/EdArt1.class` · Synthèse des autres documents.

## Rôle

Écran d'impression du **tarif interne** des articles (Gestion > Impression des tables > Tarif >
Interne, `Fmenu.Menu73_Click`). Plages article / famille / fournisseur, 4 tris, option marge ;
PDF `~/tmp/Tarif1.pdf` produit par `Carticles` (PdfWriter) et ouvert par `Visualiseur.Prog`.

## Points clés

- Lecture seule : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four` (noms en dur sauf `art_man`).
- Toute l'impression est dans `Button2_Click` (CC 31) ; `Button2` est dans le groupe `btn`, donc
  `Button2_Click` n'est pas un handler (réductible en `Private`).
- Mode photo présent dans le code mais case `Phot` invisible dans le `.form`.
- Très forte duplication : 91 % avec `EdArt3`, 81 % avec `EdArt2` (mort), 64 % avec `EdStk` ;
  20 copies du bloc « liste ColumnView » dans 5 fichiers du lot.

## Dépendances principales

- Appelé uniquement par `Fmenu.class:857` (`EdArt1.Show`).
- Utilise `Carticles` (en-têtes `Level7*`, lignes `Level6*`, `Level10`), `TriArticles` (écrit
  `Bsel`/`Bval`), `textfamille` (`Quit` si `/Soc<XX>/ipr` absent), `Utils`, `Cbase`, `Visualiseur`.

## Risques

- `Bsel` jamais remis à faux (sélection annulée → ancien article recopié).
- Contrôle du 2ᵉ code article sur le 1ᵉʳ champ (`Cmpt_KeyPress` tag 2).
- Impression déclenchée par n'importe quelle touche sur « Imprimer » (double impression probable à
  la barre d'espace).
- Pas de `Catch` : curseur bloqué en attente sur erreur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 532 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 `replay` (EDART1-T01 à T10 : tris, marge, prix consommateur, plages, cas vide, saisie
manuelle, listes, `TriArticles`, fermeture) comparant le texte `pdftotext` du PDF et les
`Exec_SQL`, et 1 `gbtest` (T11) après extraction du formatage. Jeu dérivé `editions_articles`
décrit dans test.md (commun aux éditions d'articles, de stock, de matériels et de main d'oeuvre).

## Rework

9 étapes (EDART1-001 à 009) : documentation, code mort, socle `EdSelection` (listes, recherche
d'article, requête articles) partagé avec `EdArt3`/`EdStk`/`Edmo`/`EdRup`, format d'alignement
commun, procédure `ImprimeTarif` commune avec `EdArt3`, séparation SQL/formatage, réduction de
portée de 3 membres. 7 anomalies (EDART1-A01 à A07) soumises à validation.
