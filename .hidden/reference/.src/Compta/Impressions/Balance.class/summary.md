# Balance — Synthèse

> Source : `.src/Compta/Impressions/Balance.class` · Synthèse des autres documents.

## Rôle

Écran d'édition des **balances comptables** (Comptabilité > Impressions > Balances) : balance client,
fournisseur ou générale (gestion + bilan), sur l'exercice courant, l'exercice précédent non archivé
ou les exercices archivés N-1 à N-5 (`Fiches_Mvt` … `Fiches_Mvt5`). L'impression PDF est déléguée à
`BalanceM.Imprime` ; l'export texte (`~/balances.txt`) est codé dans l'écran.

## Points clés

- Bornes d'exercice lues dans `Fiches_Parametres.dteclec*` par 7 fonctions quasi identiques
  (`Ex1`, `Exo`, `Exo1`…`Exo5`), dupliquées dans 8 autres écrans de `Compta/Impressions`.
- Les commentaires du source inversent « exercice en cours » et « exercice en cours de bilan » :
  `E0` → `Ex1` (début d'exercice → aujourd'hui), `E1` → `Exo` (exercice précédent).
- Contrôles de date seulement au clavier (`Bal_KeyPress` → `dteN0_LF`/`dteN1_LF`).
- Export : requête client/fournisseur cassée (alias `Fiches_Cli`), requête générale sans parenthèses ;
  la moitié des calculs de `Button2_Click` ne sont jamais écrits.
- `Bsel`/`Bval` sont écrits par `TriCpt` (`Object.SetProperty`) : `Public` nécessaire.

## Dépendances principales

- Appelée par `Fmenu.Menu31_Click` (auto-instance) ; `BalanceM` modifie `Balance.Mouse`.
- Utilise `BalanceM`, `TriCpt`, `TypeClient`, `Utils` (dates, `db`), `Cbase`, `Editeur`, `Doc`.
- Tables (lecture seule) : `Fiches_Parametres`, `Fiches_Comptes`, `Fiches_Mvt*`, `Fiches_Societes`,
  `Fiches_Cli`.

## Risques

- **BALANCE-A01** : l'export de la balance client ou fournisseur échoue toujours (erreur SQL
  `cli_code`, l. 647).
- **BALANCE-A02** : l'export de la balance générale inclut tous les comptes de bilan, hors plage.
- Après une date hors période, la période revient sur l'exercice précédent alors que « Exercice en
  cours » est coché (A04).
- Aucun test existant ; aucune donnée d'écriture dans `Laurux01.sql`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 102 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 20 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (BALANCE-T01 à T10) : bornes d'exercice (avec horloge fixée), natures de balance,
contrôles de date, exports (générale, client en erreur, comptes non mouvementés, vide) et sélection
par `TriCpt`. Le rendu PDF est couvert par BALANCEM. Jeu de données dérivé commun aux éditions
comptables (écritures sur plusieurs exercices, clients typés, compte collectif, saut de page).

## Rework

8 étapes sans changement de comportement (BALANCE-001 à 008) : documentation, code mort de l'export,
fusion des fonctions de bornes, helper commun de bornes et de contrôle de date (phase 3, 9 fichiers),
séparation de l'export, réduction de portée de 11 membres, passage du filtre client en chaîne à
`BalanceM`. 5 anomalies (BALANCE-A01 à A05) soumises à validation.
