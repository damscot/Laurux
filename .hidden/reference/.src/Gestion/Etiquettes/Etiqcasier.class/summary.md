# Etiqcasier — Synthèse

> Source : `.src/Gestion/Etiquettes/Etiqcasier.class` · Synthèse des autres documents.

## Rôle

Impression des étiquettes de casier (casier, code, intitulé, EAN13, stock) en PDF A4 ou Dymo 25 × 25, par plage ou par liste d'articles ayant un casier.

## Points clés

- Copie d'Etiqart à 92 % ; liste affichée dans `listBart` (pas de grille) ; `pos_Etiq` V3.
- Même PDF (`~/tmp/EtiqArt.pdf`) et même page d'aide qu'Etiqart.
- Format lu par `code` seul (page ignorée).

## Dépendances principales

- Appelants : `Fmenu.Menu302_Click`, `Articles.Btn_click`.
- Tables `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Etiquettes`, `Etiquettes` (permanente).

## Risques

- Zebra → « Null object » (A01) ; page de format ignorée (A02) ; espacement de colonnes compté une fois (A03) ; défauts hérités d'Etiqart (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 793 |
| Lignes de commentaire | 72 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 187 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests (8 `replay`, 1 `gbtest` variante V3).

## Rework

10 reworks (dont `EtiqArticles` ×3 et `PlancheEtiquettes`, dessin casier partagé avec EtiqRecpt). 4 anomalies.
