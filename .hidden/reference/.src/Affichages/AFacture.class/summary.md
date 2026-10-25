# AFacture — Synthèse

> Source : `.src/Affichages/AFacture.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

D'après le code : fenêtre modale de **consultation des lignes d'un document de vente** (BL, facture
en cours), lues dans `Fiches_Ligbl` ou, à défaut, dans l'archive `Fiches_LigblM`, avec total HT et
nombre de lignes. Lecture seule.

## Points clés

- 4 appelants : `Facture.AffDoc`, `Facturefm`, `Facturergbl`, `Articles`.
- Une seule fonction de traitement (`DocVentes`) mêlant requêtes et affichage ; table d'archive en dur.
- Modèle copié par `ACom` (ratio 0,67) et dupliqué dans `TriHistos.DocVentes`.
- Pas de `Utils.Observers(Me)` ; `Colrcp3` sans `_Click`.

## Dépendances principales

- Tables : `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Art` (lecture).
- Utilise `Utils.db`, `Utils.CDec`, `Cbase`.

## Risques

- **A01** : document sans ligne → erreur et fenêtre fermée avant `ShowModal`.
- **A02** : quantité affichée non formatée.
- Total HT dépendant de la locale (`Val()` sur des montants texte à virgule).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 82 |
| Lignes de commentaire | 5 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 12 (`DocVentes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 4 `replay` (BL en cours, archive, document vide, ouverture depuis `Articles`),
conditionnés à l'instrumentation, et 1 `gbtest` (`LignesDocument`/`TotalLignes`, locale `fr_FR`).

## Rework

5 étapes (AFACTURE-001 à 005) : documentation, code mort et `Cbase.Table` pour l'archive, réduction
de portée de `DocVentes`, séparation des requêtes, module commun `DetailDocument`. 2 anomalies.
