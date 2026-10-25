# ACom — Synthèse

> Source : `.src/Affichages/ACom.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

D'après le code : fenêtre modale de **consultation du détail d'une commande fournisseur**
(`Fiches_Ligcom`), ouverte depuis la liste des commandes d'un article dans `Articles`. Lecture seule.

## Points clés

- Copie adaptée d'`AFacture` (mêmes noms de contrôles « client »/« facture », ratio 0,67).
- Une seule fonction de traitement (`DocCom`) mêlant requêtes et affichage.
- Pas de test `Available` ; quantité formatée écrasée.
- Pas de `Utils.Observers(Me)` ; `Colrcp3` sans `_Click`.

## Dépendances principales

- Appelant : `Articles.Colcom_Activate` (`Articles.class:4247`).
- Tables : `Fiches_Four`, `Fiches_Ligcom`, `Fiches_Art` (lecture).

## Risques

- **A01** : fournisseur supprimé → erreur à l'ouverture.
- **A02** : quantité affichée non formatée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 65 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`DocCom`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests : 3 `replay` depuis `Articles` (détail, fournisseur supprimé, fermeture), conditionnés à
l'instrumentation de l'écran, et 1 `gbtest` sur `LignesCommande`.

## Rework

5 étapes (ACOM-001 à 005) : documentation, code mort, réduction de portée de `DocCom`, séparation des
requêtes, module commun `DetailDocument` avec `AFacture` et `TriHistos`. 2 anomalies (A01, A02).
