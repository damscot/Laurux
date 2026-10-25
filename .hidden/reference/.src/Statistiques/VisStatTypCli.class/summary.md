# VisStatTypCli — Synthèse

> Source : `.src/Statistiques/VisStatTypCli.class` · Synthèse des autres documents.

## Rôle

Visualisation et impression du CA par type client calculé par `StatTypCli` : grille `Liste`
(brut, remise, net, net N-1, % N/N-1), totaux, PDF.

## Points clés

- Lecture seule de la table de travail `Total` ; tris par RadioButton (`Click`, correct ici).
- % N/N-1 calculé sur la base N-1 (alors que `VisStatFour` divise par N).
- Code mort : couleurs, boucle `Totl`, `total`, `value`.
- Famille `VisStat*` : socle commun proposé (voir VisStatComm).

## Dépendances principales

- Ouvert par `StatTypCli.Traitement` ; `Chistoriques` (PDF), `Visualiseur`, `Utils`.

## Risques

- **A01** : pas de saut de page à l'impression.
- **A02** : total des % imprimé incohérent avec l'écran.
- **A03** : PDF nommé `.ps`.
- Données N-1 faussées en amont (STATTYPCLI-A01/A02) ; table `Total` partagée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 206 |
| Lignes de commentaire | 23 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 30 |
| Complexité max (fonction) | 10 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 4 `replay` (affichage, tris, impression longue, fermeture), 1 `gbtest` après
séparation. Ne pas cliquer dans `Liste`.

## Rework

6 étapes (VISSTATTYPCLI-001 à 006) : documentation, code mort, portée, socle `VisStat*`,
fonction d'évolution, séparation. 3 anomalies (A01 à A03).
