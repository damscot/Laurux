# EdMat — Synthèse

> Source : `.src/Gestion/Impressions/EdMat.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des matériels** vendus et/ou en stock (`Fmenu.Menu289_Click`),
filtrés par code, propriétaire et marque ; PDF `~/tmp/Tarif2.pdf` produit par `Cmat`.

## Points clés

- Lit `Fiches_Materiels` et `Fiches_Marques` seulement (aucune table `*M` d'entretien).
- `TriMat` renvoie la sélection en écrivant `EdMat.Bsel`/`EdMat.CodeMat` sur l'auto-instance.
- Champs `Type`/`Type2` et boutons associés sans effet.

## Dépendances principales

- `Fmenu.class:2254`, `TriMat.class:381-382`, `TriCpt` ; `Cmat` ; `Utils`, `Cbase("TabMat")`.

## Risques

- Sélection du propriétaire qui vide le champ (`CClient` jamais renseigné).
- Erreur SQL non interceptée sur code inconnu (`mat_refcentrale` inexistante).
- Filtre type annoncé mais absent.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 393 |
| Lignes de commentaire | 26 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 100 |
| Complexité max (fonction) | 35 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 `replay` (EDMAT-T01 à T08) : tous, vendus/stock, incohérence, tris et marques, pagination,
propriétaire, `TriMat`, saisie manuelle. Jeu `editions_articles` avec matériels.

## Rework

5 étapes (EDMAT-001 à 005) : documentation, code mort, séparation SQL/formatage, socle de
recherche et liste des marques communes, réduction de portée. 5 anomalies (EDMAT-A01 à A05).
