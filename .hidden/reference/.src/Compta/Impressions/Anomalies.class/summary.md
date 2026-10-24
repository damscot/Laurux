# Anomalies — Synthèse

> Source : `.src/Compta/Impressions/Anomalies.class` · Synthèse des autres documents.

## Rôle

Écran « Anomalies des clés » : contrôle d'inaltérabilité des écritures. Pour un exercice (N à N-5)
et une plage de dates, il recalcule la clé SHA-1 de chaque ligne (`Sha1Calc`) et imprime en PDF
les écritures dont la clé mémorisée diffère.

## Points clés

- Boucle de vérification et impression `Ccompta` dans `Button2_Click`, avec `ProgBar`
  interruptible ; une requête de vérification par ligne.
- Requête morte `SELECT * FROM Fiches_Mvt` en tête du traitement.
- `Exercice_Begin`/`Exercice_End` dupliquent `LDate.Exercice_Cloture`/`Exercice_Debut`.

## Dépendances principales

- Utilise : `Sha1Calc`, `Ccompta`, `ProgBar`, `Visualiseur`, `Utils.db`, `Utils.Cdate_Dbase`,
  `Cbase.Table("TabParam")` ; tables `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_Parametres`.
- Utilisé par : `Fmenu.Menu324_Click`.

## Risques

- Rapport faux pour N-1…N-5 : la clé calculée affichée vient toujours de `Fiches_Mvt` (A01).
- Message d'erreur trompeur, silence sur plage vide.
- Lent sur gros exercices (lecture complète inutile + une requête par ligne).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 109 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 9 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (ANOMALIES-T01 à T04 : dates, exercice N, N-1, cas limites) sur un jeu où des clés
ont été altérées, comparaison du texte PDF ; 1 test `gbtest` (T05) des dates d'exercice.

## Rework

5 étapes (ANOMALIES-001 à 005) : documentation, code mort (dont la requête inutile), bascule sur
`LDate`, en-tête factorisé, séparation de la sélection. 3 anomalies (A01 à A03).
