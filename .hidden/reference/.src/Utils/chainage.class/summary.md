# chainage — Synthèse

> Source : `.src/Utils/chainage.class` · Synthèse des autres documents.

## Rôle

Chaînage de la saisie : navigation clavier entre une liste ordonnée de contrôles (Entrée/Tab/Bas →
suivant, Haut/Maj+Tab → précédent, avec bouclage) et coloration du contrôle actif.

## Points clés

- Observateurs `saisie` posés sur chaque contrôle ; `Stop Event` seulement pour Tab/Maj+Tab.
- Propriété `tableaux` exposant la liste interne, modifiée directement par `Sailig` et `Achat`.
- `modif` (bogué) et `addintercale` sans appelant.

## Dépendances principales

- Utilisée par ~30 écrans (`Parametre`, `Achat`, `GesTar`, `SaiReg`, `Sailig`, `TriGen`, `Lcr`,
  inventaires…), souvent via des objets non typés (non vus par deps.py).
- Utilise `Utils.ObsGotf`/`ObsLstf`.

## Risques

- Classe transverse : toute régression touche la saisie de nombreux écrans.
- Ordre des événements différent entre `_new` et `add` ; liste vide → erreur dans `recherche`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 76 |
| Lignes de commentaire | 2 |
| Fonctions | 10 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 13 (`saisie_keypress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 `gbtest` sur la gestion de liste (CHAINAGE-T01 à T03) et 4 replays de navigation et coloration
(T04 à T07).

## Rework

4 étapes (documentation, code mort, simplification de `recherche`, séparation de la navigation) et
4 anomalies (A01 à A04).
