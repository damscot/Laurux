# AffRdv — Synthèse

> Source : `.src/Utils/AffRdv.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Rappel des rendez-vous de l'agenda : appelé chaque minute par le timer du menu principal, annonce
l'action prévue à l'heure courante pour l'utilisateur (voix + message).

## Points clés

- `Calc_Timer` (Public, appelé par `Fmenu`) suspend le timer pendant l'affichage.
- `Aff_Rdv` : SQL paramétré sur `Fiches_Agenda`, première ligne seulement, `Catch` vide.
- Requête identique dans `Agenda.class`.

## Dépendances principales

- `Fmenu` (timer), `Syntheses`, `Utils.db`, `Cbase` ; table `Fiches_Agenda`.

## Risques

- Erreurs masquées ; double annonce possible (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`Aff_Rdv`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` (AFFRDV-T01, T02) avec heure figée.

## Rework

3 étapes (AFFRDV-001 à 003) : documentation, `Aff_Rdv` en `Private`, séparation traitement/GUI.
1 anomalie (AFFRDV-A01).
