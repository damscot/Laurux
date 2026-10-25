# barselection — Synthèse

> Source : `.src/Gestion/option/barselection.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Barre d'actions des écrans de saisie de tables (navigation, création, modification, suppression,
sortie, recherche) construite par code dans un conteneur de l'appelant ; lève des événements et
gère le passage en mode validation (Annuler/Valider).

## Points clés

- Chaîne `choix` de 9 caractères pour choisir les boutons ; classe `Export`, sans SQL.
- Cycle partagé par `Mreglement`, `Tconsigne`, `Ttourne`, `Tregie`, `Tregion`, `Tchauffeur`
  (ce dernier sans aucun gestionnaire).
- `valide`/`annule` respectent `Stop Event` ; `creer`/`modif`/`suprimer` non.
- `efface` vide tout le conteneur reçu.

## Dépendances principales

- Utilisé par : les six écrans ci-dessus (`As "bar1"`, propriétés `estcreer`/`estmodif`).
- N'utilise aucune autre classe du projet.

## Risques

- A01 : mode validation sans opération en cours si l'appelant refuse l'action.
- Rejeu des boutons créés par code sans nom à vérifier.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 173 |
| Lignes de commentaire | 1 |
| Fonctions | 10 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 10 (`affichechoix`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (BARSELECTION-T01 à T04) sur `Tconsigne` et `Mreglement` : navigation,
création, modification/suppression, refus de l'appelant.

## Rework

2 étapes (BARSELECTION-001, 002) : documentation du cycle et boucle de création des boutons.
1 anomalie. La factorisation du cycle transactionnel des appelants est portée par MREGLEMENT-006.
