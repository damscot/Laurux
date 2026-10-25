# Tchauffeur — Synthèse

> Source : `.src/Gestion/option/Tchauffeur.class` · Synthèse des autres documents.

## Rôle

Ébauche d'écran « Fiche chauffeurs » (code, nom, prénom, date d'entrée, adresse) avec une barre
`Barselection`. L'écran n'est ouvert nulle part et n'a pas de table associée.

## Points clés

- 2 fonctions : `_new` (création de la barre `bar1`) et `TextBox7_KeyPress` (vide).
- Aucun handler `bar1_*` : les boutons de la barre ne font rien.
- Aucune table `Fiches_Chauffeurs` dans le schéma.
- Vestige de l'option tournées/livraisons, dont seuls `Ttourne` et `rechtour` sont raccordés.

## Dépendances principales

- Utilise : `Barselection`.
- Utilisé par : personne (vérifié par `grep`).

## Risques

Aucun risque d'exécution, puisque l'écran est inatteignable. Le seul coût est la maintenance d'un
couple mort.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 6 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (TCHAUFFEUR-T01) : contrôle statique de l'absence d'appelant. Pas de replay possible.

## Rework

1 étape (TCHAUFFEUR-001, documentation). 1 anomalie (TCHAUFFEUR-A01) : suppression du couple
`.class` + `.form` mort, soumise à validation utilisateur.
