# Numtostring — Synthèse

> Source : `.src/Utils/Numtostring.module` · Synthèse des autres documents.

## Rôle

Conversion d'un montant en toutes lettres (« deux cent euro et cinquante centime ») pour le total
des factures en lettres (`ObjFac`) et le solde des relevés de relance (`FRelFacture`).

## Points clés

- Calcul pur, issu d'un code espagnol ; `Num2Text` récursif jusqu'à 10¹².
- Cascade d'une trentaine de `If value = n Then Return …`.
- Un second module quasi homonyme existe pour la caisse (`Caisse/numtostring.module`), mais il n'est pas
  compilé : `Caisse.Imp_Cheque` appelle ici un `nbtostring` absent (NUMTOSTRING_CAISSE-A01).

## Dépendances principales

- Appelé par `ObjFac.class:653` et `FRelFacture.class:427` (et `FRelFacture.Solde`, code mort).
- Aucune dépendance sortante (module feuille).

## Risques

- Montants inférieurs à un euro ou avec moins d'un centime : chaîne vide.
- Centimes tronqués ; orthographe française approximative.
- Confusion possible entre `Numtostring` et `numtostring` (casse).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 144 |
| Lignes de commentaire | 12 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 58 (`Num2Text`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `gbtest` (NUMTOSTRING-T01 à T06) sur `Num2Text`, `Convertir`, `palabraPlural`, et un replay
de facture en lettres (T07).

## Rework

5 étapes (documentation, code mort, tables de mots, portée de `palabraPlural`, étude de fusion avec
le module de la caisse) et 4 anomalies (A01 à A04).
