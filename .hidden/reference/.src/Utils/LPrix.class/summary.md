# LPrix — Synthèse

> Source : `.src/Utils/LPrix.class` · Synthèse des autres documents.

## Rôle

Objet valeur « prix » : montant unitaire (`Mnt`) × quantité (`Qte`), avec règle d'arrondi, compte
de ventilation et taxes/remises (`LTaxe`). Il fournit les formats d'affichage (`.L`), de base de
données (`.D`) et Gambas (`.G`), ainsi que les conversions Brut/Net × HT/TTC en unitaire (`Pu*`) et
en total (`Tot*`).

## Points clés

- `Create Static` + `Inherits Array` : l'usage courant est la fabrique `LPrix(montant, …)` via `_call`.
- Calcul pur, sans accès à la base ; le seul couplage GUI est `Message.Error` dans `Arrondi_Conv`.
- Arrondi « au 5 » (Arr_005, Arr_05…) implémenté par découpage de chaîne (`Arrondi_Calc`).
- Forte duplication : 14 accesseurs `Pu*`/`Tot*`, 3 boucles de taxes, 6 variantes de cumul.
- Fonction la plus complexe : `Conv_Brut_Net_HT_TTC` (CC 21).

## Dépendances principales

- Utilise : `LTaxe` (types et listes de taxes), `Utils.FloatParse`.
- Utilisé par 25 fichiers, surtout via `LPrix(…)` et `.L`/`.D`/`.G` : `Saisecrit`, `GesTar`,
  `Achat`, `VarMajTar`, `calculdroit1`, `TarTypeCli`, `LTaxe`, `Facture`, `ObjFac`…

## Risques

- **Anomalie de `_call`** : la quantité passée est ignorée (c'est `Qte` de l'auto-instance qui est
  utilisé). Cela touche `LTaxe.Montant`, donc les taxes calculées sur quantité ≠ 1.
- `QD_Write` modifie le montant au lieu de la quantité ; `Arr_Read` ne gère pas les arrondis
  au 1/10 000.
- Comparaisons Float strictes et conversions Float → String fragiles dans l'arrondi.
- `Internal_Test` existant sans assertion : la classe n'est aujourd'hui **pas testée**.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 518 |
| Lignes de commentaire | 31 |
| Fonctions | 50 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 124 |
| Complexité max (fonction) | 21 (`Conv_Brut_Net_HT_TTC`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 tests `gbtest` prévus (LPRIX-T01 à T14) : conversions d'entrée, formats, arrondis, matrice
Brut/Net × HT/TTC, cumuls, taxes, événement `change` et performance. Ce sont des tests de
caractérisation : ils figent le comportement actuel, anomalies comprises, avec des valeurs
attendues produites dans le clone Laurux non modifié.

## Rework

9 étapes sans changement de comportement (LPRIX-001 à 009) : documentation, suppression du code
mort `_get`/`_put`, factorisation des accesseurs, des boucles de taxes et des cumuls, séparation de
`Message.Error`, réduction de portée de 8 membres, helper commun avec `LTaxe`. 4 anomalies
(LPRIX-A01 à A04) sont soumises à validation utilisateur.
