# EdNjustifiees — Synthèse

> Source : `.src/Compta/Impressions/EdNjustifiees.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Impressions des écritures non justifiées » (menu Compta) : pour une plage de comptes
clients ou fournisseurs, imprime les comptes dont le solde mémorisé (`Fiches_Comptes.solde`)
diffère du total des écritures validées non lettrées de `Fiches_Mvt`, avec le détail de ces
écritures. PDF `~/tmp/Enlettrees.pdf` (`Ccompta`).

## Points clés

- Pas de période : exercice en cours seulement, en-tête « du <date du jour> ».
- Comparaison par chaînes formatées `",0.00"`.
- Variante d'`EdNlettrees` (sélection de plage de comptes, `TypeClient`, `TriCpt`), avec un
  `Cmpt_KeyPress` mal adapté (F2 inopérant).
- Cumuls calculés mais jamais imprimés ; `Ctrln` nommé sans usage.

## Dépendances principales

- Appelé par `Fmenu.Menu252_Click`.
- Utilise `Utils.db`, `Cbase.Table`, `TypeClient`, `TriCpt`, `Ccompta`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Societes` (+ `Fiches_Typec`).

## Risques

- F2 ne fonctionne pas dans les champs de compte (A01).
- Périmètre limité à `Fiches_Mvt`, pas de total par compte, PDF vide sans message, nom de PDF
  partagé (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 249 |
| Lignes de commentaire | 58 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 16 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (EDNJUSTIFIEES-T01 à T08) : 7 replays (clients, fournisseurs, type de clients —
rejouabilité de `TypeClient` à valider —, cas vides, F2, arrondi de comparaison, multipage), PDF
comparé après `pdftotext` et normalisation ; 1 `gbtest` sur `Compte_Non_Justifie`. Jeu dérivé
commun des éditions comptables + soldes mémorisés volontairement faux, `faketime`.

## Rework

6 étapes (EDNJUSTIFIEES-001 à 006) : documentation, code mort, saut de page et requête factorisés,
réduction de portée, séparation calcul/affichage, socle commun et sélection de comptes partagés
avec `EdNlettrees`. 2 anomalies (EDNJUSTIFIEES-A01, A02).
