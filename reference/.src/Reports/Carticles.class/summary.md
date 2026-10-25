# Carticles — Synthèse

> Source : `.src/Reports/Carticles.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des éditions d'articles et de stock de la gestion
commerciale : titre de page, en-têtes de colonnes (`Level1`, `Level2`, `Level7*`, `Level9*`,
`Level11`, `Level13*`, `Level1MO`), lignes de détail (`Level3`, `Level4`, `Level6*`, `Level8*`,
`Level12`, `Level14*`, `Level2MO`), totaux (`Level5`), prix conseillé (`Level10`), photo, traits et
pied de page. Rendu pur : aucune donnée lue en base, aucun calcul.

## Points clés

- 36 méthodes toutes `Public`, de complexité 1 : une suite de `SetXY`/`SetFont`/`Cell` par méthode.
- Les valeurs arrivent formatées ; la pagination (`PosY`, seuil) est gérée par l'écran appelant.
- `Footer` surcharge `PdfWriter.Footer` mais n'est jamais appelée automatiquement.
- 4 méthodes sans appelant (`Level3bis`, `EnteteTC`, `Level2TC`, `Level3TC`) ; 5 méthodes qui ne
  servent qu'à l'écran mort `EdArt2` (`Level8`, `Level8bis`, `Level9`, `Level9bis`, `Ligne2`).
- Schéma « en-tête de colonnes / ligne de colonnes » répété 26 fois : deux helpers suffisent.

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) ; lit `Start.R/G/B`, `/Soc<XX>/Taxe`.
- Utilisé par 8 éditions de `Gestion/Impressions` : `EdArt1`, `EdArt3`, `EdStk`, `EdRup`, `Edmo`,
  `Edregul`, `Edregulprdc` et `EdArt2` (mort, EDART2-A01).

## Risques

- **CARTICLES-A01** : `Level6bis` demande la police « Hel8vetica » → « Undefined font » ; le tarif
  interne avec photos (`EdArt3`) plante au premier article.
- **CARTICLES-A02** : titre de page à x = 40 sur 206 mm, il déborde de la page A4 (depuis 2017).
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, PDFWRITER-A01) et largeur de texte fausse
  (alignements à droite décalés, PDFWRITER-A02), visibles sur les colonnes de prix.
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, PDFWRITER-A01) et largeur de texte fausse
  (alignements à droite décalés, PDFWRITER-A02), visibles sur les colonnes de prix.
- Toute modification de `PdfWriter` (`Cell`, `SetFont`, `Image`) se répercute sur 8 éditions.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 370 |
| Lignes de commentaire | 27 |
| Fonctions | 36 |
| Fonctions Public | 36 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 2 (`Photo`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus : 7 `gbtest` qui appellent directement les méthodes et comparent le texte
`pdftotext` et le flux PDF non compressé (date et utilisateur masqués), 1 `gbtest` pour
`FormatAligne`, 1 `replay` par les écrans sur le jeu `editions_articles`. L'erreur de police de
`Level6bis` est figée par CARTICLES-T03.

## Rework

7 étapes (CARTICLES-001 à 007) : documentation, suppression du code mort (dont les méthodes
d'`EdArt2` après EDART2-A01), création de la base commune `PdfLaurux` (couleur, pied de page,
titre, traits), helpers de colonnes, `FormatAligne` et `EnteteTarif` partagés avec les éditions.
3 anomalies (A01 police, A02 titre décalé, A03 décalage des totaux).
