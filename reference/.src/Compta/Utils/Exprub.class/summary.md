# Exprub — Synthèse

> Source : `.src/Compta/Utils/Exprub.class` · Synthèse des autres documents.

## Rôle

Utilitaire d'export du paramétrage des éditions comptables : écrit `~/Bcr.txt` (rubriques) et
`~/Bcrcpt.txt` (plages de comptes des rubriques `L`), relus par l'import de `Rubresult`. Lancé
depuis « Appel programme » (`Prgm`, nom `Exprub`).

## Points clés

- Une seule méthode `Static run`, sans formulaire.
- Lecture seule de `Fiches_Rubriques` et `Fiches_RubCompt` ; une requête par rubrique `L`.
- Avertissement avant écrasement des fichiers, message de fin.
- Six variables `Static` de classe qui ne servent que dans `run`.

## Dépendances principales

- Appelé par : `Prgm.Button1_Click` (`Prgm.class:58`).
- Utilise : `Utils.db`, `User.Home`.
- Couplage par format de fichier avec `Rubresult.BcrSelect_Activate` (invisible pour `deps.py`).

## Risques

- Format sans échappement (`;` dans un intitulé, A01).
- Représentation du drapeau `amortissement` dépendante du moteur (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 5 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 9 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (EXPRUB-T01 à T05) : 4 replays (export complet, refus, valeurs particulières, SQLite)
comparant le contenu des fichiers, 1 gbtest sur `Exporte` après extraction. T01 alimente le test
d'aller-retour RUBRESULT-T04.

## Rework

5 étapes (EXPRUB-001 à 005) : documentation, variables locales, séparation traitement/GUI, module
commun d'export/import avec `Rubresult`, clés `Cbase`. 2 anomalies (A01, A02).
