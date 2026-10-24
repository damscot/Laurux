# CTestTVA — Synthèse

> Source : `.src/Utils/CTestTVA.class` · Synthèse des autres documents.

## Rôle

Calcul de la clé et contrôle du numéro de TVA intracommunautaire français (SIREN).

## Points clés

- Deux fonctions statiques ; formule de clé dupliquée.
- `Message.Warning` dans la fonction de contrôle.
- Seul le pays `FR` est vérifié ; les autres renvoient `False`.

## Dépendances principales

- Appelée par `Fsoc` (calcul et contrôle) et `FFournisseur` (contrôle).

## Risques

- Clé < 10 mal formatée par l'appelant `Fsoc`.
- Erreur non interceptée si le SIREN contient des lettres.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 7 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 6 (`isIntraComValide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 `gbtest` (CTESTTVA-T01 à T04) et 1 replay sur la fiche société (T05).

## Rework

4 étapes (documentation, réutilisation de la formule, séparation du message, conversion en module) et
3 anomalies (A01 à A03).
