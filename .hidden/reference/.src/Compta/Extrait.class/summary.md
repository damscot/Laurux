# Extrait — Synthèse

> Source : `.src/Compta/Extrait.class` · Synthèse des autres documents.

## Rôle

Consultation des extraits de compte (grand livre) : choix du type et du compte, navigation,
périodes (exercice courant, de bilan, N-1 à N-5), filtres de lettrage, tris, vue centralisée par
mois, impression PDF, accès à la modification d'écriture, au lettrage et à la GED.

## Points clés

- 55 fonctions dont 52 `Public` ; `_New` et `affichage` à CC 31 ; `cpt_LF` à CC 30.
- Lecture des écritures déléguée à `Listextcpt` (multi-tables `Fiches_Mvt*`).
- Vue centralisée via une table physique `Ctrln` recréée à chaque affichage.
- Forte duplication interne : 8 handlers de tri, 4 handlers de type, 2 boucles de période.
- Code mort : `Compdate`, `compdate2`, une quinzaine de membres.
- `Bsel`/`Bval` écrits par `TriCpt` via `Object.SetProperty` (faux positif de portée).

## Dépendances principales

- Utilise : `Listextcpt`, `LDate`, `Utils`, `TriCpt`, `Lettrage`, `Saisecrit`, `Tresor`, `LGed`,
  `Visualiseur`, `ProgBar`, `Journaux` (auto-instance).
- Utilisé par : `Fmenu`, `Saisecrit`, `Tresor`, `FClient`.

## Risques

- Totaux « période » faux en vue centralisée (A01) ; `Ctrln` incompatible SQLite et partagée
  entre postes (A02).
- Saisie de compte concaténée dans le SQL (A03).
- Dépendance cachée à l'auto-instance `Journaux` (A05).
- Tests dépendants de la date du jour (périodes) : horloge figée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1127 |
| Lignes de commentaire | 157 |
| Fonctions | 55 |
| Fonctions Public | 52 |
| Complexité cyclomatique totale | 236 |
| Complexité max (fonction) | 31 (`_New`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 replays (EXTRAIT-T01 à T13 : ouverture, navigation, types, lettrage, tris, exercices,
centralisation, saisie de compte, modification, impression, colonnes, ouverture depuis
`FClient`, SQLite) et 1 gbtest (T14) sur les cumuls extraits.

## Rework

11 étapes (EXTRAIT-001 à 011) : documentation, code mort, dates via `LDate`, factorisation des
handlers de tri et de type, simplification de `_New`, `affichage`, `cpt_LF`, séparation
traitement/GUI, `Cbase.Table`, réduction de portée. 8 anomalies (EXTRAIT-A01 à A08).
