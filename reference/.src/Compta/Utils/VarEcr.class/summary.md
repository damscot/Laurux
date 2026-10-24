# VarEcr — Synthèse

> Source : `.src/Compta/Utils/VarEcr.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Structure d'entrée du moteur d'écritures automatiques (`EcrAuto`, `EcrReg`) : à la fois une ligne
d'écriture (compte, dates `LDate`, montants, état, type…) et un conteneur énumérable de lignes.

## Points clés

- Énumérations d'état (`L_sans` … `L_caisse`) et de type (`Autre`, `Treso`, `Vente`, `Caisse`) aux
  valeurs entières communes (inversion sans effet dans `ObjFac:990-991`).
- `somme()` : contrôle d'équilibre (hors lignes collectives et supprimées), arrondi à 2 décimales.
- L'objet racine s'ajoute souvent lui-même comme ligne.

## Dépendances principales

- Utilise : `Utils.arrondi`, `LDate`.
- Utilisé par : `EcrAuto`, `EcrReg`, `SaiReg`, `ValidBR1`, `ObjFac`, `Moulinage`, `EdReg`, `ObjFacB`,
  `commande1`.

## Risques

- Double rôle ligne/conteneur difficile à suivre ; chaque ligne alloue des tableaux inutiles.
- `_put` faux mais inutilisé ; `trouve` au type de retour variable.
- `deps.py` lui attribue à tort des membres de `LGed` (`ObjFac`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 110 |
| Lignes de commentaire | 1 |
| Fonctions | 13 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 28 |
| Complexité max (fonction) | 4 (`somme`) |
| Variables globales | 0 |
| Variables Public | 19 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `gbtest` (VARECR-T01 à T06) couvrant conteneur, énumération, recherche, somme, lettrage.

## Rework

2 étapes (documentation, code mort `_put`/`_new`) ; 1 anomalie (VARECR-A01). La séparation
ligne/conteneur est notée comme piste à long terme.
