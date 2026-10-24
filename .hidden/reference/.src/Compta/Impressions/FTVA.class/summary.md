# FTVA — Synthèse

> Source : `.src/Compta/Impressions/FTVA.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Récapitulatif TVA » (menu Compta) : soldes des comptes de TVA déductible (`4456%`) et
collectée (`4457%`) sur un mois, un trimestre ou une année civile, calcul de la TVA à déclarer, et
impression `~/tmp/TVA.pdf` (classe `Cbalances`) ouverte par `Visualiseur.Prog`.

## Points clés

- Lecture seule de `Fiches_Mvt` (exercice en cours) filtrée par `month(dte)`/`year(dte)` ; aucun
  filtre `validee`/`provisoire`.
- Trois handlers de période au corps quasi identique ; `Affiche` mêle SQL, cumul et affichage ;
  `button2_Click` (CC 51) recalcule tout pour le PDF avec 5 copies du bloc « saut de page ».
- Beaucoup de code mort : variables jamais lues, requêtes `Fiches_Journaux` ignorées (une par
  écriture), table de travail `Ctrln` recréée mais jamais remplie, trace `Print` sur stdout.
- Option « TVA sur exercice » (`Texercice`) invisible et inachevée.

## Dépendances principales

- Appelé par `Fmenu.Menu263_Click` uniquement.
- Utilise `Utils.db`, `Utils.Cdate_*`, `Utils.cpoint`, `Cbase.Table`, `Cbalances`, `Visualiseur`,
  `Start.Societe`.
- Tables : `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Societes`,
  `Fiches_Journaux` (lu pour rien), `Ctrln` (DDL).

## Risques

- Trimestre par défaut faux en mars et septembre (A01).
- Année N-1 vide après clôture (seule `Fiches_Mvt` est lue, A02).
- « TVA à déclarer » relue par `Val` sur un texte formaté avec séparateur de milliers (A03, à
  confirmer) : montant déclaré potentiellement faux.
- Impression immédiate après ouverture possiblement vide (A05, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 697 |
| Lignes de commentaire | 4 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 133 |
| Complexité max (fonction) | 51 (`button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 tests (FTVA-T01 à T13) : 10 replays (modes mensuel/trimestriel/annuel, détail, impressions
comparées après `pdftotext` et normalisation de la date et de l'utilisateur, année refusée,
trimestre par défaut sous `faketime`, SQLite) et 2 `gbtest` sur les fonctions extraites
(`TvaADeclarer`, `SoldesTVA`). Valeurs attendues capturées dans le clone non modifié.

## Rework

13 étapes (FTVA-001 à 013) : documentation, suppression du code mort (variables, requêtes
inutiles, `Ctrln`), factorisation des trois handlers de période et des sauts de page, réduction de
portée de 5 fonctions, séparation calcul/affichage (`SoldesTVA`, `TvaADeclarer`), `Cbase.Table`,
socle commun des éditions comptables. 6 anomalies (FTVA-A01 à A06) soumises à validation.
