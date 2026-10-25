# EditfacB — Synthèse

> Source : `.src/Gestion/option/EditfacB.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

État imprimé des documents de vente (sous-classe du report `Editfac`). En option boisson et pour
un document boisson, il ajoute par code les colonnes de consignation et d'alcool, le bandeau des
droits, les totaux consigne/déconsigne, les cadres DSA et passe la facture en paysage.

## Points clés

- Construit par `New EditfacB(Me, Me)` dans `ObjFacB` (le premier argument va à `Editfac`).
- `_new` de près de 500 lignes de mise en page répétitive (CC 10).
- `code_data`/`intitule_Data` surchargent les handlers d'`Editfac` : faux `unused` de `deps.py`.
- Lignes de déconsigne ajoutées après les lignes du document.

## Dépendances principales

- Utilisé par : `ObjFacB` (5 constructions).
- Utilise : `Editfac` (parent), `ObjFacB` (cumuls, `borientation`, `poid`), `Utils.Option`,
  `Utils.totobs`.

## Risques

- Toute modification de mise en page change le PDF : tests par comparaison de texte PDF.
- A01 : volumes possibles sur les lignes de déconsigne ; A02 : alternance de couleurs du BL non
  chiffré.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 628 |
| Lignes de commentaire | 14 |
| Fonctions | 13 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 38 |
| Complexité max (fonction) | 10 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (EDITFACB-T01 à T04) par comparaison du PDF produit par
`ObjFacB.visualisation` : état standard, BL non chiffré, facture boisson, lignes de déconsigne.

## Rework

5 étapes (EDITFACB-001 à 005) : documentation, découpage de `_new`, helper des handlers de
colonnes, appel unique à `Utils.Option`, orientation reprise d'`ObjFacB`. 2 anomalies.
