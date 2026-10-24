# LTaxe — Synthèse

> Source : `.src/Utils/LTaxe.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet valeur « taxe ou remise » rattaché à `LPrix` : montant fixe ou pourcentage, type (TVA,
Remise, DA, SS, Régie, Consigne, Marge…), compte de ventilation. Sa méthode `Montant(prix)` calcule
la valeur de la taxe (sur HT, ou extraite d'un TTC), utilisée par les conversions Brut/Net × HT/TTC
de `LPrix`.

## Points clés

- `Create Static` + `Inherits Array` (héritage inutilisé) ; usage par `New LTaxe(montant, type)`.
- Calcul pur, sans base ; couplage GUI limité à deux `Message.Error` (type ou compte TVA invalide).
- Convention : les remises (`Remise`, `Deconsigne`) sont stockées en **négatif** (inversion dans
  `Ttx_Write`).
- `All_Taxes` / `All_Remises` classent les types entre Brut→Net et HT→TTC.
- Propriété `Lib` et événement `change` sans aucun usage.

## Dépendances principales

- Utilise : `LPrix` (fabrique et propriétés), `Utils.FloatParse`.
- Utilisé par `LPrix` (circulaire) et 12 fichiers de gestion : `calculdroit1`, `GesTar`, `Achat`,
  `TarTypeCli`, `VarMajTar`, `DateTar`, `Consigne`, `ValidBR1`…

## Risques

- **Couplage avec l'anomalie LPRIX-A01** : `Montant` renvoie le total en `Mnt` avec une quantité
  que `LPrix._call` ignore. Corriger `LPrix._call` seul appliquerait la quantité deux fois
  (`ValidBR1:419`). Les deux corrections sont liées (LTAXE-A01).
- Inversion de signe répétée si `Ttx` est réaffecté (latent).
- Duplication de la conversion d'entrée avec `LPrix._New`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 13 |
| Fonctions | 8 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `gbtest` prévus (LTAXE-T01 à T10) : conversions d'entrée, signe des remises, type et
compte, `Montant` en pourcentage HT/TTC et fixe, quantité ≠ 1 (anomalie figée), propagation
arrondi/compte, listes statiques. Tests de caractérisation avec valeurs attendues produites dans
le clone non modifié.

## Rework

7 étapes sans changement de comportement (LTAXE-001 à 007) : documentation, helper commun
`Utils.VariantToFloat` (avec LPRIX-009), extraction du calcul, séparation des validations GUI,
code mort (`Lib`, `Inherits Array`), listes statiques. 3 anomalies (LTAXE-A01 à A03), dont A01 à
traiter conjointement avec LPRIX-A01.
