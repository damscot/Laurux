# Tconsigne — Synthèse

> Source : `.src/Gestion/option/Tconsigne.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de paramétrage des **consignes d'emballages** (option boissons) : une fiche par code de
`Fiches_consigne` (libellé, prix, type palette/caisse/bouteille). Ouvert par `menuopt` et par la
fiche article d'option `artopt`.

## Points clés

- Barre d'actions `barselection` (9 boutons) : transaction ouverte à la création/modification,
  `Commit` à la validation, `Rollback` à l'annulation, relecture et repositionnement sur `$ind`.
- Le second paramètre de `bar1_valide`/`bar1_annule` est le drapeau « modification » (nommé `anul`).
- Code unique et non vide ; suppression non implémentée malgré le bouton affiché.
- Recherche par `rechcons` (mode `"T"`).

## Dépendances principales

- Utilise : `barselection`, `rechcons`, `Utils.db`, `Utils.Observers`.
- Utilisé par : `menuopt` (`.Show`), `artopt` (`.ShowModal`).
- Prix lus par `Consigne`, `Saisiedecons`, `facopt`.

## Risques

- `form_Close` appelle `bar1_valide` sans argument : « Not enough arguments » (vérifié `gbs3`).
- Transaction laissée ouverte si l'on ferme pendant une saisie.
- Position affichée après validation incorrecte (`$ind`), boucle de recherche sans fin de résultat.
- Table créée à l'exécution par `modfichier` (absente de `db_control.csv`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 2 |
| Fonctions | 20 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 7 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (TCONSIGNE-T01 à T06) : navigation, création, création refusée, modification,
recherche, fermeture pendant une saisie ; dump de `Fiches_consigne`, jeu dérivé `option_boisson`.

## Rework

4 étapes (TCONSIGNE-001 à 004) : documentation, relecture factorisée, contrôle d'unicité séparé,
cycle de barre commun avec `Mreglement`/`Tregie`/`Ttourne`/`Tregion`/`Tchauffeur`. 4 anomalies
(A01 fermeture, A02 transaction, A03 suppression absente, A04 positionnement/recherche).
