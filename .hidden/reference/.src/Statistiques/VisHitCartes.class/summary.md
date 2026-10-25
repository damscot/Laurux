# VisHitCartes — Synthèse

> Source : `.src/Statistiques/VisHitCartes.class` · Synthèse des autres documents.

## Rôle

Fenêtre d'affichage et d'impression du hit-parade des cartes de fidélité, ouverte par `HitCarte`.
Elle lit la table de travail `Total` (tri par points ou par visites, `LIMIT` choisi), affiche rang,
carte, nom, points, visites et part des points, dessine un histogramme (20 cartes au plus) et
imprime la liste en PDF (`Chistoriques`).

## Points clés

- Lecture seule : aucune écriture en base.
- Contrat implicite avec `HitCarte` : colonnes de `Total` et signature de `_New` à 6 paramètres
  (`Hitniv` inutilisé).
- Histogramme recopié de `TBord` (variante d'échelle) ; impression recopiée des `VisStat*`.
- `Liste` sans `Liste_Click` : un clic rejoué sur la liste échouerait.

## Dépendances principales

- Seul appelant : `HitCarte.class:223`.
- Utilise `Chistoriques`, `Visualiseur.Prog`, `Utils` (`Observers`, couleurs, `db`), table `Total`.

## Risques

- Division par zéro si toutes les cartes ont 0 point (A01).
- Détails d'impression incohérents : deux titres, fichier `.kud`, visites absentes, curseur (A02).
- Histogramme : somme tronquée en entier, barres nulles dessinées (A03, visuel).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 171 |
| Lignes de commentaire | 26 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 7 (`Draw_Chart`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests prévus (VISHITCARTES-T01 à T05) : 4 replays enchaînés après `HitCarte` (tri par points,
tri par visites sur 2 pages, points nuls, fermeture) comparant le texte du PDF (`pdftotext`) et les
lignes `Exec_SQL`, puis 1 gbtest des ratios après extraction.

## Rework

6 étapes (VISHITCARTES-001 à 006) : documentation, code mort, séparation lecture/calcul/affichage,
calcul de `value` sans relecture du texte, histogramme commun avec `TBord`, réduction de portée de
`Draw_Chart`. 3 anomalies (VISHITCARTES-A01 à A03).
