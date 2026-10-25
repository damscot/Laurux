# Glcr — Synthèse

> Source : `.src/Gestion/Lcr/Glcr.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Impression / suppression LCR » : liste filtrée des LCR (`Fiches_Lcr`) par état écarté,
attribution à une banque, code entrée et échéance ; impression PDF de la liste et suppression des
LCR affichées.

## Points clés

- Toute la sélection est dans `Deb` (CC 39), arbre de `If` avec de nombreux SQL invalides
  (`andand`, `",1"` dans la chaîne, dates non quotées).
- Liste des banques toujours vide (`Cbase.Table("TabBanques")` inexistant, CBASE-A01).
- Code mort : 3 handlers inactifs du groupe `Btn`, `CheckBox1_Click`, impressions `Draw`
  `Level2..4`, branche l. 116.
- Boutons « Quitter » et « Doc HTML » sans handler.
- Rejouable (`Utils.Observers`), mais `ColLcr` sans `ColLcr_Click`.

## Dépendances principales

- Ouvert par `Fmenu.Menuis_Click`. Utilise `CLcr`, `Utils`, `Cbase`, `Visualiseur`.
- Table : `Fiches_Lcr` (lecture et suppression).

## Risques

- Suppression de LCR rattachées à un bordereau (`bordereau <> 1` au lieu de `= 0`, A07).
- Filtres d'échéance et « non attribuées » inutilisables (A02-A04).
- Impression trompeuse : colonnes décalées, total absent (A05, A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 305 |
| Lignes de commentaire | 14 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 84 |
| Complexité max (fonction) | 39 (`Deb`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (GLCR-T01 à T08) : ouverture, filtres, impression (PDF par `pdftotext`), suppression
(dump `Fiches_Lcr`), boutons inactifs. Critère principal des filtres : lignes `Exec_SQL`.

## Rework

7 étapes (GLCR-001 à 007) : documentation, code mort, portée de `Deb`, séparation de la requête et
de la suppression, réduction de complexité après décision sur les anomalies, commonalisations
banques et couleurs. 9 anomalies (GLCR-A01 à A09).
