# Sailig — Synthèse

> Source : `.src/Utils/Sailig.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ligne de saisie de la grille `SaiTableau` : un `Panel` de contrôles créés à partir d'`ObjProp`,
chaînés pour la navigation, avec un prix (`LPrix`), une taxe (`LTaxe`) et des objets associés ;
traduction du clavier en événements (retour ligne, insertion, suppression, déplacement).

## Points clés

- Aucun SQL ; composant graphique.
- `groupe_keypress` concentre la complexité (CC 27).
- Tous les membres publics sont utilisés par `SaiTableau`, `Achat`, `GesTar`, `Parametre`,
  `VarMajTar` (aucune réduction de portée possible).
- Événements `ctrl`/`alt` levés mais traités nulle part.

## Dépendances principales

- Utilise `ObjProp`, `chainage`, `TextReg`, `LPrix`, `LTaxe`.
- Dépendance circulaire avec `SaiTableau` (même lot de rework).

## Risques

- Cas `ObjProp.TextBox` probablement en erreur (`chain.add` sans tableau), inutilisé aujourd'hui.
- Drapeau `valide` remis à `False` à chaque perte de focus : la notion de « ligne modifiée » est
  approximative pour les appelants.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 200 |
| Lignes de commentaire | 1 |
| Fonctions | 15 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 68 |
| Complexité max (fonction) | 27 (`groupe_keypress`) |
| Variables globales | 0 |
| Variables Public | 9 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (SAILIG-T01 à T05) : 4 gb.test sous affichage virtuel (construction, cas TextBox, propriétés,
suppression) et un replay clavier via l'écran Achat.

## Rework

5 étapes (SAILIG-001 à 005) : documentation, code mort, factorisation du clavier, table de création
des contrôles, fonction pure de décision clavier. 2 anomalies (SAILIG-A01, A02).
