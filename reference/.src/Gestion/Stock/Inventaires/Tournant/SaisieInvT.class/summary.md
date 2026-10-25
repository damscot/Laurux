# SaisieInvT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Saisie des comptages de l'inventaire tournant dans `Fiches_InvT` : mêmes fonctions que
`SaisieInv` (n° de ligne ou code, cumul/remplacement, rappel, suppression, import portable).

## Points clés

- Copie à 93 % de `SaisieInv` ; différences : table, `Colinv_Activate` sur `Item`, import sans
  contrôle du fichier, test `cle <> 0`, `Button3_Click` mort (groupe `btn`).
- Rappel d'une ligne au double-clic seulement (pas d'Entrée).

## Dépendances principales

- Comme `SaisieInv` ; appelé par `Fmenu.Menu96_Click` ; tables `Fiches_InvT`, `Fiches_Art`.

## Risques

- Anomalies héritées de SaisieInv (A01-A07) et propres à la variante (A08 ligne rappelée, A09
  fichier d'import absent, A10 quantité vide).
- Rejeu : grille sans `Colinv_Click`, rappel au double-clic difficilement rejouable.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 418 |
| Lignes de commentaire | 49 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 23 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

15 `replay` + 1 `gbtest` (SAISIEINVT-T01 à T16), alignés sur SaisieInv plus les cas propres.
**Liste à valider par l'utilisateur avant la phase 2** (module complexe).

## Rework

7 étapes (SAISIEINVT-001 à 007) dont la suppression de `Button3_Click` et le passage au module
`Inventaire`. 10 anomalies (SAISIEINVT-A01 à A10).
