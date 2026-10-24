# EdNlettrees — Synthèse

> Source : `.src/Compta/Impressions/EdNlettrees.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Impression des écritures non lettrées » (menu Compta, deux entrées) : pour une plage de
comptes clients, fournisseurs ou de bilan lettrables (optionnellement restreinte à des types de
clients), impression des écritures non lettrées entre deux dates, avec soldes progressifs et
totaux. PDF `~/tmp/Enlettrees.pdf` (`Ccompta`).

## Points clés

- Lecture des écritures par `Listextcpt` (option `"n"`) : seule édition du lot qui couvre
  plusieurs exercices (`Fiches_Mvt` à `Fiches_Mvt5`).
- Successeur d'`EdImpayes` (même en-tête, même PDF, même aide).
- Six méthodes `Draw` héritées jamais appelées ; variables mortes de la branche « centralisateur ».
- `Bsel`/`Bval` publics écrits par `TriCpt` (`Object.SetProperty`) : à garder `Public`.
- Contrôles de saisie dans le groupe `Cmpt` : validation des dates seulement sur Entrée/Tab.

## Dépendances principales

- Appelé par `Fmenu.Menu103_Click` et `Fmenu.Menu106_Click`.
- Utilise `Listextcpt`, `TypeClient`, `TriCpt`, `Ccompta`, `Utils.Cdate_*`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Comptes`, `Fiches_Cli`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Mvt*`
  (via `Listextcpt`), `Fiches_Typec` (via `TypeClient`).

## Risques

- Date saisie non normalisée si l'on clique directement sur « Imprimer » (A01).
- Comptes centralisateurs imprimés sans lignes et avec un total nul (A02).
- PDF vide sans message si aucune écriture ; nom de PDF partagé avec `EdNjustifiees` (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 424 |
| Lignes de commentaire | 75 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 17 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests (EDNLETTREES-T01 à T11) : 10 replays (ouverture, clients, fournisseurs/bilan, type de
clients — rejouabilité de `TypeClient` à valider —, multi-exercices, centralisateur, `TriCpt`,
cas vides, multipage, SQLite) avec PDF comparé après `pdftotext` et normalisation ; 1 `gbtest`
sur `Lignes_Compte`. Jeu dérivé commun des éditions comptables + `faketime`.

## Rework

7 étapes (EDNLETTREES-001 à 007) : documentation, code mort (méthodes `Draw`, variables),
initialisation unique, requête de comptes et saut de page factorisés, réduction de portée,
séparation calcul/affichage, socle commun et sélection de plage de comptes partagés avec
`EdNjustifiees`. 3 anomalies (EDNLETTREES-A01 à A03).
