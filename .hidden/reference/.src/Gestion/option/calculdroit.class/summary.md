# calculdroit — Synthèse

> Source : `.src/Gestion/option/calculdroit.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Première version (la plus utilisée) du calcul des **droits sur les alcools** de l'option boissons :
pour un article (régie, volume en cl, degré) et une quantité, calcule en `Float` les volumes
(total, alcool pur), le droit, la cotisation sécurité sociale, leurs TVA, et expose les données de
la régie (`Fiches_regie`).

## Points clés

- Droit = (alcool pur si `ap`, sinon volume) × `tauxa / 100` ; sécu seulement au-delà du degré
  seuil `degres` ; TVA du droit au taux de la régie, TVA de la sécu au taux `Fiches_Parametres.tvass`.
- Montants totaux (quantité incluse) arrondis à 2 décimales à la lecture.
- Quantité `Variant` : la virgule est remplacée par un point pour la conversion implicite.
- 17 constructions dans 12 fichiers (facturation, stock, éditions, fiches) ; aucune réduction de
  portée possible.
- Même règle que `calculdroit1` (version objet), avec seulement 7 lignes textuellement communes.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.arrondi` ; tables `Fiches_regie`, `Fiches_Tvaav`,
  `Fiches_Parametres`.
- Utilisé par : `ObjFacB`, `facopt`, `Mvtex`, `ValidBR`, `Validinv`, `Caleditcmat`,
  `EditStkDepart`, `Edart4`, `artopt`, `Tregie`, `TarArt`, `Saisiedecons`.

## Risques

- `Message.Error` dans une classe de calcul (non testable sans affichage).
- Taux de TVA exposés en fraction sur 2 décimales, réécrits par `ObjFacB` après stockage par
  `Mvtex` : taux de 5,5 % arrondi (à confirmer).
- Conversions dépendantes de la locale française.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 160 |
| Lignes de commentaire | 3 |
| Fonctions | 23 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 15 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (CALCULDROIT-T01 à T08) : 7 `gbtest` (assiettes volume et alcool pur, seuil de sécu,
quantité `Variant`, accesseurs, écritures, erreurs) et 1 replay de facture boissons.

## Rework

6 étapes (CALCULDROIT-001 à 006) : documentation, découpage de `_new`, séparation des
`Message.Error`, accesseurs `Use`, `Cbase.Table`, lecture de régie commune avec `calculdroit1`.
2 anomalies (A01 arrondi des taux, A02 erreurs silencieuses).
